import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.15
import CalendarSave 1.0

Window {
    id: textWindow
    visible: false
    title: "创建日程"
    property var getChoseDay: 0

    SaveTheFile {
        id: saveTheFile
    }

    ColumnLayout {
        anchors.fill: parent
        RowLayout {
            Rectangle {
                Layout.fillWidth: true
            }
            Text {
                id: timeText
                font.pixelSize: 30
                text: getChoseDay
            }
            Rectangle {
                Layout.fillWidth: true
            }
        }

        ColumnLayout {
            spacing: 20
            RowLayout {
                spacing: 10
                Rectangle {
                    width: 35
                }

                Text {
                    text: "标题"
                    font.pixelSize: 20
                }
                Rectangle {
                    Layout.fillWidth: true
                    height: 40
                    color: "lightGrey"
                    radius: 5
                    TextInput {
                        id: textInput
                        anchors.left: parent.left
                        anchors.top: parent.top
                        anchors.leftMargin: 5
                        anchors.topMargin: 5
                        width: parent.width
                        height: 30
                        selectByMouse: true
                        font.pixelSize: 20
                        focus: true
                        maximumLength: 50
                        clip: true
                        KeyNavigation.tab: textEdit
                    }
                }
                Rectangle {
                    width: 50
                }
            }

            RowLayout {
                spacing: 10
                Rectangle {
                    width: 35
                }
                Text {
                    text: "内容"
                    font.pixelSize: 20
                }
                Rectangle {
                    id: textEditRectangle
                    Layout.fillWidth: true
                    height: 150
                    color: "lightGrey"
                    radius: 5
                    clip: true
                    TextEdit {
                        id: textEdit
                        anchors.left: parent.left
                        anchors.leftMargin: 5
                        height: contentHeight
                        width: parent.width - 5
                        selectByMouse: true
                        wrapMode: TextEdit.Wrap
                        font.pixelSize: 20
                        text: "11111111111111111111111111111111111111111111111111111333333333333



                               adwadawdawdawdawdawdadwadadwwddaaddaaaaaaaaaaaaaaaaa3333333dadwadadawdawdawdawdawdawdawdawdwaddwad333333333322222222aaaaaaaaaaaaasssssssssssssssssssssssssddddddddddddddddaaaaaaaa2"
                        y: -vbar.position * textEdit.height

                        MouseArea {
                            anchors.fill: parent
                            onWheel: {
                                if (wheel.angleDelta < 0){
                                    textEdit.y -= 10
                                } else {
                                    textEdit.y += 10
                                }
                            }
                        }

                        ScrollBar {
                            id: vbar
                            hoverEnabled: true
                            active: hovered || pressed
                            orientation: Qt.Vertical
                            size: textEditRectangle.height / textEdit.height
                            implicitHeight: 20
                            width: 10
                            anchors.top: parent.top
                            anchors.right: parent.right
                            anchors.bottom: parent.bottom
                            policy: ScrollBar.AlwaysOn
                        }
                    }
                }
                Rectangle {
                    width: 50
                }
            }
            RowLayout {
                spacing: 20
                Rectangle {
                    Layout.fillWidth: true
                }

                Rectangle {
                    width: 80
                    height: 40
                    color: "grey"
                    Text {
                        anchors.centerIn: parent
                        text: "清除"
                    }

                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            textInput.clear()
                            textEdit.clear()
                        }
                    }
                }

                Rectangle {
                    width: 80
                    height: 40
                    color: "grey"
                    Text {
                        anchors.centerIn: parent
                        text: "保存"
                    }
                    MouseArea {
                        anchors.fill: parent
                        onClicked: {
                            textWindow.close()
//                            saveTheFile.getInputText(getChoseDay, textInput.text, textEdit.text)
                            textInput.clear()
                            textEdit.clear()
                        }
                    }
                }

                Rectangle {
                    width: 40
                }
            }
        }
    }
}
