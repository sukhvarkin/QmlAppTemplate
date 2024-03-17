import QtQuick 2.15
import QtQuick.Layouts 1.15
import QtQuick.Controls 2.15

import ThemeEngine 1.0

Popup {
    id: popupTime

    x: (appWindow.width / 2) - (width / 2)
    y: (appWindow.height / 2) - (height / 2)

    width: appWindow.width * 0.9
    padding: 0
    margins: 0

    dim: true
    modal: true
    focus: true
    closePolicy: Popup.CloseOnEscape | Popup.CloseOnPressOutside
    parent: Overlay.overlay

    ////////////////////////////////////////////////////////////////////////////

    //property var locale: Qt.locale()

    property date today: new Date()
    property date initialDate
    property date selectedDate

    property bool isSelectedDateToday: false

    property var minDate: null
    property var maxDate: null

    ////////////////////////////////////////////////////////////////////////////

    enter: Transition { NumberAnimation { property: "opacity"; from: 0.5; to: 1.0; duration: 133; } }
    exit: Transition { NumberAnimation { property: "opacity"; from: 1.0; to: 0.0; duration: 233; } }

    ////////////////////////////////////////////////////////////////////////////

    background: Rectangle {
        radius: Theme.componentRadius*2
        color: Theme.colorBackground
        border.width: Theme.componentBorderWidth
        border.color: Theme.colorSeparator
    }

    ////////////////////////////////////////////////////////////////////////////

    contentItem: Column {
        //
    }

    ////////////////////////////////////////////////////////////////////////////
}
