import QtQuick 2.0
import QtQuick.Window 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.15
import CalendarSave 1.0
import InsertSql 1.0

//Window {
//    id: textWindow
//    visible: false
//    title: "创建日程"
//    property var getChoseDay: 0
//    property int choseYearT: 0
//    property int choseMonthT: 0
//    property int choseDateT: 0
//    signal savePressed(var D, var M, var Y)
//    signal addSuccessOrFaile(var notice)
//    signal deleteFile(var DY, var DM, var DD)
//    //刷新
//    property int refreshChoseYear: 0
//    property int refreshChoseMonth: 0

//    SaveTheFile {
//        id: saveTheFile
//    }

//    SqlLite {
//        id: sqlLite
//    }

//    ColumnLayout {
//        anchors.fill: parent
//        anchors.leftMargin: 20
//        anchors.rightMargin: 20
//        anchors.bottomMargin: 20

//        Text {
//            id: timeText
//            font.pixelSize: 30
//            text: getChoseDay
//            Layout.alignment: Qt.AlignHCenter
//        }

//        Item {
//            Layout.fillWidth: true
//            Layout.fillHeight: true

//            GridLayout {
//                anchors.fill: parent
//                rows: 2
//                columns: 2
//                columnSpacing: 20
//                rowSpacing: 10

//                Text {
//                    text: "标题"
//                    font.pixelSize: 20
//                }

//                TextField {
//                    id: textField
//                    Layout.fillWidth: true
//                    height: 30
//                    selectByMouse: true
//                    font.pixelSize: 20
//                    focus: true
//                    clip: true
//                    KeyNavigation.tab: textEdit
//                }

//                Text {
//                    text: "内容"
//                    font.pixelSize: 20
//                    Layout.alignment: Qt.AlignTop
//                }

//                Flickable {
//                    id: textEditFlickable
//                    Layout.fillWidth: true
//                    Layout.fillHeight: true
//                    clip: true
//                    contentHeight: textEdit.height
//                    contentWidth: textEdit.width
//                    ScrollBar.vertical: ScrollBar {}
//                    Rectangle {
//                        id: backgroundRec
//                        width: textEdit.width
//                        height: textEdit.height
//                        color: "lightGrey"
//                        radius: 8
//                    }

//                    function ensureVisible(r)
//                    {
//                        if (contentX >= r.x)
//                            contentX = r.x;
//                        else if (contentX+width <= r.x+r.width)
//                            contentX = r.x+r.width-width;
//                        if (contentY >= r.y)
//                            contentY = r.y;
//                        else if (contentY+height <= r.y+r.height)
//                            contentY = r.y+r.height-height;
//                            backgroundRec.height = contentY + height
//                    }

//                    TextEdit {
//                        id: textEdit
//                        width: textEditFlickable.width
//                        height: textEditFlickable.height
//                        selectByMouse: true
//                        font.pixelSize: 20
//                        wrapMode: TextEdit.Wrap
//                        onCursorRectangleChanged: textEditFlickable.ensureVisible(cursorRectangle)
//                        textMargin: 5
//                    }
//                }
//            }
//        }

//        RowLayout {
//            Rectangle {
//                Layout.fillWidth: true
//            }

//            Button {
//                id: deleteButton
//                visible: false
//                text: "删除事件"
//                onClicked: {
//                    addTextWindowDelete()
//                }
//            }

//            Button {
//                id: clearButton
//                text: "清除"
//                onClicked: {
//                    textField.clear()
//                    textEdit.clear()
//                }
//            }
//            Button {
//                text: "保存"
//                onClicked: {
//                    textWindow.close()
//                    sqlLite.insertTable(choseYearT, choseMonthT, choseDateT, textField.text, textEdit.text)
//                    if (saveTheFile.getInputText(getChoseDay, textField.text, textEdit.text)){
//                        textWindow.savePressed(choseDateT, choseMonthT, choseYearT)
//                        textWindow.addSuccessOrFaile("添加成功")
//                    } else if (deleteButton.visible && textField.text === "" && textEdit.text === ""){
//                        textWindow.addSuccessOrFaile("NULL")
//                    } else {
//                        textWindow.addSuccessOrFaile("添加失败")
//                    }
//                    textField.clear()
//                    textEdit.clear()
//                    sqlLite.forEachTable()
//                }
//            }
//        }
//    }
//    function showTitleAndContent(F, C){
//        textField.text = F
//        textEdit.text = C
//        deleteButton.visible = true
//    }
//    function clearText(){
//        textField.clear()
//        textEdit.clear()
//    }
//    function addTextWindowDelete(){
//        sqlLite.deleteTable(choseYearT, choseMonthT, choseDateT)
//        if (saveTheFile.deleteFile(getChoseDay)){
//            textWindow.addSuccessOrFaile("删除成功")
//        } else {
//            textWindow.addSuccessOrFaile("删除失败")
//        }
//        textWindow.deleteFile(refreshChoseYear, refreshChoseMonth, choseDateT)
//        textField.clear()
//        textEdit.clear()
//        deleteButton.visible = false
//        addTextWindow.close()
//    }
//    function splitChoseDay(){
//        var splitVector = getChoseDay.split("-")
//        choseYearT = splitVector[0]
//        choseMonthT = splitVector[1]
//        choseDateT = splitVector[2]
//    }
//}


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

    //    SaveTheFile {
    //        id: saveTheFile
    //    }

    SqlLite {
        id: sqlLite
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
                    id: textField
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
                    addTextWindowDelete()
                }
            }

            Button {
                id: clearButton
                text: "清除"
                onClicked: {
                    textField.clear()
                    textEdit.clear()
                }
            }
            Button {
                text: "保存"
                onClicked: {
                    textWindow.close()
                    if (sqlLite.insertTable(choseYearT, choseMonthT, choseDateT, textField.text, textEdit.text)){
                        textWindow.savePressed(choseDateT, choseMonthT, choseYearT)
                        textWindow.addSuccessOrFaile("添加成功")
                    } else if (deleteButton.visible && textField.text === "" && textEdit.text === ""){
                        textWindow.addSuccessOrFaile("NULL")
                    } else {
                        textWindow.addSuccessOrFaile("添加失败")
                    }
                    textField.clear()
                    textEdit.clear()
                }
            }
        }
    }
    function showTitleAndContent(F, C){
        textField.text = F
        textEdit.text = C
        deleteButton.visible = true
    }
    function clearText(){
        textField.clear()
        textEdit.clear()
    }
    function addTextWindowDelete(){
        splitChoseDay()
        if (sqlLite.deleteTable(choseYearT, choseMonthT, choseDateT)){
            textWindow.addSuccessOrFaile("删除成功")
        } else {
            textWindow.addSuccessOrFaile("删除失败")
        }
        textWindow.deleteFile(refreshChoseYear, refreshChoseMonth, choseDateT)
        textField.clear()
        textEdit.clear()
        deleteButton.visible = false
        addTextWindow.close()
    }
    function splitChoseDay(){
        var splitVector = getChoseDay.split("-")
        choseYearT = splitVector[0]
        choseMonthT = splitVector[1]
        choseDateT = splitVector[2]
    }
}
