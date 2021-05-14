import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import QtQml.Models 2.1

Item {
    id: item
    signal pressed (var comboboxNumber)
    signal yearPressed (var yearNumber)
    property int comboboxIndex: 0
    property int comboBoxMonthText: comboboxDate.displayText
    property int comboBoxYearCurrentIndex: 0
    RowLayout {
        anchors.fill: parent
        ComboBox {
            id: comboboxYear
            Layout.fillWidth: true
            currentIndex: comboBoxYearCurrentIndex
            contentItem: Text{
                id: comboboxYearText
                text: "2021"
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
            }

            popup: Popup {
                id: yearPopup
                y: parent.height - 6
                padding: 1
                height: 300
                width: parent.width

                background: Rectangle {
                    color: "lightGrey"
                    radius: 5
                }

                enter: Transition {
                    PropertyAnimation {
                        target: yearPopup
                        property: "height"
                        from: 0
                        to: 300
                        duration: 300
                    }

                }

                exit: Transition {
                    PropertyAnimation {
                        target: yearPopup
                        property: "height"
                        from: 300
                        to: 0
                        duration: 100
                    }
                }

                ListView {
                    id: listViewYear
                    anchors.fill: parent
                    model:50
                    clip: true
                    width: parent.width
                    delegate: testComponent
                }
            }
        }

        Component {
            id: testComponent
            Rectangle {
                width: yearPopup.width
                height: 40
                color: mousePopup.pressed ? comboBoxTodayYear(1) : comboBoxTodayYear(2)
                MouseArea {
                    id: mousePopup
                    anchors.fill: parent
                    onClicked: {
                        comboboxYear.popup.close()
                        comboboxYearText.text = yearText.text
                        item.yearPressed(Number(yearText.text))
                        comboboxYear.currentIndex = index
                    }
                }
                Text {
                    id: yearText
                    anchors.centerIn: parent
                    text: "20" + (index < 10 ? "0" + index : index)
                }
            }
        }

        ComboBox {
            id: comboboxDate
            Layout.fillWidth: true
            currentIndex: comboboxIndex
            model: ListModel {
                ListElement { text: "1" }
                ListElement { text: "2" }
                ListElement { text: "3" }
                ListElement { text: "4" }
                ListElement { text: "5" }
                ListElement { text: "6" }
                ListElement { text: "7" }
                ListElement { text: "8" }
                ListElement { text: "9" }
                ListElement { text: "10" }
                ListElement { text: "11" }
                ListElement { text: "12" }
            }
            onActivated: {
                item.pressed(Number(displayText))
            }

            popup: Popup {
                id: monthPopup
                y: parent.height - 6
                width: parent.width
                padding: 1
                height: 300
                background: Rectangle {
                    radius: 5
                    color: "lightGrey"
                }

                enter: Transition {
                    PropertyAnimation {
                        target: monthPopup
                        property: "height"
                        from: 0
                        to: 300
                        duration: 300
                    }
                }

                exit: Transition {
                    PropertyAnimation {
                        target: monthPopup
                        property: "height"
                        from: 300
                        to: 0
                        duration: 100
                    }
                }

                ListView {
                    id: listView
                    anchors.fill: parent
                    width: parent.width
                    model: comboboxDate.delegateModel
                    clip: true
                }
            }
        }
    }
    function comboBoxTodayYear(pressedNumber){
        if (pressedNumber === 1){
            return "lightGrey"
        } else {
            return "white"
        }
    }
}

