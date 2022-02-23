import QtQuick 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

import ThemeEngine 1.0

T.Button {
    id: control
    implicitWidth: contentItem.contentWidth * 1.5
    implicitHeight: Theme.componentHeight

    font.pixelSize: Theme.fontSizeComponent

    focusPolicy: Qt.NoFocus

    background: Rectangle {
        anchors.fill: parent
        radius: Theme.componentRadius
        opacity: enabled ? 1 : 0.33
        color: control.down ? Theme.colorComponentDown : Theme.colorComponent
    }

    contentItem: Text {
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        text: control.text
        textFormat: Text.PlainText
        font: control.font
        elide: Text.ElideRight
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter

        opacity: enabled ? 1.0 : 0.33
        color: control.down ? Theme.colorComponentContent : Theme.colorComponentContent
    }
}
