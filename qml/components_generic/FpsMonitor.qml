import QtQuick 2.15
import QtQuick.Window 2.15

Item {
    id: control

    implicitWidth: 160
    implicitHeight: 24

    property int frameCounter: 0
    property int frameCounterAvg: 0
    property int counter: 0
    property int fps: 0
    property int fpsAvg: 0

    Rectangle {
        anchors.fill: rowrow
        color: "transparent"
        opacity: 0.8
    }

    Row {
        id: rowrow
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right

        IconSvg {
            anchors.verticalCenter: parent.verticalCenter
            width: 24
            height: 24
            color: "white"
            source: "qrc:/assets/icons_material/baseline-autorenew-24px.svg"

            NumberAnimation on rotation {
                from: 0
                to: 360
                duration: 1000
                loops: Animation.Infinite
            }
            onRotationChanged: frameCounter++
        }

        Text {
            anchors.verticalCenter: parent.verticalCenter
            color: "#c0c0c0"
            font.pixelSize: 18
            text: "Ø " + control.fpsAvg + " | " + control.fps + " fps"
            textFormat: Text.PlainText
        }

        Loader {
            anchors.verticalCenter: parent.verticalCenter
            asynchronous: true
            active: (typeof utilsFps !== "undefined" && utilsFps)

            sourceComponent: Text {
                color: "#c0c0c0"
                font.pixelSize: 18
                text: " | " + utilsFps.fps + " fps"
                textFormat: Text.PlainText
            }
        }
    }

    Timer {
        interval: 2000
        repeat: true
        running: true
        onTriggered: {
            frameCounterAvg += frameCounter
            control.fps = frameCounter / 2
            counter++
            frameCounter = 0
            if (counter >= 3) {
                control.fpsAvg = frameCounterAvg / (2*counter)
                frameCounterAvg = 0
                counter = 0
            }
        }
    }
}
