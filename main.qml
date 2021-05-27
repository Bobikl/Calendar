import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Layouts 1.5
import QtQuick.Controls 2.0
import QtQml.Models 2.1
import CalendarSave 1.0
import InsertSql 1.0
import "lunar.js" as T1
import FishUI 1.0 as FishUI

FishUI.Window {
    id: root
    width: 840 + sideBorderWidth
    height: 700
    minimumWidth: 840
    minimumHeight: 700
    visible: true
    title: qsTr("Calendar")

//    Behavior on width {
//        NumberAnimation {
//            duration: 2000
//        }
//    }

    QtObject{
        Component.onCompleted: {
            sqlLite.conectionSql()
            timeRunning()
        }
    }
    property int sideBorderWidth: 0

    function timeRunning(){
        if (saveTheFile.getFileNameNumber() === 0){
            sideBorder.visible = false
            sideBorderWidth = 0
        } else {
            sideBorder.visible = true
            sideBorderWidth = 280
        }
        calendarDate.yearToDateCalculation(getTodatYear())
        calendarDate.lunarYear = getTodatYear()
        calendarDate.lunarMonth = getTodayMonth()
        calendarDate.year = getTodatYear()
        calendarDate.month = getTodayMonth()
        calendarDate.date = getTodayDate()
        calendarDate.comboBoxYearChose = getTodatYear()
        var lastTimeMonth = getTodayMonth()
        var initialNumber = getTodayMonth()
        calendarDate.lastMonth(lastTimeMonth)
        calendarMonth.comboboxIndex = Number(initialNumber)
        calendarDate.interval(initialNumber)
        calendarMonth.comboBoxYearCurrentIndex = getTodatYear() - 2000
        calendarDate.choseMonth = calendarMonth.comboBoxMonthText
        calendarDate.choseYear = calendarMonth.comboBoxYearText
        addTextWindow.refreshChoseMonth = getTodayMonth()
        sideBorder.appendContent()
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

    SaveTheFile {
        id: saveTheFile
    }

    SqlLite {
        id: sqlLite
    }

    Timer {
        id: timer
        interval: 100
        running: true
        repeat: true
        triggeredOnStart: true
        onTriggered: {
            timeText.text = currentDateTime()
        }
    }

    Popup {
        id: myPopup
        width: 150
        height: 0
        modal: true
        focus: true
        dim: false
        x: (root.width - myPopup.width - sideBorderWidth) / 2
        background: Rectangle{
            anchors.fill: parent
            radius: 5
            color: "grey"
            opacity: 0.8
            Text {
                id: popupText
                anchors.centerIn: parent
                text: "NULL"
                clip: true
            }
        }
        onOpened: {
            popupCloseTime.start()
            sequentialAnimationPopup.start()
            myPopup.height = 0
            myPopup.y = 0
            myPopup.opacity = 1
        }
        onClosed: {
            myPopup.height = 0
            myPopup.y = 0
            myPopup.opacity = 1
        }

        Timer {
            id: popupCloseTime
            interval: 1000
            running: false
            onTriggered: {
                popupCloseAnimation.start()
            }
        }
        ParallelAnimation {
            id: sequentialAnimationPopup
            running: false
            PropertyAnimation {
                id: popupOpenAnimationY
                duration: 300
                target: myPopup
                property: "y"
                from: 0
                to: 10
            }
            PropertyAnimation {
                id: popupOpenAnimationHeight
                duration: 1000
                target: myPopup
                easing.type: Easing.OutCubic
                property: "height"
                from: 0
                to: 40
            }
        }
        PropertyAnimation {
            id: popupCloseAnimation
            duration: 300
            running: false
            target: myPopup
            property: "opacity"
            from: 1
            to: 0
            onStarted: {
                popupCloseTime.stop()
            }
            onStopped: {
                myPopup.close()
            }
        }
    }


    RowLayout {
        anchors.margins: FishUI.Units.smallSpacing
        anchors.fill: parent
        ColumnLayout {
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
                        font.pixelSize: 25
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
                    addTextWindow.refreshChoseMonth = comboboxNumber
                }
                onYearPressed: {
                    calendarDate.lunarYear = yearNumber
                    calendarDate.yearToDateCalculation(yearNumber)
                    calendarDate.interval(comboBoxMonthText)
                    calendarDate.choseYear = yearNumber
                    calendarDate.comboBoxYearChose = yearNumber
                    addTextWindow.refreshChoseYear = yearNumber
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
                onSwitchToYearPressed: {
                    if(switchToYearPressedNumber === 0){
                        calendarMonth.switchToLastYearComboBoxYear()
                    } else if (switchToYearPressedNumber === 1){
                        calendarMonth.switchToNextYearComboBoxYear()
                    }

                }

                onShowAddTextWindow: {
                    addTextWindow.clearText()
                    addTextWindow.getChoseDay = calendarDate.choseYear + "-" + calendarDate.choseMonth + "-" + calendarDate.returnChoseDay
                    addTextWindow.splitChoseDay()
                    addTextWindow.show()
                }
                onShowSaveSign: {
                    addTextWindow.clearText()
                    addTextWindow.getChoseDay = calendarDate.choseYear + "-" + calendarDate.choseMonth + "-" + calendarDate.returnChoseDay
                    addTextWindow.splitChoseDay()
                    addTextWindow.showTitleAndContent(first, second)
                    addTextWindow.show()
                }
            }
        }
        ColumnLayout {
            Rectangle {
                height:45
            }
            SideBorder{
                id: sideBorder
                Layout.fillHeight: true
                width: 280
                visible: false
                onLocationChoseLabel: {
                    calendarDate.interval(month)
                    calendarDate.lunarMonth = month
                    calendarDate.lastMonth(month)
                    calendarDate.choseMonth = month
                    calendarDate.lunarYear = year
                    calendarDate.yearToDateCalculation(year)
                    calendarDate.choseYear = year
                    calendarDate.comboBoxYearChose = year
                    calendarMonth.comboBoxYearCurrentIndex = year - 2000
                    calendarMonth.comboboxIndex = month
                }
                onShowLabelContent: {
                    addTextWindow.getChoseDay = showDate
                    addTextWindow.splitChoseDay()
                    addTextWindow.showTitleAndContent(titleText, contentText)
                    addTextWindow.show()
                }
                onDeleteLabel: {
                    addTextWindow.getChoseDay = deleteDate
                    addTextWindow.addTextWindowDelete()
                }
            }
        }
    }

    AddTextWindow {
        id: addTextWindow
        width: 600
        height: 400
        maximumWidth: addTextWindow.width
        maximumHeight: addTextWindow.height
        minimumHeight: addTextWindow.height
        minimumWidth: addTextWindow.width
        onSavePressed: {
            calendarDate.addTextDate = D
            calendarDate.addTextMonth = M
            calendarDate.addTextYear = Y
            sideBorder.deleteContent()
            sideBorderWidth = 280
            sideBorder.visible = true
        }
        onAddSuccessOrFaile: {
            noticeF(notice)
        }
        onDeleteFile: {
            if (saveTheFile.getFileNameNumber() === 0){
                sideBorder.visible = false
                sideBorderWidth = 0
            }
            calendarDate.interval(DM)
            calendarDate.addTextDate = -100
            calendarDate.addTextMonth = -100
            calendarDate.addTextYear = -100
            sideBorder.deleteContent()
        }
    }
    function noticeF(noticeText){
        popupText.text = noticeText
        myPopup.open()
    }
}
