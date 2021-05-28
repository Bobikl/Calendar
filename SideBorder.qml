import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
import InsertSql 1.0
Item {
    id: item
    property int titleYear: 0
    property int titleMonth: 0
    property var titleText
    property var contentText
    property int s: 0
    signal locationChoseLabel(int year, int month)
    signal showLabelContent (var showDate)
    signal deleteLabel (var deleteDate)

    ListView {
        spacing: 10
        id: sideBorderListView
        anchors.fill: parent
        model: ListModel{
            id: model
        }

        delegate: sideBorderListViewComponent
        clip: true
    }
    Component {
        id: sideBorderListViewComponent
        Rectangle {
            width: item.width
            height: 100
            radius: 10
            border.color: "black"
            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.LeftButton | Qt.RightButton
                onClicked: {
                    if (mouse.button === Qt.RightButton){
                        contentMenu.popup()
                    } else {
                        splitTitle(dateText.text)
                        item.locationChoseLabel(Number(titleYear), Number(titleMonth))
                    }
                }
            }
            Menu {
                id: contentMenu
                MenuItem {
                    text: "查看"
                    onTriggered: {
                        titleText = textOne.text
                        contentText = textTwo.text
                        item.showLabelContent(dateText.text)
                    }
                }
                MenuItem {
                    text: "删除"
                    onTriggered: {
                        item.deleteLabel(dateText.text)
                    }
                }
            }
            GridLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                rows: 3
                columns: 2
                Text {
                    text: "日期"
                }
                Text {
                    id: dateText
                    text: date
                }
                Text {
                    text: "标题"
                }
                Text {
                    id: textOne
                    text: title
                }
                Text {
                    text: "内容"
                }
                TextEdit {
                    id: textTwo
                    text: content
                    clip: true
                }
            }
        }
    }

    function appendContent(){
        s = sqlLite.getSqlSize() -1
        if (s !== -1){
            for (var i = 0; i <= s; i++){
                var split = (sqlLite.slideInsert(i)).split("-")
                var date = split[0] + "-" + split[1] + "-" + split[2]
                model.append({"title": split[3], "content": split[4], "date": date})
            }
        }
    }

    function deleteContent(){
        model.clear()
        s = sqlLite.getSqlSize() -1
        if (s !== -1){
            for (var i = 0; i <= s; i++){
                var split = (sqlLite.slideInsert(i)).split("-")
                var date = split[0] + "-" + split[1] + "-" + split[2]
                model.append({"title": split[3], "content": split[4], "date": date})
            }
        }
    }
    function splitTitle(title){
        var s = title.split("-")
        titleYear = s[0]
        titleMonth = s[1]
    }
}
