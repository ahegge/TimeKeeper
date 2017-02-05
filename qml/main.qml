import QtQuick 2.2
import QtQuick.LocalStorage 2.0
import QtGraphicalEffects 1.0
import QtQuick.Controls 1.4
import QtQuick.Controls.Styles 1.4
import QtQuick.Dialogs 1.0
import QtQuick.Extras 1.4
import QtQuick.Layouts 1.0
import QtQuick.Window 2.1

ApplicationWindow {
    id: root
    objectName: "window"
    visible: true
    width: 480
    height: 800
    minimumWidth: 480
    minimumHeight: 800

    color: "#161616"
    title: "Time Keeper"

    function toPixels(percentage) {
        return percentage * Math.min(root.width, root.height);
    }

    property bool isScreenPortrait: height > width
    property color lightFontColor: "#222"
    property color darkFontColor: "#e7e7e7"
    readonly property color lightBackgroundColor: "#cccccc"
    readonly property color darkBackgroundColor: "#161616"

    property var db: null


    function openDB() {
        if(db !== null) return;

        db = LocalStorage.openDatabaseSync("timekeeper", "0.1", "", 100000);
        try {
            db.transaction(function(tx){
                tx.executeSql('CREATE TABLE IF NOT EXISTS projects (title TEXT)');
                var table  = tx.executeSql("SELECT * FROM projects");
                // insert default values
                if (table.rows.length == 0) {
                    tx.executeSql('INSERT INTO projects VALUES(?)', ["Sample Project"]);
                    console.log('projects filled');
                };
            });
        } catch (err) {
            console.log("Error creating table in database: " + err);
        };
    }

    function get_projects() {
        openDB();
        var rs;
        db.transaction(function(tx) {
            rs = tx.executeSql('SELECT * FROM projects');
        });
        return rs;
    }

    property Component projects: Projects {}

    property var componentMap: {
        "Projects": projects
    }

    Text {
        id: textSingleton
    }

    FontLoader {
        id: openSans
        source: "qrc:/fonts/OpenSans-Regular.ttf"
     }

    StackView {
        id: stackView
        anchors.fill: parent

        Component {
            id: listHeader

            Rectangle {
                id: project_buttons
                function show_project_buttons(show){
                    project_new.visible = !show
                    project_label.visible = show
                    project_ok.visible = !show
                    project_cancel.visible = !show
                    project_add.visible = show
                }
                height: root.height * 0.125
                width: stackView.width
                BlackButtonBackground {
                    anchors.fill: parent
                    RowLayout {
                        anchors.fill: parent
                        Text {
                            id: project_label
                            text: "Projects"
                            color: "white"
                            font.pixelSize: parent.height * 0.25
                            font.family: openSans.name
                            horizontalAlignment: Text.AlignLeft
                            verticalAlignment: Text.AlignVCenter
                            anchors.verticalCenter: parent.verticalCenter
                            anchors.horizontalCenter: parent.horizontalCenter
                        }

                        TextField {
                            id: project_new
                            Layout.fillWidth: true
                            Layout.preferredHeight: parent.height * 0.45
                            Layout.margins: 15
                            Layout.rightMargin: 0
                            visible: false
                            focus: false
                            font.pixelSize: parent.height * 0.25
                            font.family: openSans.name

                            onAccepted: {
                                var new_project = text
                                if (new_project != ""){
                                    openDB();
                                    db.transaction(function(tx) {
                                        var rs = tx.executeSql('INSERT INTO projects VALUES(?)', [ new_project]);
                                    });
                                    project_list.append({title: new_project})
                                }
                                project_new.text = ""
                                project_new.focus = false
                                project_buttons.show_project_buttons(true)
                            }
                        }

                        Button {
                            id: project_cancel
                            Layout.fillHeight: true
                            Layout.preferredWidth: parent.height/2
                            Layout.alignment: Qt.AlignRight
                            visible: false
                            anchors.bottom: parent.bottom
                            iconSource: "qrc:/images/delete.png"
                            style: BlackButtonStyle {
                            }
                            onClicked: {
                                project_buttons.show_project_buttons(true)
                            }
                        }

                        Button {
                            id: project_ok
                            Layout.fillHeight: true
                            Layout.preferredWidth: parent.height/2
                            Layout.alignment: Qt.AlignRight
                            visible: false
                            anchors.bottom: parent.bottom
                            iconSource: "qrc:/images/check.png"
                            style: BlackButtonStyle {
                            }
                            onClicked: {
                                project_buttons.show_project_buttons(true)
                                project_new.accepted()
                            }
                        }

                        Button {
                            id: project_add
                            Layout.fillHeight: true
                            Layout.preferredWidth: parent.height
                            Layout.alignment: Qt.AlignRight
                            anchors.bottom: parent.bottom
                            iconSource: "qrc:/images/plus-sign.png"
                            style: BlackButtonStyle {
                            }
                            onClicked: {
                                project_buttons.show_project_buttons(false)
                                project_new.forceActiveFocus()
                            }
                        }
                    }
                }
            }
        }

        initialItem: ListView {
            header: listHeader
            model: ListModel {
                id: project_list
            }

            delegate: Button {
                width: stackView.width
                height: root.height * 0.125
                text: title

                style: BlackButtonStyle {
                    fontColor: darkFontColor
                    rightAlignedIconSource: "qrc:/images/arrow-right.png"
                }

                onClicked: {
                    if (stackView.depth == 1) {
                        // Only push the control view if we haven't already pushed it...
                        stackView.push({item: componentMap["Projects"]});
                        stackView.currentItem.forceActiveFocus();
                    }
                }
            }
        }
    }
    Component.onCompleted: {
        openDB();
        var projects = get_projects()
        for(var i = 0; i < projects.rows.length; i++) {
            var r = projects.rows.item(i).title
            project_list.append({title: r})
        }
    }
}
