import QtQuick
import Quickshell.Io
import "../components"

Item {
	id: root

	required property QtObject theme

	property string deviceName: "--"
	property string ipAddress: "--"
	property string gateway: "--"
	property bool online: false

	readonly property int filledSegments: online ? 10 : 0
	readonly property string addressMode: online ? "ROUTED" : "OFFLINE"

	function updateStats(): void {
		if (!addressProcess.running)
			addressProcess.exec(addressProcess.command);
	}

	function parseAddress(value: string): void {
		const fields = value.trim().split(/\s+/);
		if (fields.length < 3) {
			online = false;
			deviceName = "--";
			ipAddress = "--";
			gateway = "--";
			return;
		}

		online = true;
		deviceName = fields[0];
		ipAddress = fields[1];
		gateway = fields[2];
	}

	Timer {
		interval: 10000
		running: true
		repeat: true
		triggeredOnStart: true
		onTriggered: root.updateStats()
	}

	Process {
		id: addressProcess

		command: ["bash", "-c", "dev=$(ip route show default 2>/dev/null | awk 'NR==1 {print $5}'); gw=$(ip route show default 2>/dev/null | awk 'NR==1 {print $3}'); ipaddr=$(ip -o -4 addr show dev \"$dev\" 2>/dev/null | awk 'NR==1 {print $4}'); if [ -n \"$dev\" ] && [ -n \"$ipaddr\" ]; then printf '%s %s %s\\n' \"$dev\" \"$ipaddr\" \"${gw:---}\"; else printf '\\n'; fi"]
		stdout: StdioCollector {
			id: addressOutput
			waitForEnd: true
		}
		stderr: StdioCollector {
			waitForEnd: true
		}
		onExited: function(exitCode) {
			if (exitCode === 0)
				root.parseAddress(addressOutput.text);
		}
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "NETWORK ADDRESS"
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
				value: root.online ? "1" : "0"
				unit: "LINK"
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
				name: root.deviceName
				value: root.ipAddress
			}

			StatusLine {
				theme: root.theme
				name: "GW"
				value: root.gateway
			}
		}
	}
}
