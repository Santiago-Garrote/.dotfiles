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
	readonly property int widgetWidth: 330
	readonly property int widgetHeight: 148
	readonly property int columnGap: 336
	readonly property int rowGap: 164

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
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap

		CpuStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap

		CpuFrequencyWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap

		CpuThermalWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap

		ThermalStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 2

		MemoryStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 2

		SwapStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 2

		StorageStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 2

		HomeStorageWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 3

		PersistStorageWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 3

		DiskIoWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 3

		SystemStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 3

		BatteryHealthWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 4

		NetworkStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 4

		NetworkTrafficWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 4

		NetworkAddressWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 4

		AudioStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 5

		AudioInputWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 5

		AudioDeviceWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 5

		GpuStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 5

		GpuThermalWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 6

		FanStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 6

		DisplayStatusWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 6

		WindowStateWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-right"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 6

		MousePositionWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetY: root.rowGap * 7

		PointerCoordinatesWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}

	WidgetWindow {
		theme: root.theme
		shown: root.widgetsVisible
		placement: "top-left"
		windowWidth: root.widgetWidth
		windowHeight: root.widgetHeight
		margin: root.theme.spacing.gapOuter
		offsetX: root.columnGap
		offsetY: root.rowGap * 7

		PointerGridWidget {
			anchors.fill: parent
			theme: root.theme
		}
	}
}
