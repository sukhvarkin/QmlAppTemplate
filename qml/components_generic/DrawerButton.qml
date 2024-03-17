import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Templates 2.15 as T
import QtQuick.Controls 2.15
import QtQuick.Controls.Material 2.15
import QtGraphicalEffects 1.15 
import ThemeEngine 1.0

T.ItemDelegate {
    id: control

    implicitWidth: parent.width
    implicitHeight: Theme.componentHeightL

    padding: Theme.componentMargin
    spacing: Theme.componentMargin
    verticalPadding: 0

    property string source
    property string iconColor: Theme.colorIcon
    property int sourceSize: 24

    property bool iconAnimated: false
    property string iconAnimation // fade or rotate

    property string textColor: Theme.colorText
    property int textSize: 13

    ////////////////

    background: Item {
        implicitHeight: Theme.componentHeightL

        Item {
            anchors.fill: parent
            anchors.margins: 4
            anchors.leftMargin: 8
            anchors.rightMargin: 8

            RippleThemed {
                width: parent.width
                height: parent.height

                pressed: control.pressed
                active: enabled && (control.down || control.visualFocus || control.hovered)
                color: Qt.rgba(Theme.colorForeground.r, Theme.colorForeground.g, Theme.colorForeground.b, 0.5)
            }

            layer.enabled: true
            layer.effect: OpacityMask {
                maskSource: Rectangle {
                    x: background.x
                    y: background.y
                    width: background.width
                    height: background.height
                    radius: Theme.componentRadius
                }
            }
        }

    }

    ////////////////

    contentItem: RowLayout {
        anchors.left: parent.left
        anchors.leftMargin: screenPaddingLeft + Theme.componentMargin
        anchors.right: parent.right
        anchors.rightMargin: screenPaddingRight + Theme.componentMargin / 2

        opacity: control.enabled ? 1 : 0.4

        Item {
            Layout.preferredWidth: Theme.componentHeightL - screenPaddingLeft - Theme.componentMargin
            Layout.preferredHeight: Theme.componentHeightL
            Layout.alignment: Qt.AlignTop

            IconSvg {
                anchors.left: parent.left
                anchors.leftMargin: (32 - control.sourceSize) / 2
                anchors.verticalCenter: parent.verticalCenter
                anchors.verticalCenterOffset: (control.height !== Theme.componentHeightL) ? -(Theme.componentMargin / 2) : 0

                width: control.sourceSize
                height: control.sourceSize
                color: control.iconColor
                source: control.source

                NumberAnimation on rotation { // rotate animation // icon only
                    duration: 2000
                    from: 0
                    to: 360
                    loops: Animation.Infinite
                    running: (control.iconAnimated && control.iconAnimation === "rotate")
                    alwaysRunToEnd: true
                }
                SequentialAnimation on opacity { // fade animation // icon only
                    loops: Animation.Infinite
                    running: (control.iconAnimated && control.iconAnimation === "fade")
                    alwaysRunToEnd: true

                    PropertyAnimation { to: 0.33; duration: 750; }
                    PropertyAnimation { to: 1; duration: 750; }
                }
            }
        }

        Text {
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignVCenter

            text: control.text
            color: control.textColor
            wrapMode: Text.WordWrap
            font.bold: true
            font.pixelSize: control.textSize
        }
    }

    ////////////////
}
