import QtQuick 2.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15

import ThemeEngine 1.0

T.ItemDelegate {
    id: control

    implicitWidth: Math.max(implicitBackgroundWidth + leftInset + rightInset,
                            implicitContentWidth + leftPadding + rightPadding)
    implicitHeight: Math.max(implicitBackgroundHeight + topInset + bottomInset,
                             implicitContentHeight + topPadding + bottomPadding,
                             implicitIndicatorHeight + topPadding + bottomPadding)

    padding: Theme.componentMargin
    spacing: Theme.componentMargin
    verticalPadding: 0

    icon.width: 32
    icon.height: 32
    icon.color: enabled ? Material.foreground : Material.hintTextColor

    ////////////////

    background: Rectangle {
        implicitHeight: Theme.componentHeightXL

        color: control.highlighted ? control.Material.listHighlightColor : "transparent"

//        RippleThemed {
//            width: parent.width
//            height: parent.height

//            clip: visible
//            anchor: control
//            pressed: control.pressed
//            active: enabled && (control.down || control.visualFocus || control.hovered)
//            color: Qt.rgba(Theme.colorForeground.r, Theme.colorForeground.g, Theme.colorForeground.b, 0.5)
//        }
    }

    ////////////////

    contentItem: Row {
        anchors.verticalCenter: parent.verticalCenter
        width: control.width
        spacing: Theme.componentMargin

        RoundButtonIcon {
            anchors.verticalCenter: parent.verticalCenter
            width: Theme.componentHeight
            height: Theme.componentHeight

            source: model.icon
            backgroundVisible: true
        }

        Column {
            anchors.verticalCenter: parent.verticalCenter

            Text {
                text: model.title
                textFormat: Text.PlainText
                font.pixelSize: Theme.componentFontSize
                color: Theme.colorText
            }
            Text {
                text: model.text
                textFormat: Text.PlainText
                font.pixelSize: Theme.componentFontSize
                color: Theme.colorSubText
            }
        }
    }

    ////////////////
}
