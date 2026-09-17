import QtQuick
import KvitTerm
import "../components"

Item {
	id: root

	required property QtObject theme

	Column {
		anchors {
			horizontalCenter: parent.horizontalCenter
			bottom: terminal.top
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
			dividerWidth: 200
		}
	}

	TerminalView {
		id: terminal

		anchors.centerIn: parent
		width: 640
		height: 360

		font.family: root.theme.fonts.monospace
		font.pointSize: root.theme.fontSizes.medium

		// No panel at all: text sits directly on the desktop background,
		// same as every other widget here.
		palette: TerminalPalette {
			background: "transparent"
			foreground: root.theme.colors.foreground

			// A monochrome-amber ANSI palette so default shell coloring
			// (e.g. bash's green user@host prompt) doesn't clash with the
			// rest of the theme; red is kept distinct since it's the one
			// color meant to still read as a deliberate signal (errors).
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
}
