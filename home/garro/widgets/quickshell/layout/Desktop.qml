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

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: 460
		windowHeight: 128
		margin: root.theme.spacing.gapOuter

		ClockWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: 180
		windowHeight: 92
		margin: root.theme.spacing.gapOuter

		WorkspaceWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "bottom-right"
		windowWidth: 360
		windowHeight: 148
		margin: root.theme.spacing.gapOuter
		offsetY: 656

		SystemStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "bottom-right"
		windowWidth: 360
		windowHeight: 148
		margin: root.theme.spacing.gapOuter
		offsetY: 492

		BatteryHealthWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "bottom-right"
		windowWidth: 360
		windowHeight: 148
		margin: root.theme.spacing.gapOuter
		offsetY: 328

		CpuStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "bottom-right"
		windowWidth: 360
		windowHeight: 148
		margin: root.theme.spacing.gapOuter
		offsetY: 164

		MemoryStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "bottom-right"
		windowWidth: 360
		windowHeight: 148
		margin: root.theme.spacing.gapOuter

		StorageStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "bottom-left"
		windowWidth: 360
		windowHeight: 148
		margin: root.theme.spacing.gapOuter
		offsetY: 328

		AudioStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "bottom-left"
		windowWidth: 360
		windowHeight: 148
		margin: root.theme.spacing.gapOuter
		offsetY: 164

		NetworkTrafficWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "bottom-left"
		windowWidth: 360
		windowHeight: 148
		margin: root.theme.spacing.gapOuter

		NetworkStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}
}
