import QtQuick 2.2
import QtQuick.Controls 1.1

Rectangle {
    id: view
    property color fontColor
    property bool darkBackground

    color: darkBackgroundColor ? "transparent" : root.lightBackgroundColor

    Keys.onReleased: {
        if (event.key === Qt.Key_Back) {
            stackView.pop();
            event.accepted = true;
        }
    }

    Text {
        color: fontColor
    }

    BlackButtonBackground {
        height: root.height * 0.125
        anchors.left: parent.left
        anchors.right: parent.right
        anchors.bottom: parent.bottom

        gradient: Gradient {
            GradientStop {
                color: "#333"
                position: 0
            }
            GradientStop {
                color: "#222"
                position: 1
            }
        }

        Button {
            id: back
            width: parent.height
            height: parent.height
            anchors.left: parent.left
            anchors.bottom: parent.bottom
            iconSource: "qrc:/images/arrow-left.png"
            onClicked: stackView.pop()

            style: BlackButtonStyle {
            }

        }
    }
}
