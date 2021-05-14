import QtQuick 2.0
import QtQuick.Layouts 1.0

Item {
    signal switchToLastMonthPressed (var switchLastMonth)
    signal switchToNextMonthPressed
    // 2021-01-01
    property var testNumber: 4
    property var yearTestNumber: 0
    property var dateNumber
    property var lastMonthText
    property var nextMonthDate: 0
    property var refreshDate: 0
    property var todayDateToColor: 0
    property var todayMonthToColor: 0
    property var colorDate: 0
    property var addNumber: 0
    property var listViewIndex: 0
    property int runnianDate: 0
    property int runnianAddDate: 0
    //三月前
    property int specialDate: 0
    property int choseMonth: 0
    //今天标红
    property int year: 0
    property int month: 0
    property int date: 0
    id: item
    visible: true
    GridView {
        id: gridView
        anchors.fill: parent
        model: gridViewModel()
        delegate: componentData
        clip: true
        cellWidth: parent.width / 7
        cellHeight: parent.height / 6
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
            color: rectangleTodayColor(index)
            radius: 10
            Text {
                id: delegateRectangleText
                text: dateText(index)
                anchors.centerIn: parent
                font.pixelSize: 25
                color: dateColor(index)
            }
            MouseArea {
                anchors.fill: parent
                hoverEnabled: true
                onEntered: {
                    delegateRectangle.border.color = "grey"
                }
                onExited: {
                    delegateRectangle.border.color = "white"
                }
                onClicked: {
                    if (index < testNumber){
                        item.switchToLastMonthPressed(choseMonth)
                        interval((choseMonth < 0 || choseMonth === 1) ? 1 : --choseMonth)
                    } else if((index - testNumber + 1) > dateNumber) {
                        item.switchToNextMonthPressed()
                        interval((choseMonth === 12) ? 12 : ++choseMonth)
                    }
                }
            }
        }
    }

    function dateColor(dateColorIndex){
        if (dateColorIndex < testNumber) {
            return "grey"
        } else if ((dateColorIndex + 1 - testNumber) > dateNumber) {
            return "grey"
        } else if (((dateColorIndex + 1 - testNumber) === Number(todayDateToColor)) && (addNumber === 0)){
//        }else if ((dateColorIndex + 1 - testNumber) === date && choseMonth){
            return "red"
        } else {
            return "black"
        }
    }

    function rectangleTodayColor(rectangleIndex){
        if (((rectangleIndex  + 1 - testNumber) === Number(todayDateToColor)) && (addNumber === 0)){
            return "white"
        } else {
            return "white"
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
        }
        else if (lastMonthNumber === 2){
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

    function interval(number){
        testNumber = yearTestNumber
        if (number === 2){
            dateNumber = 28 + runnianDate
        } else if (number % 2 === 1 && number <= 7){
            dateNumber = 31
        } else if (number % 2 === 0 && number <= 7){
            dateNumber = 30
        } else if ((number + 1) % 2 === 1 && number > 7){
            dateNumber = 31
        } else if ((number + 1) % 2 === 2 && number > 7){
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

    function todayColor(month){
        if ( Number(0 + String(todayMonthToColor)) === month){
            addNumber = 0
        } else {
            addNumber = 1
        }
    }

    function yaerToDateCalculation(choseYear){
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
            addNumber = 1
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
            addNumber = 1
        } else {
            yearTestNumber = 4
            addNumber = 0
        }
    }
}
