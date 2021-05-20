import QtQuick 2.0
import QtQuick.Layouts 1.0
import QtQuick.Controls 2.0
Item {
    id: item
    Popup {
        width: 30
        height: 30
        modal: true
        background: Rectangle{
            anchors.fill: parent
            color: "red"
        }
    }
}
