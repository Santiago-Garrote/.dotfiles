import QtQuick
import Quickshell.Services.Mpris
import "../components"

Panel {
	id: root

	readonly property var player: Mpris.players.values.length > 0 ? Mpris.players.values[0] : null
	readonly property bool hasPlayer: player !== null
	readonly property string title: hasPlayer && player.trackTitle.length > 0 ? player.trackTitle : "No media"
	readonly property string artist: hasPlayer && player.trackArtist.length > 0 ? player.trackArtist : "MPRIS idle"
	readonly property string state: hasPlayer ? MprisPlaybackState.toString(player.playbackState) : "Stopped"

	Column {
		anchors.fill: parent
		spacing: theme.spacing.small

		Label {
			theme: root.theme
			text: root.state
			textColor: theme.colors.accent
			size: theme.fontSizes.small
		}

		Label {
			theme: root.theme
			text: root.title
			elide: Text.ElideRight
			width: parent.width
			size: theme.fontSizes.medium
		}

		Label {
			theme: root.theme
			text: root.artist
			elide: Text.ElideRight
			width: parent.width
			textColor: theme.colors.muted
			size: theme.fontSizes.small
		}
	}
}
