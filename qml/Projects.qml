import QtQuick 2.2
import QtQuick.Controls 1.1
import QtQuick.Layouts 1.0

ListView {
    property string project_title
    property int project_ids

    property Component tasks: Tasks {}

    header: task_listHeader
    model: ListModel {
        id: task_list
    }

    delegate: Button {
        width: stackView.width
        height: root.height * 0.125

        text: task_title

        style: BlackButtonStyle {
            fontColor: darkFontColor
            rightAlignedIconSource: "qrc:/images/arrow-right.png"
        }

        onClicked: {
                if (stackView.depth == 2) {
                    // Only push the control view if we haven't already pushed it...
                    stackView.push(tasks,{task_title: task_title,"task_id": task_id,project_id: project_ids });
                    stackView.currentItem.forceActiveFocus();
                }
        }
    }
    Component {
        id: task_listHeader

        Rectangle {
            id: task_buttons
            function show_task_buttons(show){
                task_new.visible = !show
                task_label.visible = show
                task_ok.visible = !show
                task_cancel.visible = !show
                task_add.visible = show
                back.visible = show
            }
            height: root.height * 0.125
            width: stackView.width
            BlackButtonBackground {
                anchors.fill: parent
                RowLayout {
                    anchors.fill: parent
                    Button {
                        id: back
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.height
                        Layout.alignment: Qt.AlignLeft
                        visible: true
                        anchors.bottom: parent.bottom
                        iconSource: "qrc:/images/arrow-left.png"
                        style: BlackButtonStyle {
                        }
                        onClicked: {
                            stackView.pop()
                        }
                    }
                    Text {
                        id: task_label
                        text: "Tasks"
                        color: "white"
                        font.pixelSize: parent.height * 0.25
                        font.family: openSans.name
                        horizontalAlignment: Text.AlignLeft
                        verticalAlignment: Text.AlignVCenter
                        anchors.verticalCenter: parent.verticalCenter
                        anchors.horizontalCenter: parent.horizontalCenter
                    }

                    TextField {
                        id: task_new
                        Layout.fillWidth: true
                        Layout.preferredHeight: parent.height * 0.45
                        Layout.margins: 15
                        Layout.rightMargin: 0
                        visible: false
                        focus: false
                        font.pixelSize: parent.height * 0.25
                        font.family: openSans.name

                        onAccepted: {
                            var new_task = text
                            if (new_task != ""){
                                openDB();
                                var rs
                                db.transaction(function(tx) {
                                    rs = tx.executeSql('INSERT INTO tasks VALUES(null,?,?)', [project_ids, new_task]);
                                });
                                    task_list.append({task_title: new_task,task_id: parseInt(rs.insertId,10),project_id:project_ids})
                            }
                            task_new.text = ""
                            task_new.focus = false
                            task_buttons.show_task_buttons(true)
                        }
                    }

                    Button {
                        id: task_cancel
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.height/2
                        Layout.alignment: Qt.AlignRight
                        visible: false
                        anchors.bottom: parent.bottom
                        iconSource: "qrc:/images/delete.png"
                        style: BlackButtonStyle {
                        }
                        onClicked: {
                            task_buttons.show_task_buttons(true)
                        }
                    }

                    Button {
                        id: task_ok
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.height/2
                        Layout.alignment: Qt.AlignRight
                        visible: false
                        anchors.bottom: parent.bottom
                        iconSource: "qrc:/images/check.png"
                        style: BlackButtonStyle {
                        }
                        onClicked: {
                            task_buttons.show_task_buttons(true)
                            task_new.accepted()
                        }
                    }

                    Button {
                        id: task_add
                        Layout.fillHeight: true
                        Layout.preferredWidth: parent.height
                        Layout.alignment: Qt.AlignRight
                        anchors.bottom: parent.bottom
                        iconSource: "qrc:/images/plus-sign.png"
                        style: BlackButtonStyle {
                        }
                        onClicked: {
                            task_buttons.show_task_buttons(false)
                            task_new.forceActiveFocus()
                        }
                    }
                }
            }
        }
    }



    Component.onCompleted: {
        openDB();
        var tasks = get_tasks(project_ids)
        for(var i = 0; i < tasks.rows.length; i++) {
            var r = tasks.rows.item(i).title
            var pid = tasks.rows.item(i).id
            var pid2 = tasks.rows.item(i).project_id
            task_list.append({task_title: r,task_id: pid,project_id:pid2})
        }

        console.log(task_list.get(0).task_title)
        console.log(task_list.count)
    }
}
