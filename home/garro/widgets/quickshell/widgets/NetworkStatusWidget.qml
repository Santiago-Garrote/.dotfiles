import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property string connectionType: ""
	property string connectionName: ""
	property int signalPercent: -1

	readonly property bool connected: connectionType.length > 0
	readonly property string networkMode: connected ? connectionType.toUpperCase() : "OFFLINE"
	readonly property string networkName: connectionName.length > 0 ? connectionName : "--"
	readonly property int displayedPercent: signalPercent >= 0 ? signalPercent : 0
	readonly property string percentText: signalPercent >= 0 ? signalPercent + "%" : "--%"
	readonly property int filledSegments: Math.ceil(displayedPercent / 10)

	function updateStatus(): void {
		if (!statusProcess.running)
			statusProcess.exec(statusProcess.command);
	}

	function parseDeviceStatus(output: string): void {
		const rows = output.trim().split("\n");
		let activeDevices = [];
		let wifiDevice = null;
		let ethernetDevice = null;

		for (const row of rows) {
			const fields = row.split(":");
			if (fields.length < 4)
				continue;

			const deviceType = fields[1];
			const state = fields[2];
			if (deviceType !== "loopback" && state.indexOf("connected") === 0) {
				activeDevices.push({
					type: deviceType,
					name: fields.slice(3).join(":")
				});
				if (deviceType === "wifi" && wifiDevice === null)
					wifiDevice = activeDevices[activeDevices.length - 1];
				if (deviceType === "ethernet" && ethernetDevice === null)
					ethernetDevice = activeDevices[activeDevices.length - 1];
			}
		}

		const active = wifiDevice !== null ? wifiDevice : (ethernetDevice !== null ? ethernetDevice : (activeDevices.length > 0 ? activeDevices[0] : null));

		if (active === null) {
			connectionType = "";
			connectionName = "";
			signalPercent = -1;
			return;
		}

		connectionType = active.type === "wifi" ? "wifi" : active.type;
		connectionName = active.name;

		if (connectionType === "wifi") {
			signalPercent = -1;
			if (!wifiProcess.running)
				wifiProcess.exec(wifiProcess.command);
		} else {
			signalPercent = 100;
		}
	}

	function parseWifiStatus(output: string): void {
		const rows = output.trim().split("\n");

		for (const row of rows) {
			const fields = row.split(":");
			if (fields.length >= 3 && (fields[0] === "yes" || fields[0] === "*")) {
				const parsed = Number.parseInt(fields[1], 10);
				signalPercent = Number.isNaN(parsed) ? -1 : Math.max(0, Math.min(100, parsed));
				connectionName = fields.slice(2).join(":");
				return;
			}
		}

		signalPercent = -1;
	}

	Timer {
		interval: 10000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStatus()
	}

	Process {
		id: statusProcess

		command: ["nmcli", "-t", "-f", "DEVICE,TYPE,STATE,CONNECTION", "device", "status"]
		stdout: StdioCollector {
			id: statusOutput
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseDeviceStatus(statusOutput.text);
			else {
				root.connectionType = "";
				root.connectionName = "";
				root.signalPercent = -1;
			}
		}
	}

	Process {
		id: wifiProcess

		command: ["nmcli", "-t", "-f", "IN-USE,SIGNAL,SSID", "device", "wifi", "list", "--rescan", "no"]
		stdout: StdioCollector {
			id: wifiOutput
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseWifiStatus(wifiOutput.text);
			else
				root.signalPercent = -1;
		}
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		Label {
			anchors.horizontalCenter: parent.horizontalCenter
			theme: root.theme
			text: "NETWORK STATUS"
			textColor: root.theme.colors.accent
			size: root.theme.fontSizes.large
		}

		Row {
			anchors.horizontalCenter: parent.horizontalCenter
			height: 46
			spacing: root.theme.spacing.medium

			Row {
				anchors.verticalCenter: parent.verticalCenter
				spacing: 3

				Repeater {
					model: 10

					Rectangle {
						required property int index

						width: 21
						height: 34
						color: index < root.filledSegments ? root.theme.colors.accent : "transparent"
						border.color: root.theme.colors.accent
						border.width: root.theme.borderWidth
						opacity: index < root.filledSegments ? 0.88 : 0.52
						radius: root.theme.cornerRadius
					}
				}
			}

			Column {
				anchors.verticalCenter: parent.verticalCenter
				spacing: 0

				Label {
					anchors.horizontalCenter: parent.horizontalCenter
					theme: root.theme
					text: root.percentText
					textColor: root.theme.colors.accent
					size: root.theme.fontSizes.large
				}

				Label {
					anchors.horizontalCenter: parent.horizontalCenter
					theme: root.theme
					text: root.connectionType === "wifi" ? "SIG" : "LINK"
					textColor: root.theme.colors.accent
					size: root.theme.fontSizes.small
				}
			}
		}

		Rectangle {
			anchors.horizontalCenter: parent.horizontalCenter
			width: 300
			height: root.theme.borderWidth
			color: root.theme.colors.accent
			opacity: 0.62
		}

		Column {
			anchors.horizontalCenter: parent.horizontalCenter
			spacing: root.theme.spacing.small

			Label {
				anchors.horizontalCenter: parent.horizontalCenter
				theme: root.theme
				text: "MODE: " + root.networkMode
				textColor: root.theme.colors.accent
				size: root.theme.fontSizes.medium
			}

			Label {
				anchors.horizontalCenter: parent.horizontalCenter
				theme: root.theme
				text: "LINK: " + root.networkName
				textColor: root.theme.colors.accent
				size: root.theme.fontSizes.medium
			}
		}
	}
}
