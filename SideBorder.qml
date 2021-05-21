import QtQuick 2.0
import QtQuick.Layouts 1.0
Item {
    id: item
    ListView {
        anchors.fill: parent
        model: 1
        delegate: sideBorderListViewComponent
        clip: true
    }
    Component {
        id: sideBorderListViewComponent
        Rectangle {
            width: item.width
            height: 80
            radius: 5
            border.color: "black"
            RowLayout {
                anchors.fill: parent
                Rectangle {
                    Layout.fillWidth: true
                }
                ColumnLayout {
                    spacing: 10
                    Text {
                        id: textOne
                        text: "11111111111"
                    }
                    Text {
                        id: textTwo
                        text: "22222222222"
                    }
                }
                Rectangle {
                    Layout.fillWidth: true
                }
            }
        }
    }
}
