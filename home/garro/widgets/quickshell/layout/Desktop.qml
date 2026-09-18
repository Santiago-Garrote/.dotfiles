import Quickshell
import Quickshell.Hyprland._Ipc
import QtQuick
import "../widgets"

Scope {
	id: root

	required property QtObject theme
	readonly property var workspace: Hyprland.focusedWorkspace
	readonly property bool widgetsVisible: workspace !== null
		&& workspace.toplevels !== null
		&& workspace.toplevels.values.length === 0

	// Left-hand readout column. Everything to its right belongs to the
	// terminal.
	readonly property int columnWidth: 330
	readonly property int columnGap: 16

	readonly property int workspaceHeight: 92
	readonly property int clockHeight: 165
	readonly property int cardHeight: 148
	readonly property int rowGap: 14
	readonly property int gridStartOffset: workspaceHeight + rowGap
	readonly property int rowStride: cardHeight + rowGap

	// Waybar (still autostarted independently, see docs/quickshell-widgets.md)
	// draws over this layer along the top edge; keep every top-anchored
	// panel clear of it.
	readonly property int topClearance: root.theme.sizes.barHeight

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.columnWidth
		windowHeight: root.workspaceHeight
		margin: root.theme.spacing.gapOuter
		insetTop: root.topClearance

		WorkspaceWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.columnWidth
		windowHeight: root.cardHeight
		margin: root.theme.spacing.gapOuter
		insetTop: root.topClearance
		offsetY: root.gridStartOffset

		NetworkStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.columnWidth
		windowHeight: root.cardHeight
		margin: root.theme.spacing.gapOuter
		insetTop: root.topClearance
		offsetY: root.gridStartOffset + root.rowStride

		SystemStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.columnWidth
		windowHeight: root.cardHeight
		margin: root.theme.spacing.gapOuter
		insetTop: root.topClearance
		offsetY: root.gridStartOffset + root.rowStride * 2

		AudioStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "bottom-left"
		windowWidth: root.columnWidth
		windowHeight: root.clockHeight
		margin: root.theme.spacing.gapOuter

		ClockWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	// Terminal: fills everything right of the readout column.
	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "fill"
		margin: root.theme.spacing.gapOuter
		insetTop: root.topClearance
		// Leaves the readout column (plus a breathing gap) untouched; the
		// terminal takes the rest of the screen.
		insetLeft: root.columnWidth + root.columnGap
		keyboardFocusable: true

		TerminalWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}
}
