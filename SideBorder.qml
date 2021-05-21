import QtQuick 2.0
import QtQuick.Layouts 1.0
import CalendarSave 1.0
Item {
    id: item
    SaveTheFile {
        id: saveTheFile
    }

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
            GridLayout {
                anchors.fill: parent
                anchors.leftMargin: 20
                rows: 3
                columns: 2
                Text {
                    text: "日期"
                }
                Text {
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
        for (var i = 0; i < saveTheFile.getFileNameNumber(); i++){
            model.append({"title": saveTheFile.sideBorderGetFile(i), "content": saveTheFile.sideBorderGetFile(i), "date": saveTheFile.sideBorderGetFile(i)})
        }
    }
    function deleteContent(){
        model.clear()
        for (var i = 0; i < saveTheFile.getFileNameNumber(); i++){
            model.append({"title": saveTheFile.sideBorderGetFile(i), "content": saveTheFile.sideBorderGetFile(i), "date": saveTheFile.sideBorderGetFile(i)})
        }
    }
}
