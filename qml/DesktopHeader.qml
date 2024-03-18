import QtQuick 2.15

import ThemeEngine 1.0

Rectangle {
    id: appHeader
    anchors.top: parent.top
    anchors.left: parent.left
    anchors.right: parent.right

    height: headerHeight
    color: Theme.colorHeader
    clip: false
    z: 10

    property string headerTitle: "Bravo"
    property int headerHeight: 64
    property int headerPosition: 64

    property bool componentsEnabled: true
    property bool componentsMirrored: false

    ////////////////////////////////////////////////////////////////////////////

    signal backButtonClicked()

    signal menuComponentsClicked()
    signal menuSettingsClicked()
    signal menuAboutClicked()

    ////////////////////////////////////////////////////////////////////////////

    DragHandler {
        // Drag on the sidebar to drag the whole window // Qt 5.15+
        // Also, prevent clicks below this area
        onActiveChanged: if (active) appWindow.startSystemMove()
        target: null
    }

    RoundButtonIcon {
        id: buttonBack
        anchors.left: parent.left
        anchors.leftMargin: 12
        anchors.verticalCenter: parent.verticalCenter

        visible: !(appContent.state === "MainView")

        source: "qrc:/assets/icons_material/baseline-arrow_back-24px.svg"
        iconColor: Theme.colorHeaderContent
        backgroundColor: Theme.colorHeaderHighlight

        onClicked: backButtonClicked()
    }

    Text { // title
        id: titleText
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter

        visible: wideMode
        text: appHeader.headerTitle
        font.bold: true
        font.pixelSize: Theme.fontSizeHeader
        color: Theme.colorHeaderContent
    }



    ////////////////////////////////////////////////////////////////////////////

    Row {
        id: menus
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        spacing: 12
        visible: true

        ////////////

        Row {
            id: menuDesktopComponents
            anchors.verticalCenter: parent.verticalCenter
            spacing: 12

            FpsMonitor {
                anchors.verticalCenter: parent.verticalCenter
            }

            ////////////

            Rectangle { // separator
                anchors.verticalCenter: parent.verticalCenter
                height: 40
                width: Theme.componentBorderWidth
                color: Theme.colorHeaderHighlight
                visible: (menuMain.visible)
            }
        }

        ////////////

        Row {
            id: menuMain

            DesktopHeaderItem {
                id: menuSettings
                height: appHeader.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight
                highlightMode: "background"

                highlighted: (appContent.state === "Settings")
                source: "qrc:/assets/icons_material/duotone-tune-24px.svg"
                onClicked: menuSettingsClicked()
            }

            DesktopHeaderItem {
                id: menuAbout
                height: appHeader.height

                colorContent: Theme.colorHeaderContent
                colorHighlight: Theme.colorHeaderHighlight
                highlightMode: "background"

                highlighted: (appContent.state === "About")
                source: "qrc:/assets/icons_material/duotone-info-24px.svg"
                onClicked: menuAboutClicked()
            }
        }
    }


    Rectangle { // separator
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        visible: true
        height: 2
        opacity: 0.5
        color: Theme.colorHeaderHighlight

        Rectangle { // shadow
            anchors.top: parent.bottom
            anchors.left: parent.left
            anchors.right: parent.right

            height: 8
            opacity: 0.66
            visible: false

            gradient: Gradient {
                orientation: Gradient.Vertical
                GradientStop { position: 0.0; color: Theme.colorHeaderHighlight; }
                GradientStop { position: 1.0; color: Theme.colorBackground; }
            }
        }
    }
}
