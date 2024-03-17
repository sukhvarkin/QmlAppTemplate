import QtQuick 2.15
import QtQuick.Controls 2.15

import ThemeEngine 1.0

Item {
    id: screenMainView
    anchors.fill: parent

    function loadScreen() {
        if (isDesktop) screenDesktopComponents.loadScreen()
        else if (isMobile) screenMobileComponents.loadScreen()
        else appContent.state = "MainView"
    }

    function backAction() {
        //
    }
}
