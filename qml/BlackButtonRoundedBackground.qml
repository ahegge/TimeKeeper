import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Controls.Styles 1.1

Rectangle {
    property bool pressed: false

    gradient: Gradient {
        GradientStop {
            color: pressed ? "#222" : "#333"
            position: 0
        }
        GradientStop {
            color: "#222"
            position: 1
        }
    }
}
