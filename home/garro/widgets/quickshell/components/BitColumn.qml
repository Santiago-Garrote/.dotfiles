import QtQuick

// A line of filled/hollow dots reading a small integer as binary, most
// significant bit first. Vertical (a "column") by default, matching the
// per-digit layout of a BCD binary clock; set `horizontal: true` for a
// single-row readout. Same filled/opacity language as SegmentBar.
Grid {
	id: root

	required property QtObject theme
	required property int value
	property int bitCount: 4
	property int dotSize: 18
	property bool horizontal: false

	columns: horizontal ? bitCount : 1
	rowSpacing: theme.spacing.small
	columnSpacing: theme.spacing.small

	Repeater {
		model: root.bitCount

		Rectangle {
			id: dot

			required property int index
			readonly property int bitValue: 1 << (root.bitCount - 1 - index)
			readonly property bool set: (root.value & bitValue) !== 0

			width: root.dotSize
			height: root.dotSize
			radius: width / 2
			color: dot.set ? root.theme.colors.accent : "transparent"
			border.color: root.theme.colors.accent
			border.width: root.theme.borderWidth
			opacity: dot.set ? 0.88 : 0.52
		}
	}
}
