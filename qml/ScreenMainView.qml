import QtQuick 2.15
import QtQuick.Controls 2.15

import ThemeEngine 1.0

Item {
    id: screenMainView
    anchors.fill: parent

    function loadScreen() {
        appContent.state = "MainView"
    }

    function backAction() {
        //
    }
}
