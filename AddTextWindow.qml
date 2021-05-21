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
    property int choseYearT: 0
    property int choseMonthT: 0
    property int choseDateT: 0
    signal savePressed(var D, var M, var Y)
    signal addSuccessOrFaile(var notice)
    signal deleteFile(var DY, var DM, var DD)
    //刷新
    property int refreshChoseYear: 0
    property int refreshChoseMonth: 0

    SaveTheFile {
        id: saveTheFile
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.leftMargin: 20
        anchors.rightMargin: 20
        anchors.bottomMargin: 20

        Text {
            id: timeText
            font.pixelSize: 30
            text: getChoseDay
            Layout.alignment: Qt.AlignHCenter
        }

        Item {
            Layout.fillWidth: true
            Layout.fillHeight: true

            GridLayout {
                anchors.fill: parent
                rows: 2
                columns: 2
                columnSpacing: 20
                rowSpacing: 10

                Text {
                    text: "标题"
                    font.pixelSize: 20
                }

                TextField {
                    id: textInput
                    Layout.fillWidth: true
                    height: 30
                    selectByMouse: true
                    font.pixelSize: 20
                    focus: true
                    clip: true
                    KeyNavigation.tab: textEdit
                }

                Text {
                    text: "内容"
                    font.pixelSize: 20
                    Layout.alignment: Qt.AlignTop
                }

                Flickable {
                    id: textEditFlickable
                    Layout.fillWidth: true
                    Layout.fillHeight: true
                    clip: true
                    contentHeight: textEdit.height
                    contentWidth: textEdit.width
                    ScrollBar.vertical: ScrollBar {}
                    Rectangle {
                        id: backgroundRec
                        width: textEdit.width
                        height: textEdit.height
                        color: "lightGrey"
                        radius: 8
                    }

                    function ensureVisible(r)
                    {
                        if (contentX >= r.x)
                            contentX = r.x;
                        else if (contentX+width <= r.x+r.width)
                            contentX = r.x+r.width-width;
                        if (contentY >= r.y)
                            contentY = r.y;
                        else if (contentY+height <= r.y+r.height)
                            contentY = r.y+r.height-height;
                            backgroundRec.height = contentY + height
                    }

                    TextEdit {
                        id: textEdit
                        width: textEditFlickable.width
                        height: textEditFlickable.height
                        selectByMouse: true
                        font.pixelSize: 20
                        wrapMode: TextEdit.Wrap
                        onCursorRectangleChanged: textEditFlickable.ensureVisible(cursorRectangle)
                        textMargin: 5
                    }
                }
            }
        }

        RowLayout {
            Rectangle {
                Layout.fillWidth: true
            }

            Button {
                id: deleteButton
                visible: false
                text: "删除事件"
                onClicked: {
                    if (saveTheFile.deleteFile(getChoseDay)){
                        textWindow.addSuccessOrFaile("删除成功")
                    } else {
                        textWindow.addSuccessOrFaile("删除失败")
                    }
                    textWindow.deleteFile(refreshChoseYear, refreshChoseMonth, choseDateT)
                    textInput.clear()
                    textEdit.clear()
                    deleteButton.visible = false
                    addTextWindow.close()
                }
            }

            Button {
                id: clearButton
                text: "清除"
                onClicked: {
                    textInput.clear()
                    textEdit.clear()
                }
            }
            Button {
                text: "保存"
                onClicked: {
                    textWindow.close()
                    if (saveTheFile.getInputText(getChoseDay, textInput.text, textEdit.text)){
                        textWindow.savePressed(choseDateT, choseMonthT, choseYearT)
                        textWindow.addSuccessOrFaile("添加成功")
                    } else if (deleteButton.visible && textInput.text === "" && textEdit.text === ""){
                        textWindow.addSuccessOrFaile("请选删除")
//                        textWindow.deleteFile(refreshChoseYear, refreshChoseMonth, choseDateT)
                    } else {
                        textWindow.addSuccessOrFaile("添加失败")
                    }
                    textInput.clear()
                    textEdit.clear()
                }
            }
        }

        //        ColumnLayout {
        //            spacing: 20
        //            RowLayout {
        //                spacing: 10
        //                Rectangle {
        //                    width: 35
        //                }

        //                Text {
        //                    text: "标题"
        //                    font.pixelSize: 20
        //                }
        //                Rectangle {
        //                    Layout.fillWidth: true
        //                    height: 40
        //                    color: "lightGrey"
        //                    radius: 5
        //                    TextInput {
        //                        id: textInput
        //                        anchors.left: parent.left
        //                        anchors.top: parent.top
        //                        anchors.leftMargin: 5
        //                        anchors.topMargin: 5
        //                        width: parent.width
        //                        height: 30
        //                        selectByMouse: true
        //                        font.pixelSize: 20
        //                        focus: true
        //                        maximumLength: 50
        //                        clip: true
        //                        KeyNavigation.tab: textEdit
        //                    }
        //                }
        //                Rectangle {
        //                    width: 50
        //                }
        //            }

        //            RowLayout {
        //                spacing: 10
        //                Rectangle {
        //                    width: 35
        //                }
        //                Text {
        //                    text: "内容"
        //                    font.pixelSize: 20
        //                }
        //                Rectangle {
        //                    id: textEditRectangle
        //                    Layout.fillWidth: true
        //                    height: 150
        //                    color: "lightGrey"
        //                    radius: 5
        //                    clip: true
        //                    TextEdit {
        //                        id: textEdit
        //                        anchors.left: parent.left
        //                        anchors.leftMargin: 5
        //                        height: parent.height
        //                        width: parent.width - 5
        //                        selectByMouse: true
        //                        wrapMode: TextEdit.Wrap
        //                        font.pixelSize: 20
        //                        text: "11111111111111111111111111111111111111111111111111111333333333333



        //                               adwadawdawdawdawdawdadwadadwwddaaddaaaaaaaaaaaaaaaaa3333333dadwadadawdawdawdawdawdawdawdawdwaddwad333333333322222222aaaaaaaaaaaaasssssssssssssssssssssssssddddddddddddddddaaaaaaaa2"
        //                        y: -vbar.position * textEdit.height

        //                        ScrollBar {
        //                            id: vbar
        //                            hoverEnabled: true
        //                            active: hovered || pressed
        //                            orientation: Qt.Vertical
        //                            size: textEditRectangle.height / textEdit.height
        //                            implicitHeight: 20
        //                            width: 10
        //                            anchors.top: parent.top
        //                            anchors.right: parent.right
        //                            anchors.bottom: parent.bottom
        //                            policy: ScrollBar.AlwaysOn
        //                        }
        //                    }
        //                }
        //                Rectangle {
        //                    width: 50
        //                }
        //            }
        //            RowLayout {
        //                spacing: 20
        //                Rectangle {
        //                    Layout.fillWidth: true
        //                }

        //                Rectangle {
        //                    id: deleteRectangle
        //                    width: 80
        //                    height: 40
        //                    visible: false
        //                    color: "grey"
        //                    Text {
        //                        anchors.centerIn: parent
        //                        text: "删除事件"
        //                    }
        //                    MouseArea {
        //                        anchors.fill: parent
        //                        onClicked: {
        //                            if (saveTheFile.deleteFile(getChoseDay)){
        //                                textWindow.addSuccessOrFaile("删除成功")
        //                            } else {
        //                                textWindow.addSuccessOrFaile("删除失败")
        //                            }

        //                            (textWindow.deleteFile(refreshChoseYear, refreshChoseMonth, choseDateT))
        //                            textInput.clear()
        //                            textEdit.clear()
        //                            parent.visible = false
        //                            addTextWindow.close()
        //                        }
        //                    }
        //                }

        //                Rectangle {
        //                    width: 80
        //                    height: 40
        //                    color: "grey"
        //                    Text {
        //                        anchors.centerIn: parent
        //                        text: "清除"
        //                    }

        //                    MouseArea {
        //                        anchors.fill: parent
        //                        onClicked: {
        //                            textInput.clear()
        //                            textEdit.clear()
        //                        }
        //                    }
        //                }

        //                Rectangle {
        //                    width: 80
        //                    height: 40
        //                    color: "grey"
        //                    Text {
        //                        anchors.centerIn: parent
        //                        text: "保存"
        //                    }
        //                    MouseArea {
        //                        anchors.fill: parent
        //                        onClicked: {
        //                            textWindow.close()
        //                            if (saveTheFile.getInputText(getChoseDay, textInput.text, textEdit.text)){
        //                                textWindow.savePressed(choseDateT, choseMonthT, choseYearT)
        //                                textWindow.addSuccessOrFaile("添加成功")
        //                            } else {
        //                                textWindow.addSuccessOrFaile("添加失败")
        //                            }

        ////                            if (textInput.text === "" && textEdit.text === ""){
        ////                                textWindow.addSuccessOrFaile(0)
        ////                            } else {
        ////                                textWindow.addSuccessOrFaile(1)
        ////                            }
        //                            textInput.clear()
        //                            textEdit.clear()
        //                        }
        //                    }
        //                }
        //                Rectangle {
        //                    width: 40
        //                }
        //            }
        //        }
    }
    function showTitleAndContent(F, C){
        textInput.text = F
        textEdit.text = C
        deleteButton.visible = true
    }
    function clearText(){
        textInput.clear()
        textEdit.clear()
    }
}
