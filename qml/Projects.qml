import QtQuick 2.2
import QtQuick.Controls 1.1

ControlView {
    id: controlView
    Rectangle {
        height: root.height * 0.125
    }

    Button {
        width: stackView.width / 2
        height: root.height * 0.125 
        text: "Add"
        anchors.horizontalCenter: parent.horizontalCenter

        style: BlackButtonRoundedStyle {
            fontColor: "white"
        }

        onClicked: {
			console.log("buton pressed")
		}
	}
}
