import QtQuick

Item {
	id: root

	required property QtObject theme
	required property QtObject controller
	required property QtObject provider

	property var manifest

	readonly property var storage: manifest.storage
	readonly property real documentWidth: manifest.document.width
	readonly property real documentHeight: manifest.document.height
	readonly property real scaleFactor: Math.min(width / documentWidth, height / documentHeight)
	readonly property real canvasWidth: documentWidth * scaleFactor
	readonly property real canvasHeight: documentHeight * scaleFactor
	readonly property real canvasX: (width - canvasWidth) / 2
	readonly property real canvasY: (height - canvasHeight) / 2
	readonly property bool selected: controller.storageSelected

	readonly property var assembledSsd: storage.assembled.ssd
	readonly property var explodedSsd: storage.exploded.ssd
	readonly property real ssdX: canvasX + (selected ? explodedSsd.x : assembledSsd.x) * scaleFactor
	readonly property real ssdY: canvasY + (selected ? explodedSsd.y : assembledSsd.y) * scaleFactor
	readonly property real ssdWidth: (selected ? explodedSsd.width : assembledSsd.width) * scaleFactor
	readonly property real ssdHeight: (selected ? explodedSsd.height : assembledSsd.height) * scaleFactor
	readonly property real ssdRotation: selected ? storage.exploded.rotation : 0

	readonly property var assembledSocket: storage.assembled.socket
	readonly property var explodedSocket: storage.exploded.socket
	readonly property var socket: selected ? explodedSocket : assembledSocket
	readonly property real socketX: canvasX + socket.x * scaleFactor
	readonly property real socketY: canvasY + socket.y * scaleFactor
	readonly property real socketWidth: socket.width * scaleFactor
	readonly property real socketHeight: socket.height * scaleFactor

	readonly property var assembledActivityLed: storage.assembled.activityLed
	readonly property var explodedActivityLed: storage.exploded.activityLed
	readonly property var activityLed: selected ? explodedActivityLed : assembledActivityLed
	readonly property real activityLedX: canvasX + activityLed.x * scaleFactor
	readonly property real activityLedY: canvasY + activityLed.y * scaleFactor
	readonly property real activityLedWidth: Math.max(5, activityLed.width * scaleFactor)
	readonly property real activityLedHeight: Math.max(5, activityLed.height * scaleFactor)

	readonly property var callout: storage.callout
	readonly property real calloutX: width - calloutWidth - root.theme.spacing.medium
	readonly property real calloutY: height - calloutHeight - root.theme.spacing.medium
	readonly property real calloutWidth: Math.max(320, callout.width * scaleFactor)
	readonly property real calloutHeight: Math.max(210, callout.height * scaleFactor)

	function asset(path: string): string {
		return "../assets/system-schematic/" + path;
	}

	Image {
		id: base

		x: root.canvasX
		y: root.canvasY
		width: root.canvasWidth
		height: root.canvasHeight
		source: root.asset(root.manifest.assets.base)
		fillMode: Image.Stretch
		smooth: true
		opacity: root.selected ? 0.28 : 1

		Behavior on opacity {
			NumberAnimation {
				duration: root.theme.motion.enabled ? 140 : 0
			}
		}
	}

	Image {
		id: socketImage

		x: root.socketX
		y: root.socketY
		width: root.socketWidth
		height: root.socketHeight
		source: root.asset(root.selected ? root.manifest.assets.explodedSocket : root.manifest.assets.socket)
		fillMode: Image.Stretch
		smooth: true
		opacity: root.selected ? 1 : 0.92
		z: root.storage.zOrder.socket

		Behavior on x {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}

		Behavior on y {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}

		Behavior on width {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}

		Behavior on height {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}
	}

	Image {
		id: activityLedImage

		x: root.activityLedX
		y: root.activityLedY
		width: root.activityLedWidth
		height: root.activityLedHeight
		source: root.asset(root.selected ? root.manifest.assets.explodedActivityLed : root.manifest.assets.activityLed)
		fillMode: Image.Stretch
		smooth: true
		opacity: root.selected ? 1 : 0.9
		z: root.storage.zOrder.activityLed

		Behavior on x {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}

		Behavior on y {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}

		Behavior on width {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}

		Behavior on height {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}
	}

	Rectangle {
		x: root.activityLedX - 1
		y: root.activityLedY - 1
		width: root.activityLedWidth + 2
		height: root.activityLedHeight + 2
		color: root.theme.colors.accent
		opacity: root.provider.storageActive ? 0.85 : 0
		radius: 1
		z: root.storage.zOrder.activityLed + 1

		Behavior on opacity {
			NumberAnimation {
				duration: root.theme.motion.enabled ? 80 : 0
			}
		}
	}

	Image {
		id: ssdImage

		x: root.ssdX
		y: root.ssdY
		width: root.ssdWidth
		height: root.ssdHeight
		rotation: root.ssdRotation
		source: root.asset(root.selected ? root.manifest.assets.explodedSsd : root.manifest.assets.ssd)
		fillMode: Image.Stretch
		smooth: true
		z: root.storage.zOrder.ssd

		Behavior on x {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}

		Behavior on y {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}

		Behavior on width {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}

		Behavior on height {
			NumberAnimation { duration: root.theme.motion.enabled ? 220 : 0; easing.type: Easing.InOutQuad }
		}
	}

	Repeater {
		model: root.selected ? [
			[root.manifest.assets.socketLabel, root.storage.exploded.labels.socket],
			[root.manifest.assets.activityLabel, root.storage.exploded.labels.activityLed],
			[root.manifest.assets.ssdLabel, root.storage.exploded.labels.ssd]
		] : []

		delegate: Image {
			required property var modelData

			x: root.canvasX + modelData[1].x * root.scaleFactor
			y: root.canvasY + modelData[1].y * root.scaleFactor
			width: modelData[1].width * root.scaleFactor
			height: modelData[1].height * root.scaleFactor
			source: root.asset(modelData[0])
			fillMode: Image.Stretch
			smooth: true
			opacity: root.selected ? 1 : 0
			z: root.storage.zOrder.overlay - 1
		}
	}
}
