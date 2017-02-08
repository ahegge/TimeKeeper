import QtQuick 2.4
import Qt.labs.calendar 1.0
import QtQuick.Controls 2.1
import QtQuick.Templates 2.1
import QtQuick.Layouts 1.3
import QtQuick.Dialogs.qml 1.0

Item {
    width: 400
    height: 400

    Rectangle {
        id: rectangle1
        x: -1
        y: 0
        width: 400
        height: 399
        color: "#2d2d2d"
        border.color: "#ffffff"

        Rectangle {
            id: rectangle
            x: 101
            y: 93
            width: 200
            height: 200
            color: "#464646"
            radius: 50
            antialiasing: true
            smooth: true
            border.color: "#ffffff"
            border.width: 3
        }
    }
}
