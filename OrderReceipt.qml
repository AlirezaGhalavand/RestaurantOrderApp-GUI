import QtQuick 2.0


//Order Receipt to print
Rectangle{
    id:orderReceipt
    visible: true
    radius: 15
    border.color: "transparent"
    border.width: 0
    anchors.centerIn: parent
    width: 300
    height: listView.height+300
    gradient: Gradient {
        GradientStop { position: 0; color: "steelblue" }
        GradientStop { position: 1; color: "white" }
    }

    //Factor title
    Text {
        id: name
        x:(parent.width-width)/2
        y: 4
        text: qsTr("رسید سفارش")
        font.bold: true
        font.pointSize: 15
    }

    //Factor Restaurant Name
    Text {
        id: name2
        x:(parent.width-width)/2
        y: 40
        text: qsTr("رستوران خورشید")
        font.pointSize: 13
    }

    //Factor List of foods
    ListView {
        id: listView
        x: 23
        y: 112
        width: 257
        height: contentHeight
        delegate: Item {
            x: 5
            width: 80
            height: 40
            Row {
                id: row1
                spacing: 10
                Text {
                    text: totalPrice
                    font.bold: true
                    font.pointSize: 10
                    anchors.verticalCenter: parent.verticalCenter

                    width: 100
                }
                Text {
                    text: quantity
                    font.bold: true
                    font.pointSize: 10
                    anchors.verticalCenter: parent.verticalCenter
                    width: 30
                }
                Text {
                    text: name
                    font.bold: true
                    font.pointSize: 15
                    anchors.verticalCenter: parent.verticalCenter

                    width: 100
                }

            }
        }
        model: listmodel/*ListModel {
            ListElement {
                name: "چلوکباب برگ"
                quantity: 4
                totalPrice:10000
            }

            ListElement {
                name: "پیتزا آمریکایی"
                quantity: 6
                totalPrice:900000
            }

            ListElement {
                name: "لم چاپس"
                quantity: 2
                totalPrice:100000
            }

            ListElement {
                name: "چلو قرمه سبزی"
                quantity: 3
                totalPrice:550000
            }
        }*/
    }

    Rectangle{
        id:totalPrice
        anchors.top: listView.bottom
        height: 50
        width: parent.width
        color: "transparent"
        Rectangle{
            id:solidSeparatorLine
            width: parent.width -20
            height: 1
            anchors.centerIn: parent
            color: "black"
        }
        Text {
            id: tomanTxt
            anchors.top: solidSeparatorLine.bottom
            anchors.right: totalPriceText.left
            anchors.rightMargin: 3
            font.pointSize: 13
            text: "تومان"
        }
        Text {
            id: totalPriceText
            anchors.top: solidSeparatorLine.bottom
            anchors.left: parent.left
            anchors.leftMargin: 30
            text: totalPrice.sum()
        }

        function sum(){
          var result = 0;
          for(var i = 0; i < listmodel.count; i++){
            result += listmodel.get(i).totalPrice;
          }
          return result;
        }
    }

    Rectangle{
        id:logos
        anchors.bottom: parent.bottom
        width: parent.width
        height: 60
        color: "transparent"
        Image {
            id: logo1
            anchors.bottom: parent.bottom
            anchors.left: parent.left
            anchors.leftMargin: 50
            width: 60
            height: 60
            source: "logos/res3.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: logo2
            anchors.bottom: parent.bottom
            anchors.centerIn: parent
            width: 84
            height: 69
            source: "logos/sun4.png"
            fillMode: Image.PreserveAspectFit
        }

        Image {
            id: logo3
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            anchors.rightMargin: 60
            anchors.bottomMargin: 5
            width: 45
            height: 45
            source: "logos/halal.png"
            fillMode: Image.PreserveAspectFit
        }

    }

    Text {
        id: nameTitle
        x: 250
        y: 91
        text: qsTr("عنوان")
        font.pixelSize: 14
    }

    Text {
        id: quantityTitle
        x: 138
        y: 91
        text: qsTr("تعداد")
        font.pixelSize: 14
    }

    Text {
        id: priceTitle
        x: 39
        y: 91
        text: qsTr("قیمت کل")
        font.pixelSize: 14
    }

    Text {
        id: dateTitle
        anchors.left: parent.left
        anchors.leftMargin: 40
        text: qsTr("تاریخ")
        font.pixelSize: 14
    }

    Text {
        id: factorNumberTitle
        anchors.right: parent.right
        anchors.rightMargin: 20
        text: qsTr("شماره رسید")
        font.pixelSize: 14
    }

    Text {
        id: dateTxt
        anchors.left: parent.left
        anchors.leftMargin: 10
        anchors.top: dateTitle.bottom
        text: new Date().toLocaleDateString()
        font.pixelSize: 14
    }

    Text {
        id: timeTxt
        anchors.left: parent.left
        anchors.leftMargin: 50
        anchors.top: dateTxt.bottom
        width: 30
        height: 10
        text: new Date().toLocaleTimeString()
        font.pixelSize: 14
    }

    Text {
        id: factorNumber
        anchors.right: parent.right
        anchors.rightMargin: 10
        anchors.top: factorNumberTitle.bottom
        width: 30
        height: 10
        text: qsTr("345")
        font.pixelSize: 13
    }
}
