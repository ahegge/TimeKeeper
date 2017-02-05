import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

ButtonStyle {
    property color fontColor

    background: BlackButtonRoundedBackground {
        pressed: control.pressed
        radius: 40
        border.color: "#444"
        border.width: 1
    }
    label: Text {
        id: text
        text: control.text
        color: fontColor
        font.pixelSize: control.height * 0.25
        font.family: openSans.name
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
    }
}
