import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Window 2.15

import ThemeEngine 1.0

ApplicationWindow {
    id: appWindow
    flags: settingsManager.appThemeCSD ? Qt.Window | Qt.FramelessWindowHint : Qt.Window
    color: settingsManager.appThemeCSD ? "transparent" : Theme.colorBackground

    property bool isHdpi: (utilsScreen.screenDpi >= 128 || utilsScreen.screenPar >= 2.0)
    property bool isDesktop: true

    width: 1280
    height: 800

    x: settingsManager.initialPosition.width
    y: settingsManager.initialPosition.height
    visibility: settingsManager.initialVisibility
    visible: true

    WindowGeometrySaver {
        windowInstance: appWindow
        Component.onCompleted: {
            // Make sure we handle window visibility correctly
            visibility = settingsManager.initialVisibility
        }
    }

    // Mobile stuff ////////////////////////////////////////////////////////////

    property int screenOrientation: Screen.primaryOrientation
    property int screenOrientationFull: Screen.orientation

    property int screenPaddingStatusbar: 0
    property int screenPaddingNavbar: 0
    property int screenPaddingTop: 0
    property int screenPaddingLeft: 0
    property int screenPaddingRight: 0
    property int screenPaddingBottom: 0

    // Events handling /////////////////////////////////////////////////////////

    Component.onCompleted: {
        //
    }

    Connections {
        target: appHeader

        function onBackButtonClicked() {
            backAction()
        }

        function onMenuComponentsClicked() { screenDesktopComponents.loadScreen() }
        function onMenuSettingsClicked() { screenSettings.loadScreen() }
        function onMenuAboutClicked() { screenAbout.loadScreen() }
    }

    Connections {
        target: Qt.application
        function onStateChanged() {
            switch (Qt.application.state) {
            case Qt.ApplicationActive:
                // Check if we need an 'automatic' theme change
                Theme.loadTheme(settingsManager.appTheme)
                break
            }
        }
    }

    onActiveFocusItemChanged: {
        //console.log("activeFocusItem:" + activeFocusItem)
    }

    onClosing: (close) =>  {
                   if (Qt.platform.os === "osx") {
                       close.accepted = false
                       appWindow.hide()
                   }
               }

    // User generated events handling //////////////////////////////////////////

    function backAction() {
        screenMainView.loadScreen()
    }

    // UI sizes ////////////////////////////////////////////////////////////////

    property bool headerUnicolor: (Theme.colorHeader === Theme.colorBackground)
    property bool sidebarUnicolor: (Theme.colorSidebar === Theme.colorBackground)

    property bool wideMode: (isDesktop && width >= 560)
    property bool wideWideMode: (width >= 640)

    property bool singleColumn: (appWindow.width < appWindow.height)

    DesktopSidebar {
        id: appSidebar
        z: 2

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.bottom: parent.bottom

        visible: false
    }

    DesktopHeader {
        id: appHeader

        anchors.top: parent.top
        anchors.left: parent.left
        anchors.right: parent.right
    }

    Rectangle {
        id: appContent

        anchors.top: appHeader.bottom
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        color: Theme.colorBackground

        ScreenMainView {
            id: screenMainView
        }

        ScreenDesktopComponents {
            id: screenDesktopComponents
        }

        ScreenHostInfos {
            id: screenHostInfos
        }

        ScreenSettings {
            id: screenSettings
        }

        ScreenAbout {
            id: screenAbout
        }

        ScreenFontInfos {
            id: screenFontInfos
        }

        Component.onCompleted: {
            screenMainView.loadScreen()
        }

        // Initial state
        state: "MainView"

        states: [
            State {
                name: "MainView"
                PropertyChanges { target: screenMainView; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "DesktopComponents"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "FontInfos"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "HostInfos"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "Settings"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: true; enabled: true; focus: true; }
                PropertyChanges { target: screenAbout; visible: false; enabled: false; }
            },
            State {
                name: "About"
                PropertyChanges { target: screenMainView; visible: false; enabled: false; }
                PropertyChanges { target: screenDesktopComponents; visible: false; enabled: false; }
                PropertyChanges { target: screenFontInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenHostInfos; visible: false; enabled: false; }
                PropertyChanges { target: screenSettings; visible: false; enabled: false; }
                PropertyChanges { target: screenAbout; visible: true; enabled: true; focus: true; }
            }
        ]
    }

    ////////////////////////////////////////////////////////////////////////////
}
