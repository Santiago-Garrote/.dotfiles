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

	// Left-hand readout zone: two card columns. Everything to their right
	// belongs to the terminal.
	readonly property int columnWidth: 220
	readonly property int columnGap: 16
	readonly property int columnBOffset: columnWidth + columnGap
	readonly property int leftZoneWidth: columnWidth * 2 + columnGap

	readonly property int bannerHeight: 128
	readonly property int cardHeight: 148
	readonly property int rowGap: 14
	readonly property int gridStartOffset: bannerHeight + rowGap
	readonly property int rowStride: cardHeight + rowGap

	// Waybar (still autostarted independently, see docs/quickshell-widgets.md)
	// draws over this layer along the top edge; keep every top-anchored
	// panel clear of it.
	readonly property int topClearance: root.theme.sizes.barHeight

	// Banner: system clock, spanning both card columns.
	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.leftZoneWidth
		windowHeight: root.bannerHeight
		margin: root.theme.spacing.gapOuter
		insetTop: root.topClearance

		ClockWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	// Column A.
	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.columnWidth
		windowHeight: root.cardHeight
		margin: root.theme.spacing.gapOuter
		insetTop: root.topClearance
		offsetY: root.gridStartOffset

		WindowStateWidget {
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

		CpuStatusWidget {
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

		MemoryStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	// Column B.
	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.columnWidth
		windowHeight: root.cardHeight
		margin: root.theme.spacing.gapOuter
		insetTop: root.topClearance
		offsetX: root.columnBOffset
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
		offsetX: root.columnBOffset
		offsetY: root.gridStartOffset + root.rowStride

		AudioStatusWidget {
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
		offsetX: root.columnBOffset
		offsetY: root.gridStartOffset + root.rowStride * 2

		SystemStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	// Terminal: fills everything right of the readout zone.
	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "fill"
		margin: root.theme.spacing.gapOuter
		insetTop: root.topClearance
		// Leaves the left readout zone (plus a breathing gap) untouched;
		// the terminal takes the rest of the screen, roughly its right
		// two-thirds.
		insetLeft: root.leftZoneWidth + root.columnGap
		keyboardFocusable: true

		TerminalWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}
}
