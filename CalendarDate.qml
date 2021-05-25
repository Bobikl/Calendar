import QtQuick 2.0
import QtQuick.Layouts 1.0
import "lunar.js" as T2
import CalendarSave 1.0

Item {
    id: item
    visible: true
    signal switchToLastMonthPressed (var switchLastMonth)
    signal switchToNextMonthPressed
    signal showAddTextWindow
    signal showSaveSign (var first, var second)
    signal switchToYearPressed (var switchToYearPressedNumber)
    // 2021-01-01
    property int testNumber: 4
    property int yearTestNumber: 0
    //每月天数
    property int dateNumber: 0
    property int lastMonthText: 0
    property int nextMonthDate: 0
    //2月增加天数
    property int runnianDate: 0
    //每4年增加一次
    property int runnianAddDate: 0
    //与今天判断
    property int comboBoxYearChose: 0
    //三月前
    property int specialDate: 0
    property int choseMonth: 0
    property int choseYear: 0
    property int returnChoseDay: 0
    //今天标红
    property int year: 0
    property int month: 0
    property int date: 0
    //计算润年
    property int lunarYear: 0
    property int lunarMonth: 0
    //添加后显示
    property int addTextDate: -100
    property int addTextMonth: -100
    property int addTextYear: -100
    //删除后不显示
    property int deleteTextDate: -100
    property int deleteTextMonth: -100
    property int deleteTextYear: -100
    //内容
    property var outTitle
    property var outContent

    SaveTheFile {
        id: saveTheFileToDate
    }

    GridView {
        id: gridView
        anchors.fill: parent
        model: gridViewModel()
        delegate: componentData
        clip: true
        cellWidth: item.width * ( 1 / 7)
        cellHeight: {
            if (gridView.model === 28){
                item.height / 4
            } else if (gridView.model === 35){
                item.height / 5
            } else {
                item.height / 6
            }
        }

        populate: Transition {
            NumberAnimation {
                property: "opacity"
                from: 0
                to: 1
                duration: 800
            }
        }
    }
    Component {
        id: componentData
        Rectangle {
            id: delegateRectangle
            width: item.width / 7
            height: item.height / 6
            radius: 10
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
//                onEntered: {
//                    delegateRectangle.border.color = "white"
//                }
//                onExited: {
//                    delegateRectangle.border.color = "white"
//                }
                onClicked: {
                    returnChoseDay = delegateRectangleText.text
                    if (index < testNumber && choseMonth !== 1){
                        lunarMonth--
                        item.switchToLastMonthPressed(choseMonth)
                        lastMonth(choseMonth - 1)
                        interval((choseMonth < 0 || choseMonth === 1) ? 1 : --choseMonth)
                    } else if((index - testNumber + 1) > dateNumber && choseMonth !== 12) {
                        lunarMonth++
                        item.switchToNextMonthPressed()
                        lastMonth(choseMonth + 1)
                        interval((choseMonth === 12) ? 12 : ++choseMonth)
                    } else if (choseMonth === 1 && (index < testNumber)) {
                        lunarYear--
                        lunarMonth = 12
                        choseMonth = 12
                        choseYear--
                        yearToDateCalculation(choseYear)
                        lastMonth(1)
                        item.switchToYearPressed(0)
                        interval(12)
                    } else if (choseMonth === 12 && (index - testNumber - dateNumber + 1) > 0) {
                        lunarYear++
                        lunarMonth = 1
                        choseMonth = 1
                        choseYear++
                        yearToDateCalculation(choseYear)
                        lastMonth(12)
                        item.switchToYearPressed(1)
                        interval(1)
                    } else if (!signRectangle.visible){
                        item.showAddTextWindow()
                    }
                    if (signRectangle.visible){
                        for (var i = 0; i < 2; i++){
                            if (i === 0){
                                outTitle = saveTheFileToDate.outPutFileContent(choseYear, choseMonth, (index - testNumber + 1))
                            } else {
                                outContent = saveTheFileToDate.outPutFileContent(choseYear, choseMonth, (index - testNumber + 1))
                            }
                        }
                        item.showSaveSign(outTitle, outContent)
                    }
                }
            }
            ColumnLayout {
                anchors.fill: parent
                RowLayout {
                    Rectangle {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: delegateRectangleText
                        text: dateText(index)
                        font.pixelSize: 25
                        color: dateColor(index)
                    }
                    Rectangle {
                        Layout.fillWidth: true
                    }
                }

                RowLayout {
                    Rectangle {
                        Layout.fillWidth: true
                    }
                    Text {
                        id: lunarDayText
                        text: getLunarDayText(index)
                        font.pixelSize: 15
                        color: dateColor(index)
                    }
                    Rectangle {
                        Layout.fillWidth: true
                    }

                }
                RowLayout {
                    Rectangle {
                        Layout.fillWidth: true
                    }
                    Rectangle {
                        id: signRectangle
                        visible: signColor(index)
                        radius: 50
                        width: 15
                        height: 15
                        color: "red"
                    }
                    Rectangle {
                        Layout.fillWidth: true
                    }
                }

            }
        }
    }

    function signColor(index){
        if(saveTheFileToDate.getFileName(choseYear, choseMonth, (index - testNumber + 1)) || (addTextDate === (index - testNumber + 1)
                                                                                              && addTextMonth === choseMonth
                                                                                              && addTextYear === choseYear)){
            return true
        }else {
            return false
        }
    }

    function getLunarDayText(index){
        if (((index + 1) > testNumber) && ((index - testNumber) < dateNumber)) {
            return T2.calendar.getLunartoDayIDayCn(lunarYear, lunarMonth, (index + 1 - testNumber))

        } else if (index < testNumber && lunarMonth > 1){
            return T2.calendar.getLunartoDayEvery(lunarYear, (lunarMonth - 1), (index + lunarLastMonthCalculation(lunarMonth - 1) - testNumber + 1))

        } else if ((index - testNumber + 1) > dateNumber && lunarMonth < 12){
            return T2.calendar.getLunartoDayEvery(lunarYear, (lunarMonth + 1), (index - dateNumber - testNumber + 1))

        } else if (lunarMonth === 12 && (index - testNumber + 1) > dateNumber){
            return T2.calendar.getLunartoDayEvery(lunarYear + 1, 1, (index - dateNumber - testNumber + 1))

        } else if (choseMonth === 1 && (index < testNumber)){
            return T2.calendar.getLunartoDayEvery(lunarYear - 1, 12, (index + dateNumber - testNumber + 1))
        } else {
            return "0000"
        }
    }

    function dateColor(dateColorIndex){
        if (dateColorIndex < testNumber) {
            return "grey"
        } else if ((dateColorIndex + 1 - testNumber) > dateNumber) {
            return "grey"
        }else if ((dateColorIndex + 1 - testNumber) === date && choseMonth === month && comboBoxYearChose === year){
            return "red"
        } else {
            return "black"
        }
    }

    function dateText(dateTextIndex){
        if ((dateTextIndex + 1 - testNumber) <= 0) {
            return (dateTextIndex + 1 - testNumber + lastMonthText)
        } else if ((dateTextIndex + 1 - testNumber) > dateNumber){
            return (dateTextIndex + 1 - testNumber - dateNumber)
        } else {
            return (dateTextIndex + 1 - testNumber)
        }
    }

    function gridViewModel(){
        if (nextMonthDate < 7) {
            return dateNumber + testNumber + nextMonthDate
        } else {
            return dateNumber + testNumber
        }
    }

    function lastMonth(lastMonthNumber){
        lastMonthNumber = lastMonthNumber - 1
        if (lastMonthNumber === 0){
            lastMonthText = 31
        } else if (lastMonthNumber === 2){
            lastMonthText = 28 + runnianDate
        } else if (lastMonthNumber % 2 === 1 && lastMonthNumber <= 7){
            lastMonthText = 31
        } else if (lastMonthNumber % 2 === 0 && lastMonthNumber <= 7){
            lastMonthText = 30
        } else if ((lastMonthNumber + 1) % 2 === 1 && lastMonthNumber > 7){
            lastMonthText = 31
        } else if ((lastMonthNumber + 1) % 2 === 0 && lastMonthNumber > 7){
            lastMonthText = 30
        }
    }

    function lunarLastMonthCalculation(number){
        if (number === 2){
            return (28 + runnianDate)
        } else if (number % 2 === 1 && number <= 7){
            return 31
        } else if (number % 2 === 0 && number <= 7 && number !== 2){
            return 30
        } else if ((number + 1) % 2 === 1 && number > 7){
            return 31
        } else if ((number + 1) % 2 === 0 && number > 7){
            return 30
        }
    }

    function interval(number){
        testNumber = yearTestNumber

        if (number === 2){
            dateNumber = 28 + runnianDate
        } else if (number % 2 === 1 && number <= 7){
            dateNumber = 31
        } else if (number % 2 === 0 && number <= 7 && number !== 2){
            dateNumber = 30
        } else if ((number + 1) % 2 === 1 && number > 7){
            dateNumber = 31
        } else if ((number + 1) % 2 === 0 && number > 7){
            dateNumber = 30
        }

        if (number === 2){
            testNumber = ((31 + testNumber + specialDate) % 7)
        } else if (number === 1){
            testNumber = (yearTestNumber + specialDate) % 7
        } else if (number > 2 && number <= 7){

            if ((number - 2) % 2 === 1){
                testNumber = (((number - 3) * 31 - (number - 3) / 2 * 1 + testNumber + 31 + 28 + runnianAddDate) % 7)
            }
            if ((number - 2) % 2 === 0){
                testNumber = (((number - 4) * 30 + (number - 4) / 2 * 1 ) + testNumber + 31 + 28 + 31 + runnianAddDate) % 7
            }

        } else if (number > 7){

            if ((number % 2) === 0){
                testNumber = (((number - 8) * 31 - (number - 8) / 2 * 1 + testNumber + 212 + runnianAddDate) % 7)
            }
            if ((number % 2) === 1){
                testNumber = (((number - 9) * 31 - (number - 9) / 2 * 1 + testNumber + 212 + 31 + runnianAddDate) % 7)
            }
        }
        nextMonthDate =  7 - ((dateNumber + testNumber) % 7)
        if (testNumber < 0){
            testNumber = 7 + testNumber
        }
    }

    function yearToDateCalculation(choseYear){
        var yearDifferenceValue
        var dateDifferenceValue
        var temporaryDate
        if (choseYear > 2021){
            yearDifferenceValue = choseYear - 2021

            if ((choseYear - 2020) % 4 === 0){
                runnianAddDate = ((choseYear - 2020) - (((choseYear - 2020) % 4))) / 4
                specialDate = runnianAddDate - 1
                runnianDate = 1
            } else {
                runnianDate = 0
                specialDate = runnianAddDate = ((choseYear - 2020) - (((choseYear - 2020) % 4))) / 4
            }
            dateDifferenceValue = yearDifferenceValue * 365
            temporaryDate = dateDifferenceValue % 7
            yearTestNumber = (temporaryDate + 4) % 7
        } else if (choseYear < 2021){
            yearDifferenceValue = 2021 - choseYear

            if ((choseYear - 2024) % 4 === 0){
                specialDate = ((choseYear - 2024) - (((choseYear - 2024) % 4))) / 4
                runnianAddDate = specialDate + 1
                runnianDate = 1
            } else {
                runnianDate = 0
                specialDate = runnianAddDate = ((choseYear - 2024) - (((choseYear - 2024) % 4))) / 4
            }
            dateDifferenceValue = yearDifferenceValue * 365
            temporaryDate = dateDifferenceValue % 7
            if (temporaryDate > 4){
                yearTestNumber = 4 - temporaryDate + 7
            } else {
                yearTestNumber = 4 - temporaryDate
            }
        } else {
            yearTestNumber = 4
            runnianDate = 0
        }
    }
}
