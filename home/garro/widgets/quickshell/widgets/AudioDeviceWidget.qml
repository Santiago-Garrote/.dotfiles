import QtQuick
import Quickshell.Services.Pipewire
import "../components"

Item {
	id: root

	required property QtObject theme

	readonly property var sink: Pipewire.defaultAudioSink
	readonly property var source: Pipewire.defaultAudioSource
	readonly property bool hasSink: sink !== null
	readonly property bool hasSource: source !== null
	readonly property int devicePercent: (hasSink ? 50 : 0) + (hasSource ? 50 : 0)
	readonly property int filledSegments: Math.ceil(devicePercent / 10)
	readonly property string sinkLabel: hasSink ? formatDevice(sink) : "--"
	readonly property string sourceLabel: hasSource ? formatDevice(source) : "--"

	function formatDevice(node: var): string {
		if (node.description !== undefined && node.description.length > 0)
			return node.description;
		if (node.nickname !== undefined && node.nickname.length > 0)
			return node.nickname;
		return node.name !== undefined && node.name.length > 0 ? node.name : "--";
	}

	PwObjectTracker {
		objects: [root.sink, root.source].filter(object => object !== null)
	}

	Column {
		anchors {
			fill: parent
			margins: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "AUDIO DEVICES"
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
				value: root.devicePercent + "%"
				unit: "DEV"
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
				name: "OUT"
				value: root.sinkLabel
			}

			StatusLine {
				theme: root.theme
				name: "IN"
				value: root.sourceLabel
			}
		}
	}
}
