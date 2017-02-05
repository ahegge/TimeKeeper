import QtQuick 2.2
import QtQuick.Controls 1.1

ControlView {
    id: controlView
    property string title: "value"
    property int project_id
    Rectangle {
        height: root.height * 0.125
    }

    Button {
        width: stackView.width / 2
        height: root.height * 0.125 
        text: title + " " + project_id.toString()
        anchors.horizontalCenter: parent.horizontalCenter

        style: BlackButtonRoundedStyle {
            fontColor: "white"
        }

        onClicked: {
			console.log("buton pressed")
		}
	}
}
