import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.0
import QtQml.Models 2.1

Item {
    id: item
    signal pressed (var comboboxNumber)
    signal yearPressed (var yearNumber)
    property int comboboxIndex: 0
    property int comboBoxMonthText: comboBoxMonthItemText.text
    property int comboBoxYearText: comboboxYearText.text
    property int comboBoxYearCurrentIndex: 0
    RowLayout {
        anchors.fill: parent
        ComboBox {
            id: comboboxYear
            Layout.fillWidth: true
            currentIndex: comboBoxYearCurrentIndex
            contentItem: Text{
                id: comboboxYearText
                text: "20" + comboBoxYearCurrentIndex
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
                        duration: 200
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
                    delegate: componentYear
                }
            }
        }

        Component {
            id: componentYear
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
            currentIndex: comboboxIndex - 1
            contentItem: Text {
                id: comboBoxMonthItemText
                text: comboboxIndex
                font.pixelSize: 15
                verticalAlignment: Text.AlignVCenter
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
                        duration: 200
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
                    model: 12
                    delegate: componentMonth
                    clip: true
                }
            }
            Component {
                id: componentMonth
                Rectangle {
                    height: 40
                    width: monthPopup.width
                    color: monthMouse.pressed ? comboBoxTodayYear(1) : comboBoxTodayYear(2)
                    MouseArea {
                        id: monthMouse
                        anchors.fill: parent
                        onClicked: {
                            item.pressed(Number(componentText.text))
                            comboboxDate.popup.close()
                            comboBoxMonthItemText.text = componentText.text
                            comboboxDate.currentIndex = componentText.text - 1
                        }
                    }

                    Text {
                        id: componentText
                        text: index + 1
                        anchors.centerIn: parent
                    }
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

    function switchToLastMonthToComboBoxMonth(){
        if (Number(comboBoxMonthItemText.text) > 1){
            comboBoxMonthItemText.text--
        }
    }
    function switchToNextMonthToComboBoxMonth(){
        if (Number(comboBoxMonthItemText.text) < 12){
            comboBoxMonthItemText.text++
        }
    }
    function switchToLastYearComboBoxYear(){
        comboboxYearText.text--
        comboBoxMonthItemText.text = 12
        comboboxDate.currentIndex = 11
    }
    function switchToNextYearComboBoxYear(){
        comboboxYearText.text++
        comboBoxMonthItemText.text = 1
        comboboxDate.currentIndex = 0
    }
    function sidleOnclick(year, month){
        comboBoxMonthItemText.text = month
        comboboxYearText.text = year
    }
}

