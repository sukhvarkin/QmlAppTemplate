import QtQuick 2.15
import QtQuick.Controls 2.15

import ThemeEngine 1.0

Popup {
    id: popupMessage

    x: singleColumn ? 0 : (appWindow.width / 2) - (width / 2)
    y: singleColumn ? (appWindow.height - height)
                    : ((appWindow.height / 2) - (height / 2))

    width: singleColumn ? appWindow.width : 640
    height: columnContent.height + padding*2 + screenPaddingNavbar + screenPaddingBottom
    padding: Theme.componentMarginXL
    margins: 0

    dim: true
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    parent: Overlay.overlay

    signal confirmed()

    ////////////////////////////////////////////////////////////////////////////

    background: Rectangle {
        color: Theme.colorBackground
        border.color: Theme.colorSeparator
        border.width: singleColumn ? 0 : Theme.componentBorderWidth
        radius: singleColumn ? 0 : Theme.componentRadius

        Rectangle {
            width: parent.width
            height: Theme.componentBorderWidth
            visible: singleColumn
            color: Theme.colorSeparator
        }
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Item {
        Column {
            id: columnContent
            width: parent.width
            spacing: Theme.componentMarginXL

            ////////

            Text {
                width: parent.width

                text: qsTr("Message popup title")
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeContentVeryBig
                color: Theme.colorText
                wrapMode: Text.WordWrap
            }

            ////////

            Text {
                width: parent.width

                text: qsTr("Message popup text. This is a message, empty of any kind of meaning.")
                textFormat: Text.PlainText
                font.pixelSize: Theme.fontSizeContent
                color: Theme.colorSubText
                wrapMode: Text.WordWrap
            }

            ////////

            ButtonWireframe {
                anchors.right: parent.right
                width: singleColumn ? parent.width : (parent.width / 2)

                text: qsTr("OK")
                primaryColor: Theme.colorSubText
                secondaryColor: Theme.colorForeground

                onClicked: popupMessage.close()
            }

            ////////
        }
    }

    Overlay.modal: Rectangle {
             color: "#c8000000"
    }

    ////////////////////////////////////////////////////////////////////////////
}
