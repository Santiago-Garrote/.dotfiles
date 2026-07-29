import Quickshell
import Quickshell.Hyprland._Ipc
import QtQuick
import "../systemSchematic"
import "../widgets"

Scope {
	id: root

	required property QtObject theme
	readonly property var workspace: Hyprland.focusedWorkspace
	readonly property bool widgetsVisible: workspace !== null
		&& workspace.toplevels !== null
		&& workspace.toplevels.values.length === 0
	readonly property int widgetWidth: 330
	readonly property int widgetHeight: 148
	readonly property int columnGap: 336
	readonly property int rowGap: 164

	WidgetWindow {
		id: schematicWindow

		theme: root.theme
		shown: root.widgetsVisible
		placement: "bottom-left"
		windowWidth: 1100
		windowHeight: 728
		margin: root.theme.spacing.gapOuter
		inputMask: Region {
			Region {
				item: systemSchematic.ssdHitArea
			}

			Region {
				item: systemSchematic.calloutHitArea
			}
		}

		SystemSchematicWidget {
			id: systemSchematic

			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
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
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: 232
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap

		PointerCoordinatesWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}
}
