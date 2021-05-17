import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.5
import QtQml.Models 2.1
import "lunar.js" as T1
import FishUI 1.0 as FishUI

FishUI.Window {
    id: root
    width: 840
    height: 700
    minimumWidth: 840
    minimumHeight: 700
    visible: true
    title: qsTr("Hello World")


    property int timeNumber: 0

    function timeRunning(){
        if (timer.running && timeNumber === 0){
            calendarDate.yaerToDateCalculation(getTodatYear())
            calendarDate.lunarYear = getTodatYear()
            calendarDate.lunarMonth = getTodayMonth()
            calendarDate.year = getTodatYear()
            calendarDate.month = getTodayMonth()
            calendarDate.date = getTodayDate()
            calendarDate.comboBoxYearChose = getTodatYear()
            var lastTimeMonth = getTodayMonth()
            calendarDate.lastMonth(lastTimeMonth)
            var initialNumber = getTodayMonth()
            calendarMonth.comboboxIndex = Number(initialNumber)
            calendarDate.interval(initialNumber)
            calendarMonth.comboBoxYearCurrentIndex = getTodatYear() - 2000
            calendarDate.choseMonth = calendarMonth.comboBoxMonthText
            calendarDate.choseYear = calendarMonth.comboBoxYearText
            timeNumber++
        }
    }

    function currentDateTime() {
        return Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss ddd");
    }
    function getTodatYear() {
        return Qt.formatDateTime(new Date(), "yyyy");
    }
    function getTodayMonth() {
        return Qt.formatDateTime(new Date(), "MM");
    }
    function getTodayDate() {
        return Qt.formatDateTime(new Date(), "dd");
    }

    Timer {
        id: timer
        interval: 100
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            timeText.text = currentDateTime()
            timeRunning()
        }
    }

    ColumnLayout {
        anchors.fill: parent
        anchors.margins: FishUI.Units.smallSpacing

        RowLayout {
            Rectangle {
                Layout.fillWidth: true
                height: 40
                Text {
                    id: timeText
                    font.pixelSize: 30
                }
            }
            Rectangle {
                Layout.fillWidth: true
            }

            Rectangle {
                Layout.fillWidth: true
                height: 40
                Text {
                    id: lunarTimeText
                    font.pixelSize: 30
                    text: T1.calendar.getLunartoDay(getTodatYear(), getTodayMonth(), getTodayDate())
                }
            }
        }

        CalendarMonth {
            id: calendarMonth
            height: 50
            Layout.fillWidth: true
            onPressed: {
                calendarDate.lunarMonth = comboboxNumber
                calendarDate.interval(comboboxNumber)
                calendarDate.lastMonth(comboboxNumber)
                calendarDate.choseMonth = comboboxNumber
            }
            onYearPressed: {
                calendarDate.lunarYear = yearNumber
                calendarDate.yaerToDateCalculation(yearNumber)
                calendarDate.interval(comboBoxMonthText)
                calendarDate.comboBoxYearChose = yearNumber
            }
        }



        RowLayout {
            height: 50
            Layout.fillWidth: true

            Rectangle {
                Layout.fillWidth: true
                height: parent.height
                Text {
                    anchors.centerIn: parent
                    text: "星期一"
                    font.pixelSize: 20
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: parent.height
                Text {
                    anchors.centerIn: parent
                    text: "星期二"
                    font.pixelSize: 20
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: parent.height
                Text {
                    anchors.centerIn: parent
                    text: "星期三"
                    font.pixelSize: 20
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: parent.height
                Text {
                    anchors.centerIn: parent
                    text: "星期四"
                    font.pixelSize: 20
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: parent.height
                Text {
                    anchors.centerIn: parent
                    text: "星期五"
                    font.pixelSize: 20
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: parent.height
                Text {
                    anchors.centerIn: parent
                    text: "星期六"
                    font.pixelSize: 20
                }
            }
            Rectangle {
                Layout.fillWidth: true
                height: parent.height
                Text {
                    anchors.centerIn: parent
                    text: "星期日"
                    font.pixelSize: 20
                }
            }
        }

        CalendarDate {
            id: calendarDate
            Layout.fillHeight: true
            Layout.fillWidth: true

            onSwitchToLastMonthPressed: {
                calendarMonth.switchToLastMonthToComboBoxMonth()
            }
            onSwitchToNextMonthPressed: {
                calendarMonth.switchToNextMonthToComboBoxMonth()
            }
            onShowAddTextWindow: {
                addTextWindow.getChoseDay = calendarDate.choseYear + "-" + calendarDate.choseMonth + "-" + calendarDate.returnChoseDay
                addTextWindow.show()
            }
        }
    }
    AddTextWindow {
        id: addTextWindow
        width: 600
        height: 400
        maximumWidth: 600
        maximumHeight:400
    }
}
