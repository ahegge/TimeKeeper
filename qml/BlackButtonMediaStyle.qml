import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

ButtonStyle {
    property color fontColor

    background: BlackButtonRoundedBackground {
        pressed: control.pressed
        radius: 50
        border.color: "#ffffff"
        border.width: 2
    }
}
