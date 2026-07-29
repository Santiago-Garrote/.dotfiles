import QtQuick
import Quickshell
import Quickshell.Io
import "components"
import "providers"

Item {
	id: root

	required property QtObject theme

	property alias ssdHitArea: ssdHitArea
	property alias calloutHitArea: calloutHitArea

	property var manifest: fallbackManifest
	readonly property var fallbackManifest: ({
		"document": {
			"width": 1299,
			"height": 860
		},
		"assets": {
			"base": "runtime/base.svg",
			"ssd": "runtime/storage/ssd.svg",
			"socket": "runtime/storage/socket.svg",
			"activityLed": "runtime/storage/activity-led.svg"
		},
		"storage": {
			"assembled": {
				"ssd": { "x": 90.7433, "y": 445.887, "width": 278.676, "height": 77.6664 },
				"socket": { "x": 355.016, "y": 445.885, "width": 30.5109, "height": 77.4909 },
				"activityLed": { "x": 1258.12, "y": 681.574, "width": 6.3125, "height": 8.5 }
			},
			"exploded": {
				"ssd": { "x": 51.3203, "y": 345.792, "width": 600.184, "height": 167.27 },
				"rotation": 0,
				"scale": 1
			},
			"zOrder": {
				"base": 0,
				"socket": 10,
				"activityLed": 20,
				"ssd": 30,
				"overlay": 40
			},
			"hitArea": { "x": 90.7433, "y": 445.887, "width": 278.676, "height": 77.6664 },
			"callout": { "x": 724, "y": 94, "width": 360, "height": 270 }
		}
	})

	function loadManifest(value: string): void {
		try {
			const parsed = JSON.parse(value);
			if (parsed.system === "storage")
				manifest = parsed;
		} catch (error) {
			console.warn("storage schematic: could not parse visual manifest: " + error);
		}
	}

	StorageInteractionController {
		id: controller
	}

	StorageDataProvider {
		id: storageProvider
		active: controller.storageSelected
	}

	FileView {
		id: manifestFile

		path: Qt.resolvedUrl("../assets/system-schematic/manifest.json").toString().replace("file://", "")
		preload: true
		blockLoading: true
		printErrors: true
		onLoaded: root.loadManifest(text())
		onTextChanged: root.loadManifest(text())
	}

	SchematicRenderer {
		id: renderer

		anchors.fill: parent
		theme: root.theme
		controller: controller
		provider: storageProvider
		manifest: root.manifest
	}

	StorageInfoOverlay {
		id: infoOverlay

		x: renderer.calloutX
		y: renderer.calloutY
		width: renderer.calloutWidth
		height: renderer.calloutHeight
		theme: root.theme
		provider: storageProvider
		visible: controller.storageSelected
		z: root.manifest.storage.zOrder.overlay
	}

	Rectangle {
		id: ssdHoverFrame

		x: renderer.ssdX - 4
		y: renderer.ssdY - 4
		width: renderer.ssdWidth + 8
		height: renderer.ssdHeight + 8
		color: "transparent"
		border.color: root.theme.colors.accent
		border.width: root.theme.borderWidth
		opacity: ssdMouseArea.containsMouse && !controller.storageSelected ? 0.55 : 0
		z: root.manifest.storage.zOrder.ssd + 1

		Behavior on opacity {
			NumberAnimation {
				duration: root.theme.motion.enabled ? 90 : 0
			}
		}
	}

	Item {
		id: ssdHitArea

		x: renderer.ssdX
		y: renderer.ssdY
		width: renderer.ssdWidth
		height: renderer.ssdHeight
		z: root.manifest.storage.zOrder.ssd + 2

		MouseArea {
			id: ssdMouseArea

			anchors.fill: parent
			hoverEnabled: true
			cursorShape: Qt.PointingHandCursor
			onClicked: controller.toggleStorage()
		}
	}

	Item {
		id: calloutHitArea

		x: infoOverlay.x
		y: infoOverlay.y
		width: controller.storageSelected ? infoOverlay.width : 0
		height: controller.storageSelected ? infoOverlay.height : 0
		z: root.manifest.storage.zOrder.overlay + 1
	}
}
