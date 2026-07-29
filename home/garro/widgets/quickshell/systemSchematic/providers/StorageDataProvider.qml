import QtQuick
import Quickshell.Io

Item {
	id: root

	property bool active: false

	property string model: "N/A"
	property string devicePath: "N/A"
	property string filesystemType: "N/A"
	property string rootMountPoint: "/"
	property string totalCapacity: "N/A"
	property string usedCapacity: "N/A"
	property string availableCapacity: "N/A"
	property string usagePercentage: "N/A"
	property string temperature: "N/A"
	property string health: "N/A"
	property string readActivity: "N/A"
	property string writeActivity: "N/A"
	property bool storageActive: false

	property string physicalName: ""
	property string rootSource: ""
	property real previousReadSectors: -1
	property real previousWriteSectors: -1
	property real previousSampleMs: -1
	property bool warnedFindmnt: false
	property bool warnedLsblk: false
	property bool warnedDf: false

	function valueOrNA(value): string {
		if (value === undefined || value === null || String(value).trim() === "")
			return "N/A";
		return String(value).trim();
	}

	function formatBytes(bytes): string {
		const parsed = Number(bytes);
		if (!Number.isFinite(parsed) || parsed < 0)
			return "N/A";

		const units = ["B", "KiB", "MiB", "GiB", "TiB"];
		let value = parsed;
		let index = 0;
		while (value >= 1024 && index < units.length - 1) {
			value = value / 1024;
			index += 1;
		}

		return (index === 0 ? value.toFixed(0) : value.toFixed(1)) + " " + units[index];
	}

	function formatRate(bytesPerSecond): string {
		const parsed = Number(bytesPerSecond);
		if (!Number.isFinite(parsed) || parsed < 0)
			return "N/A";
		if (parsed >= 1048576)
			return (parsed / 1048576).toFixed(1) + " MiB/s";
		if (parsed >= 1024)
			return (parsed / 1024).toFixed(1) + " KiB/s";
		return Math.round(parsed) + " B/s";
	}

	function mountMatchesRoot(value): bool {
		if (Array.isArray(value))
			return value.indexOf("/") !== -1;
		return value === "/";
	}

	function pathMatchesRootSource(value): bool {
		return rootSource !== "" && valueOrNA(value) === rootSource;
	}

	function findRootDevice(devices, parents) {
		for (const device of devices) {
			const chain = parents.concat([device]);
			if (mountMatchesRoot(device.mountpoint) || pathMatchesRootSource(device.path))
				return {
					root: device,
					chain: chain
				};

			if (device.children !== undefined) {
				const child = findRootDevice(device.children, chain);
				if (child !== null)
					return child;
			}
		}

		return null;
	}

	function collectDisks(device, disks): void {
		if (device.type === "disk")
			disks.push(device);

		if (device.children !== undefined) {
			for (const child of device.children)
				collectDisks(child, disks);
		}
	}

	function parseFindmnt(value: string): void {
		const fields = value.trim().split(/\s+/);
		if (fields.length < 1)
			return;

		rootSource = valueOrNA(fields[0]) === "N/A" ? "" : fields[0];
		if (fields.length >= 2)
			filesystemType = valueOrNA(fields[1]);

		updateLsblk();
	}

	function parseLsblk(value: string): void {
		let parsed;
		try {
			parsed = JSON.parse(value);
		} catch (error) {
			if (!warnedLsblk) {
				console.warn("storage schematic: could not parse lsblk JSON: " + error);
				warnedLsblk = true;
			}
			return;
		}

		const found = findRootDevice(parsed.blockdevices || [], []);
		if (found === null) {
			if (!warnedLsblk) {
				console.warn("storage schematic: could not map / to a block device");
				warnedLsblk = true;
			}
			return;
		}

		const disks = found.chain.filter(device => device.type === "disk");
		collectDisks(found.root, disks);
		const physical = disks.length > 0 ? disks[disks.length - 1] : found.chain[0];
		const rootDevice = found.root;

		physicalName = valueOrNA(physical.name) === "N/A" ? "" : physical.name;
		devicePath = valueOrNA(physical.path);
		model = valueOrNA(physical.model);
		filesystemType = valueOrNA(rootDevice.fstype);
		if (filesystemType === "N/A") {
			for (let index = found.chain.length - 1; index >= 0; index -= 1) {
				filesystemType = valueOrNA(found.chain[index].fstype);
				if (filesystemType !== "N/A")
					break;
			}
		}
		rootMountPoint = "/";
		if (totalCapacity === "N/A")
			totalCapacity = formatBytes(physical.size);

		updateDiskStats();
		updateTemperature();
		updateHealth();
	}

	function parseDf(value: string): void {
		const rows = value.trim().split("\n");
		if (rows.length < 2)
			return;

		const fields = rows[1].trim().split(/\s+/);
		if (fields.length < 6)
			return;

		totalCapacity = formatBytes(fields[1]);
		usedCapacity = formatBytes(fields[2]);
		availableCapacity = formatBytes(fields[3]);
		usagePercentage = valueOrNA(fields[4]);
	}

	function parseDiskStats(value: string): void {
		if (physicalName === "")
			return;

		const rows = value.trim().split("\n");
		const now = Date.now();

		for (const row of rows) {
			const fields = row.trim().split(/\s+/);
			if (fields.length < 14 || fields[2] !== physicalName)
				continue;

			const readSectors = Number.parseInt(fields[5], 10);
			const writeSectors = Number.parseInt(fields[9], 10);
			if (Number.isNaN(readSectors) || Number.isNaN(writeSectors))
				return;

			if (previousSampleMs > 0) {
				const seconds = Math.max(1, (now - previousSampleMs) / 1000);
				const readRate = Math.max(0, Math.round(((readSectors - previousReadSectors) * 512) / seconds));
				const writeRate = Math.max(0, Math.round(((writeSectors - previousWriteSectors) * 512) / seconds));
				readActivity = formatRate(readRate);
				writeActivity = formatRate(writeRate);
				storageActive = readRate > 0 || writeRate > 0;
			}

			previousReadSectors = readSectors;
			previousWriteSectors = writeSectors;
			previousSampleMs = now;
			return;
		}

		storageActive = false;
	}

	function updateLsblk(): void {
		if (rootSource !== "" && !lsblkProcess.running)
			lsblkProcess.exec(["lsblk", "-J", "-b", "-s", "-o", "NAME,PATH,TYPE,MODEL,SIZE,FSTYPE,MOUNTPOINT", rootSource]);
	}

	function updateFindmnt(): void {
		if (!findmntProcess.running)
			findmntProcess.exec(findmntProcess.command);
	}

	function updateDf(): void {
		if (!dfProcess.running)
			dfProcess.exec(dfProcess.command);
	}

	function updateDiskStats(): void {
		diskStatsFile.reload();
	}

	function updateTemperature(): void {
		if (physicalName !== "" && !temperatureProcess.running)
			temperatureProcess.exec(["sh", "-c", "for f in /sys/class/block/$1/device/hwmon/hwmon*/temp*_input; do [ -r \"$f\" ] && { cat \"$f\"; exit 0; }; done; exit 0", "storage-temperature", physicalName]);
	}

	function updateHealth(): void {
		if (physicalName !== "" && !healthProcess.running)
			healthProcess.exec(["sh", "-c", "for f in /sys/class/block/$1/device/state; do [ -r \"$f\" ] && { cat \"$f\"; exit 0; }; done; exit 0", "storage-health", physicalName]);
	}

	Timer {
		interval: 30000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateFindmnt()
	}

	Timer {
		interval: root.active ? 5000 : 30000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateDf()
	}

	Timer {
		interval: root.active ? 1000 : 2500
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateDiskStats()
	}

	Timer {
		interval: 60000
		running: root.active
		repeat: true
		triggeredOnStart: true
		onTriggered: {
			root.updateTemperature();
			root.updateHealth();
		}
	}

	Process {
		id: findmntProcess

		command: ["findmnt", "-n", "-o", "SOURCE,FSTYPE", "/"]
		stdout: StdioCollector {
			id: findmntOutput
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseFindmnt(findmntOutput.text);
			else if (!root.warnedFindmnt) {
				console.warn("storage schematic: findmnt exited with code " + exitCode);
				root.warnedFindmnt = true;
			}
		}
	}

	Process {
		id: lsblkProcess

		stdout: StdioCollector {
			id: lsblkOutput
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseLsblk(lsblkOutput.text);
			else if (!root.warnedLsblk) {
				console.warn("storage schematic: lsblk exited with code " + exitCode);
				root.warnedLsblk = true;
			}
		}
	}

	Process {
		id: dfProcess

		command: ["df", "-B1", "-P", "/"]
		stdout: StdioCollector {
			id: dfOutput
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseDf(dfOutput.text);
			else if (!root.warnedDf) {
				console.warn("storage schematic: df exited with code " + exitCode);
				root.warnedDf = true;
			}
		}
	}

	Process {
		id: temperatureProcess

		stdout: StdioCollector {
			id: temperatureOutput
			waitForEnd: true
		}
		onExited: function(exitCode) {
			const raw = temperatureOutput.text.trim();
			if (exitCode === 0 && raw !== "") {
				const millidegrees = Number.parseInt(raw.split(/\s+/)[0], 10);
				root.temperature = Number.isNaN(millidegrees) ? "N/A" : (millidegrees / 1000).toFixed(1) + " C";
			} else {
				root.temperature = "N/A";
			}
		}
	}

	Process {
		id: healthProcess

		stdout: StdioCollector {
			id: healthOutput
			waitForEnd: true
		}
		onExited: function(exitCode) {
			const raw = healthOutput.text.trim();
			root.health = exitCode === 0 && raw !== "" ? raw.toUpperCase() : "N/A";
		}
	}

	FileView {
		id: diskStatsFile

		path: "/proc/diskstats"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.parseDiskStats(text())
		onTextChanged: root.parseDiskStats(text())
	}
}
