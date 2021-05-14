import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.5
import QtQml.Models 2.1
import FishUI 1.0 as FishUI

FishUI.Window {
    id: root
    width: 600
    height: 700
    minimumWidth: 600
    minimumHeight: 700
    visible: true
    title: qsTr("Hello World")

    property var timeNumber: 0

    function timeRunning(){
        if (timer.running && timeNumber === 0){
             var lastTimeMonth = currentDateTimeTest()
             var lastMonthTextT
            timeNumber++
            lastTimeMonth = lastTimeMonth - 1
            if (lastTimeMonth === 0){
                lastMonthTextT = 31
            }
            else if (lastTimeMonth === 2){
                lastMonthTextT = 28
            } else if (lastTimeMonth % 2 === 1 && lastTimeMonth <= 7){
                lastMonthTextT = 31
            } else if (lastTimeMonth % 2 === 0 && lastTimeMonth <= 7){
                lastMonthTextT = 30
            } else if ((lastTimeMonth + 1) % 2 === 1 && lastTimeMonth > 7){
                lastMonthTextT = 31
            } else if ((lastTimeMonth + 1) % 2 === 2 && lastTimeMonth > 7){
                lastMonthTextT = 30
            }

            var initialNumber = currentDateTimeTest()
            var dateNumber
            calendarMonth.comboboxIndex = Number(initialNumber - 1)
            if (initialNumber === 2){
                dateNumber = 28
            } else if (initialNumber % 2 === 1 && initialNumber <= 7){
                dateNumber = 31
            } else if (initialNumber % 2 === 0 && initialNumber <= 7){
                dateNumber = 30
            } else if ((initialNumber + 1) % 2 === 1 && initialNumber > 7){
                dateNumber = 31
            } else if ((initialNumber + 1) % 2 === 0 && initialNumber > 7){
                dateNumber = 30
            }
            calendarDate.yaerToDateCalculation(getTodatYear())
            calendarDate.interval(initialNumber)
            calendarDate.dateNumber = dateNumber
            calendarDate.lastMonthText = lastMonthTextT
            calendarDate.todayDateToColor = getTodayDate()
            calendarDate.todayMonthToColor = currentDateTimeTest()
            calendarMonth.comboBoxYearCurrentIndex = getTodatYear() - 2000
//            getTimeDate.getTimeDateRet(Date().toString())
//            console.log(getTimeDate.getTimeDateRet(Date().toString()))
        }
    }

    function currentDateTime() {
        return Qt.formatDateTime(new Date(), "yyyy-MM-dd hh:mm:ss ddd");
}
    function currentDateTimeTest() {
        return Qt.formatDateTime(new Date(), "MM");
    }
    function getTodayDate() {
        return Qt.formatDateTime(new Date(), "dd");
    }
    function getTodatYear() {
        return Qt.formatDateTime(new Date(), "yyyy");
    }

    Timer {
        id: timer
        interval: 500
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

        Rectangle {
            Layout.fillWidth: true
            height: 50
            Text {
                id: timeText
                font.pixelSize: 40
            }
        }

        CalendarMonth {
            id: calendarMonth
            height: 50
            Layout.fillWidth: true
            onPressed: {
                calendarDate.interval(comboboxNumber)
                calendarDate.lastMonth(comboboxNumber)
                calendarDate.todayColor(comboboxNumber)
            }

//            transitions: Transition {
//                PropertyAnimation {
//                    id: calendarDateTransition
//                    target: calendarDate
//                    property: "opacity"
//                    to: 100
//                }
//            }

            onYearPressed: {
                calendarDate.yaerToDateCalculation(yearNumber)
                calendarDate.interval(comboBoxMonthText)
                calendarDate.visible = false
                calendarDate.visible = true
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
        }

    }
}
