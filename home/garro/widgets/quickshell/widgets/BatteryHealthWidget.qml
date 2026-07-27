import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property string batteryName: "BAT0"
	property int healthPercent: 0
	property string cycleCount: "--"
	property string powerWatts: "--"
	property bool acOnline: false

	readonly property int filledSegments: Math.ceil(healthPercent / 10)
	readonly property string healthMode: healthPercent > 85 ? "NOMINAL" : (healthPercent > 70 ? "WORN" : "DEGRADED")

	function updateStats(): void {
		energyFullFile.reload();
		energyDesignFile.reload();
		cycleFile.reload();
		acFile.reload();
		if (!powerProcess.running)
			powerProcess.exec(powerProcess.command);
	}

	function parseHealth(): void {
		const full = Number.parseInt(energyFullFile.text().trim(), 10);
		const design = Number.parseInt(energyDesignFile.text().trim(), 10);
		if (!Number.isNaN(full) && !Number.isNaN(design) && design > 0)
			healthPercent = Math.max(0, Math.min(100, Math.round((full / design) * 100)));
	}

	function parseCycles(value: string): void {
		const parsed = Number.parseInt(value.trim(), 10);
		cycleCount = Number.isNaN(parsed) ? "--" : parsed.toString();
	}

	function parsePower(value: string): void {
		const microwatts = Number.parseInt(value.trim(), 10);
		powerWatts = Number.isNaN(microwatts) ? "--" : (microwatts / 1000000).toFixed(1);
	}

	function parseAc(value: string): void {
		acOnline = value.trim() === "1";
	}

	Timer {
		interval: 30000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	FileView {
		id: energyFullFile

		path: "/sys/class/power_supply/" + root.batteryName + "/energy_full"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.parseHealth()
		onTextChanged: root.parseHealth()
	}

	FileView {
		id: energyDesignFile

		path: "/sys/class/power_supply/" + root.batteryName + "/energy_full_design"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.parseHealth()
		onTextChanged: root.parseHealth()
	}

	FileView {
		id: cycleFile

		path: "/sys/class/power_supply/" + root.batteryName + "/cycle_count"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.parseCycles(text())
		onTextChanged: root.parseCycles(text())
	}

	Process {
		id: powerProcess

		command: ["cat", "/sys/class/power_supply/" + root.batteryName + "/power_now"]
		stdout: StdioCollector {
			id: powerOutput
			waitForEnd: true
		}
		stderr: StdioCollector {
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parsePower(powerOutput.text);
			else
				root.powerWatts = "--";
		}
	}

	FileView {
		id: acFile

		path: "/sys/class/power_supply/ACAD/online"
		preload: true
		blockLoading: true
		printErrors: false
		onLoaded: root.parseAc(text())
		onTextChanged: root.parseAc(text())
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "BATTERY HEALTH"
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter
			height: 46
			spacing: root.theme.spacing.medium

			SegmentBar {
				theme: root.theme
				filledSegments: root.filledSegments
			}

			MetricReadout {
				theme: root.theme
				value: root.healthPercent + "%"
				unit: "HLTH"
			}
		}

		ReadoutDivider {
			theme: root.theme
		}

		Column {
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: root.theme.spacing.small

			StatusLine {
				theme: root.theme
				name: "MODE"
				value: root.healthMode
			}

			StatusLine {
				theme: root.theme
				name: "PWR"
				value: root.powerWatts + "W " + (root.acOnline ? "AC" : "BAT")
			}

			StatusLine {
				theme: root.theme
				name: "CYCLES"
				value: root.cycleCount
			}
		}
	}
}
