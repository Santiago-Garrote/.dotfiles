import QtQuick

QtObject {
	id: root

	readonly property string assembledState: "ASSEMBLED"
	readonly property string storageSelectedState: "STORAGE_SELECTED"

	property string state: assembledState
	readonly property bool storageSelected: state === storageSelectedState

	function toggleStorage(): void {
		state = storageSelected ? assembledState : storageSelectedState;
	}

	function collapse(): void {
		state = assembledState;
	}
}
