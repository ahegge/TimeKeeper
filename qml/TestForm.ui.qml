import QtQuick 2.4
import Qt.labs.calendar 1.0
import QtQuick.Controls 2.1
import QtQuick.Templates 2.1
import QtQuick.Layouts 1.3
import QtQuick.Dialogs.qml 1.0

Item {
    width: 400
    height: 400

    BlackButtonBackground {
        id: blackButtonBackground
        x: 118
        y: 98
    }

    ColumnLayout {
        id: columnLayout
        anchors.fill: parent

        Rectangle {
            id: rectangle
            width: 200
            height: 200
            color: "#ffffff"
            border.width: 0
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignHCenter | Qt.AlignTop
            transformOrigin: Item.Center
        }

        ListView {
            id: listView
            x: 0
            y: 0
            width: 110
            height: 160
            delegate: Item {
                x: 5
                width: 80
                height: 40
                Row {
                    id: row1
                    spacing: 10
                    Rectangle {
                        width: 40
                        height: 40
                        color: colorCode
                    }

                    Text {
                        text: name
                        font.bold: true
                        anchors.verticalCenter: parent.verticalCenter
                    }
                }
            }
            model: ListModel {
                ListElement {
                    name: "Grey"
                    colorCode: "grey"
                }

                ListElement {
                    name: "Red"
                    colorCode: "red"
                }

                ListElement {
                    name: "Blue"
                    colorCode: "blue"
                }

                ListElement {
                    name: "Green"
                    colorCode: "green"
                }
            }
        }
    }

    TextField {
        id: textField
        x: 152
        y: 252
        text: qsTr("Text Field")
    }
}
