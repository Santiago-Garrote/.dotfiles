import QtQuick
import KvitTerm
import "../components"

Item {
	id: root

	required property QtObject theme

	readonly property int framePadding: root.theme.spacing.medium
	readonly property int terminalWidth: 640
	readonly property int terminalHeight: 360

	Column {
		anchors {
			horizontalCenter: parent.horizontalCenter
			bottom: frame.top
			bottomMargin: root.theme.spacing.medium
		}
		spacing: root.theme.spacing.small

		ReadoutTitle {
			theme: root.theme
			title: "TERMINAL"
			titleSize: root.theme.fontSizes.small
		}

		ReadoutDivider {
			theme: root.theme
			dividerWidth: root.terminalWidth
		}
	}

	// Oscilloscope-frame treatment matching PointerCoordinatesWidget's grid:
	// a thin outline (no fill) around the content, corner-bracket reticle
	// accents, and a faint scanline texture for the CRT/VFD read on it.
	Item {
		id: frame

		anchors.centerIn: parent
		width: root.terminalWidth + root.framePadding * 2
		height: root.terminalHeight + root.framePadding * 2

		Rectangle {
			anchors.fill: parent
			color: "transparent"
			border.color: root.theme.colors.accent
			border.width: root.theme.borderWidth
			opacity: 0.5
		}

		TerminalView {
			id: terminal

			anchors.centerIn: parent
			width: root.terminalWidth
			height: root.terminalHeight

			font.family: root.theme.fonts.monospace
			font.pointSize: root.theme.fontSizes.medium

			// No panel fill: text sits directly on the desktop background,
			// same as every other widget here.
			palette: TerminalPalette {
				background: "transparent"
				foreground: root.theme.colors.foreground

				// A monochrome-amber ANSI palette so default shell coloring
				// (e.g. bash's green user@host prompt) doesn't clash with
				// the rest of the theme; red is kept distinct since it's
				// the one color meant to still read as a deliberate signal
				// (errors).
				ansiColors: [
					root.theme.colors.background,
					root.theme.colors.error,
					root.theme.colors.accent,
					root.theme.colors.accent,
					root.theme.colors.muted,
					root.theme.colors.accent,
					root.theme.colors.muted,
					root.theme.colors.foreground,
					root.theme.colors.border,
					root.theme.colors.error,
					root.theme.colors.accent,
					root.theme.colors.accent,
					root.theme.colors.muted,
					root.theme.colors.accent,
					root.theme.colors.muted,
					root.theme.colors.foreground
				]
			}

			session: TerminalSession {
				scrollbackLimit: 10000
			}
		}

		Repeater {
			model: Math.floor(frame.height / 4)

			Rectangle {
				x: 0
				y: index * 4
				width: frame.width
				height: root.theme.borderWidth
				color: root.theme.colors.accent
				opacity: 0.035
			}
		}

		Repeater {
			model: 4

			Item {
				id: corner

				required property int index

				readonly property bool isRight: index === 1 || index === 3
				readonly property bool isBottom: index === 2 || index === 3

				x: isRight ? frame.width - width : 0
				y: isBottom ? frame.height - height : 0
				width: 16
				height: 16

				Rectangle {
					width: parent.width
					height: root.theme.borderWidth * 2
					y: corner.isBottom ? parent.height - height : 0
					color: root.theme.colors.accent
					opacity: 0.9
				}

				Rectangle {
					width: root.theme.borderWidth * 2
					height: parent.height
					x: corner.isRight ? parent.width - width : 0
					color: root.theme.colors.accent
					opacity: 0.9
				}
			}
		}
	}
}
