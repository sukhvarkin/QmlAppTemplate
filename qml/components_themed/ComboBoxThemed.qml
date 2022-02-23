import QtQuick 2.15
import QtQuick.Controls.impl 2.15
import QtQuick.Templates 2.15 as T

import ThemeEngine 1.0

T.ComboBox {
    id: control
    implicitWidth: 200
    implicitHeight: Theme.componentHeight

    font.pixelSize: Theme.fontSizeComponent

    leftPadding: 12
    rightPadding: 12

    ////////

    background: Rectangle {
        anchors.fill: parent
        radius: Theme.componentRadius
        color: control.down ? Theme.colorComponentDown : Theme.colorComponent
        border.width: 1
        border.color: Theme.colorComponentBorder
    }

    ////////

    contentItem: Text {
        text: control.displayText
        textFormat: Text.PlainText
        font: control.font
        color: Theme.colorComponentContent
        elide: Text.ElideRight
        verticalAlignment: Text.AlignVCenter
    }

    ////////

    indicator: Canvas {
        x: control.width - width - control.rightPadding
        y: control.topPadding + (control.availableHeight - height) / 2
        width: 12
        height: 8
        rotation: control.popup.visible ? 180 : 0

        Connections {
            target: ThemeEngine
            function onCurrentThemeChanged() { indicator.requestPaint() }
        }

        onPaint: {
            var ctx = getContext("2d")
            ctx.reset()
            ctx.moveTo(0, 0)
            ctx.lineTo(width, 0)
            ctx.lineTo(width / 2, height)
            ctx.closePath()
            ctx.fillStyle = Theme.colorComponentContent
            ctx.fill()
        }
    }

    ////////

    delegate: T.ItemDelegate {
        width: control.width - 2
        height: control.height
        highlighted: (control.highlightedIndex === index)

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: Theme.componentHeight

            radius: Theme.componentRadius
            opacity: enabled ? 1 : 0.3
            color: highlighted ? "#F6F6F6" : "transparent"
        }

        contentItem: Text {
            leftPadding: control.leftPadding
            text: modelData
            color: highlighted ? "black" : Theme.colorSubText
            font.pixelSize: Theme.fontSizeComponent
            elide: Text.ElideRight
            verticalAlignment: Text.AlignVCenter
        }
    }

    ////////

    popup: T.Popup {
        y: control.height - 1
        width: control.width
        implicitHeight: (contentItem.implicitHeight) ? contentItem.implicitHeight + 2 : 0
        padding: 1

        contentItem: ListView {
            implicitHeight: contentHeight
            clip: true
            currentIndex: control.highlightedIndex
            model: control.popup.visible ? control.delegateModel : null
        }

        background: Rectangle {
            radius: Theme.componentRadius
            color: "white"
            border.color: Theme.colorComponentBorder
            border.width: control.visualFocus ? 0 : 1
        }
    }
}
