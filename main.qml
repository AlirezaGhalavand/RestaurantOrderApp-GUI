import QtQuick 2.14
import QtQuick.Controls 2.14
//import QtQuick.Window 2.14
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.14

Item {
    id: window

    signal close;

    property int factorNumber: 1

    visible: true
    width: 900
    height: 800

    FontLoader { id:dimonaFont; source: "qrc:/fonts/Far_Dimona.ttf" }
    FontLoader { id:casablancaFont; source: "qrc:/fonts/Far_Casablanca.ttf" }
    FontLoader { id:sorayaFont; source: "qrc:/fonts/A_Soraya.ttf" }

    //listmodel for OrderReceipt
    ListModel{
        id:listmodel
    }

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
            model: listmodel
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
            id: factorNumberTitle
            anchors.right: parent.right
            anchors.rightMargin: 20
            text: qsTr("شماره رسید")
            font.pixelSize: 14
        }

        Text {
            id: factorNumber
            anchors.right: parent.right
            anchors.rightMargin: 10
            anchors.top: factorNumberTitle.bottom
            width: 30
            height: 10
            font.pixelSize: 13
        }
    }

    //منوها
    SwipeView {
        id: view
        anchors.fill: parent
        currentIndex: 2

        //منو مخلفات
        Page {
            id: page3
            title: qsTr("منو مخلفات")

            //Header
            Rectangle{
                z:1
                y:20
                height: 50
                width: parent.width
                color: "transparent"
                Text {

                    text: qsTr("منو مخلفات")
                    font.pointSize: 25
                    font.bold: true
                    anchors.centerIn: parent
                    color: "#041A2C"
                }
            }

            //سالاد فصل
            RowLayout{
                id:lay000
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:90
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl000
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    //                            font.bold: true
                    font.family: casablancaFont.name
                    text: qsTr("سالاد فصل")
                    font.pointSize: 13
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image00.y = 50
                            image00.z = 2
                            lay000.z = 2
                            lbl000.z = 2
                            image00.width = 400
                            image00.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image00.z = 0
                            lay000.z = 0
                            lbl000.z = 0
                            image00.width = 300
                            image00.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: {spinBox00.increase()}
                    }
                }

                Rectangle{
                    id: image00
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/fasl2.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox00
                    anchors.left: parent.left
                    Layout.alignment: Qt.AlignLeft
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                }
            }

            //سالاد سزار
            RowLayout{
                id:lay111
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:160
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl111
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    //                            font.bold: true
                    font.family: casablancaFont.name
                    text: qsTr("سالاد سزار")
                    font.pointSize: 13
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image111.y = 50
                            image111.z = 2
                            lay111.z = 2
                            lbl111.z = 2
                            image111.width = 400
                            image111.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image111.z = 0
                            lay111.z = 0
                            lbl111.z = 0
                            image111.width = 300
                            image111.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: spinBox111.increase()
                    }
                }

                Rectangle{
                    id: image111
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/cesar4.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox111
                    anchors.left: parent.left
                    Layout.alignment: Qt.AlignLeft
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }
            }

            //ترشی
            RowLayout{
                id:lay222
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:230
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl222
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    //                            font.bold: true
                    font.family: casablancaFont.name
                    text: qsTr("ترشی")
                    font.pointSize: 13
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image222.y = 50
                            image222.z = 2
                            lay222.z = 2
                            lbl222.z = 2
                            image222.width = 400
                            image222.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image222.z = 0
                            lay222.z = 0
                            lbl222.z = 0
                            image222.width = 300
                            image222.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: spinBox222.increase()
                    }
                }

                Rectangle{
                    id: image222
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/torshi2.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox222
                    anchors.left: parent.left
                    Layout.alignment: Qt.AlignLeft
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }
            }

            //زیتون
            RowLayout{
                id:lay333
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:300
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl333
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    //font.bold: true
                    font.family:casablancaFont.name
                    text: qsTr("زیتون")
                    font.pointSize: 13
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image333.y = 50
                            image333.z = 2
                            lay333.z = 2
                            lbl333.z = 2
                            image333.width = 400
                            image333.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image333.z = 0
                            lay333.z = 0
                            lbl333.z = 0
                            image333.width = 300
                            image333.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: spinBox333.increase()
                    }
                }

                Rectangle{
                    id: image333
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/zeytoon1.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox333
                    anchors.left: parent.left
                    Layout.alignment: Qt.AlignLeft
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }
            }

            //کشک بادمجان
            RowLayout{
                id:lay444
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:370
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl444
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    //font.bold: true
                    font.family:casablancaFont.name
                    text: qsTr("کشک بادمجان")
                    font.pointSize: 13
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image444.y = 50
                            image444.z = 2
                            lay444.z = 2
                            lbl444.z = 2
                            image444.width = 400
                            image444.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image444.z = 0
                            lay444.z = 0
                            lbl444.z = 0
                            image444.width = 300
                            image444.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: spinBox444.increase()
                    }
                }

                Rectangle{
                    id: image444
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/kashk1.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox444
                    anchors.left: parent.left
                    Layout.alignment: Qt.AlignLeft
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }
            }

            //میرزا قاسمی
            RowLayout{
                id:lay555
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:440
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl555
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    //font.bold: true
                    font.family:casablancaFont.name
                    text: qsTr("میرزا قاسمی")
                    font.pointSize: 13
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image555.y = 50
                            image555.z = 2
                            lay555.z = 2
                            lbl555.z = 2
                            image555.width = 400
                            image555.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image555.z = 0
                            lay555.z = 0
                            lbl555.z = 0
                            image555.width = 300
                            image555.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: spinBox555.increase()
                    }
                }

                Rectangle{
                    id: image555
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/mirza1.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox555
                    anchors.left: parent.left
                    Layout.alignment: Qt.AlignLeft
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }
            }

            //چای دارچین
            RowLayout{
                id:lay666
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:510
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl666
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    //font.bold: true
                    font.family:casablancaFont.name
                    text: qsTr("چای دارچین")
                    font.pointSize: 13
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image666.y = 50
                            image666.z = 2
                            lay666.z = 2
                            lbl666.z = 2
                            image666.width = 400
                            image666.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image666.z = 0
                            lay666.z = 0
                            lbl666.z = 0
                            image666.width = 300
                            image666.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: spinBox666.increase()
                    }
                }

                Rectangle{
                    id: image666
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/Tea1.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox666
                    anchors.left: parent.left
                    Layout.alignment: Qt.AlignLeft
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }
            }

            //دوغ سنتی
            RowLayout{
                id:lay777
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:580
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl777
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    //font.bold: true
                    font.family:casablancaFont.name
                    text: qsTr("دوغ سنتی")
                    font.pointSize: 13
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image777.y = 50
                            image777.z = 2
                            lay777.z = 2
                            lbl777.z = 2
                            image777.width = 400
                            image777.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image777.z = 0
                            lay777.z = 0
                            lbl777.z = 0
                            image777.width = 300
                            image777.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: spinBox777.increase()
                    }
                }

                Rectangle{
                    id: image777
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/doogh1.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox777
                    anchors.left: parent.left
                    Layout.alignment: Qt.AlignLeft
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }
            }

            //دلستر
            RowLayout{
                id:lay888
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:650
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl888
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    //font.bold: true
                    font.family:casablancaFont.name
                    text: qsTr("ماءالشعیر")
                    font.pointSize: 13
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image888.y = 50
                            image888.z = 2
                            lay888.z = 2
                            lbl888.z = 2
                            image888.width = 400
                            image888.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image888.z = 0
                            lay888.z = 0
                            lbl888.z = 0
                            image888.width = 300
                            image888.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: spinBox888.increase()
                    }
                }

                Rectangle{
                    id: image888
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/delester2.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox888
                    anchors.left: parent.left
                    Layout.alignment: Qt.AlignLeft
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }
            }

            Image {
                id: imagePage3
                anchors.fill: parent
                opacity: 0.1
                visible: true
                layer.enabled: false
                source: "pics/IranianRestaurantBackground.jpg"
                fillMode: Image.PreserveAspectCrop
            }

            //Footer: Buttons and busyIndicator
            Rectangle{
                width: parent.width
                height: 100
                anchors.bottom: parent.bottom
                color: "transparent"

                StyledButton{
                    id:exitBtn
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 15
                    anchors.left: parent.left
                    anchors.leftMargin: 20
                    txt: "خروج"
                    txtSize: 17
                    onClicked: messageDialog_exit.open()
                }
                MessageDialog {
                    id:messageDialog_exit
                    title: "خروج"
                    informativeText: "آیا برای خروج از برنامه اطمینان دارید؟"
                    icon: MessageDialog.Critical
                    standardButtons: MessageDialog.Yes | MessageDialog.No

                    onYes: window.close()
                }

                StyledButton{
                    id:buyBtn
                    anchors.bottom: parent.bottom
                    anchors.bottomMargin: 15
                    anchors.right: parent.right
                    anchors.rightMargin: 20
                    customWidth: 150
                    txt: "ثبت سفارش"
                    txtSize: 17
                    onClicked:{

                        listmodel.clear()

                        //add allItems to the factor
                        //ماهیچه
                        if(spinBox.value > 0)
                            listmodel.append({"name": lbl0.text, "quantity":spinBox.value, "totalPrice":spinBox.value*80000})
                        if(spinBox1.value > 0)
                            listmodel.append({"name": lbl1.text, "quantity":spinBox1.value, "totalPrice":spinBox1.value*30000})
                        if(spinBox2.value > 0)
                            listmodel.append({"name": lbl2.text, "quantity":spinBox2.value, "totalPrice":spinBox2.value*35000})
                        if(spinBox3.value > 0)
                            listmodel.append({"name": lbl3.text, "quantity":spinBox3.value, "totalPrice":spinBox3.value*30000})
                        if(spinBox4.value > 0)
                            listmodel.append({"name": lbl4.text, "quantity":spinBox4.value, "totalPrice":spinBox4.value*45000})
                        if(spinBox5.value > 0)
                            listmodel.append({"name": lbl5.text, "quantity":spinBox5.value, "totalPrice":spinBox5.value*40000})
                        //GhormeSabzi
                        if(spinBox6.value > 0)
                            listmodel.append({"name": lbl6.text, "quantity":spinBox6.value, "totalPrice":spinBox6.value*28000})
                        //Gheyme
                        if(spinBox7.value > 0)
                            listmodel.append({"name": lbl7.text, "quantity":spinBox7.value, "totalPrice":spinBox7.value*28000})
                        //American Pizza
                        if(spinBox0.value > 0)
                            listmodel.append({"name": lbl00.text, "quantity":spinBox0.value, "totalPrice":spinBox0.value*60000})
                        //Italian Pizza
                        if(spinBox11.value > 0)
                            listmodel.append({"name": lbl11.text, "quantity":spinBox11.value, "totalPrice":spinBox11.value*60000})
                        if(spinBox22.value > 0)
                            listmodel.append({"name": lbl22.text, "quantity":spinBox22.value, "totalPrice":spinBox22.value*65000})
                        if(spinBox33.value > 0)
                            listmodel.append({"name": lbl33.text, "quantity":spinBox33.value, "totalPrice":spinBox33.value*55000})
                        if(spinBox44.value > 0)
                            listmodel.append({"name": lbl44.text, "quantity":spinBox44.value, "totalPrice":spinBox44.value*50000})
                        if(spinBox55.value > 0)
                            listmodel.append({"name": lbl55.text, "quantity":spinBox55.value, "totalPrice":spinBox55.value*65000})
                        if(spinBox66.value > 0)
                            listmodel.append({"name": lbl66.text, "quantity":spinBox66.value, "totalPrice":spinBox66.value*60000})
                        if(spinBox77.value > 0)
                            listmodel.append({"name": lbl77.text, "quantity":spinBox77.value, "totalPrice":spinBox77.value*55000})
                        if(spinBox88.value > 0)
                            listmodel.append({"name": lbl88.text, "quantity":spinBox88.value, "totalPrice":spinBox88.value*68000})
                        if(spinBox99.value > 0)
                            listmodel.append({"name": lbl99.text, "quantity":spinBox99.value, "totalPrice":spinBox99.value*48000})

                        //Drink and Salad Menu
                        if(spinBox00.value > 0)
                            listmodel.append({"name": lbl000.text, "quantity":spinBox00.value, "totalPrice":spinBox00.value*10000})
                        if(spinBox111.value > 0)
                            listmodel.append({"name": lbl111.text, "quantity":spinBox111.value, "totalPrice":spinBox111.value*20000})
                        if(spinBox222.value > 0)
                            listmodel.append({"name": lbl222.text, "quantity":spinBox222.value, "totalPrice":spinBox222.value*5000})
                        if(spinBox333.value > 0)
                            listmodel.append({"name": lbl333.text, "quantity":spinBox333.value, "totalPrice":spinBox333.value*5000})
                        if(spinBox444.value > 0)
                            listmodel.append({"name": lbl444.text, "quantity":spinBox444.value, "totalPrice":spinBox444.value*25000})
                        if(spinBox555.value > 0)
                            listmodel.append({"name": lbl555.text, "quantity":spinBox555.value, "totalPrice":spinBox555.value*25000})
                        if(spinBox666.value > 0)
                            listmodel.append({"name": lbl666.text, "quantity":spinBox666.value, "totalPrice":spinBox666.value*5000})
                        if(spinBox777.value > 0)
                            listmodel.append({"name": lbl777.text, "quantity":spinBox777.value, "totalPrice":spinBox777.value*6000})
                        if(spinBox888.value > 0)
                            listmodel.append({"name": lbl888.text, "quantity":spinBox888.value, "totalPrice":spinBox888.value*5000})

                        dateTxt.text = new Date().toLocaleDateString()
                        timeTxt.text = new Date().toLocaleTimeString()

                        factorNumber.text = window.factorNumber

                        window.factorNumber++

                        busyIndicator.running = true

                        buyBtn.enabled = false

                        delayLoadingFactor.start()
                    }
                }

                BusyIndicator{
                    id:busyIndicator
                    anchors.centerIn: parent
                    z:2
                    //        Component.onCompleted: {
                    //                            contentItem.pen = "transparent"
                    //                            contentItem.fill = "red"
                    //                        }

                    width: 100
                    height: 100

                    running: false


                    contentItem: Item {
                        implicitWidth: 64
                        implicitHeight: 64

                        Item {
                            id: busyItem
                            x: parent.width / 2 - 32
                            y: parent.height / 2 - 32
                            width: 64
                            height: 64
                            opacity: busyIndicator.running ? 1 : 0

                            Behavior on opacity {
                                OpacityAnimator {
                                    duration: 250
                                }
                            }

                            RotationAnimator {
                                target: busyItem
                                running: busyIndicator.visible && busyIndicator.running
                                from: 0
                                to: 360
                                loops: Animation.Infinite
                                duration: 1250
                            }

                            Repeater {
                                id: repeater
                                model: 6

                                Rectangle {
                                    x: busyItem.width / 2 - width / 2
                                    y: busyItem.height / 2 - height / 2
                                    implicitWidth: 10
                                    implicitHeight: 10
                                    radius: 5
                                    color: "#FF0000"
                                    transform: [
                                        Translate {
                                            y: -Math.min(busyItem.width, busyItem.height) * 0.5 + 5
                                        },
                                        Rotation {
                                            angle: index / repeater.count * 360
                                            origin.x: 5
                                            origin.y: 5
                                        }
                                    ]
                                }
                            }
                        }
                    }
                }

                Timer{
                    id:delayLoadingFactor
                    interval: 2000

                    repeat: false
                    running: false
                    onTriggered: {

                        busyIndicator.running = false

                        var stat = orderReceipt.grabToImage(function(result) {
                            PRINT.print(result.image,Qt.size(orderReceipt.width,orderReceipt.height)); //result.image holds the QVariant
                        });
                        console.log("result:"+stat)

                        buyBtn.enabled = true

                    }
                }
            }
        }

        //منو فرنگی
        Page {
            id:page2
            title: qsTr("منو غذای فرنگی")

            Rectangle{
                id:titleRect2
                z:1
                y:20
                height: 50
                width: parent.width
                color: "transparent"
                Text {
                    text: qsTr("منو غذای فرنگی")
                    font.family: casablancaFont.name
                    font.pointSize: 18
                    //                    font.bold: true
                    anchors.centerIn: parent
                    color: "#041A2C"
                }
            }

            ScrollView{
                anchors.top: titleRect2.bottom
                anchors.topMargin: 20
                ScrollBar.vertical: ScrollBar {
                    id:verticalSB
                    hoverEnabled: true
                    //                            active: hovered || pressed
                    active: true
                    orientation: Qt.Vertical
                    //                            size: frame.height / content.height
                    anchors.top: parent.top
                    anchors.right: parent.right
                    anchors.rightMargin: 10
                    anchors.bottom: parent.bottom
                    background: Rectangle {implicitHeight: window.height-100; implicitWidth: 10; color: "transparent" }
                    contentItem: Rectangle {implicitWidth: 10; implicitHeight: 10;
                        color: {
                            if(verticalSB.pressed)
                                return "#4D4D4D"
                            else if(verticalSB.hovered && !verticalSB.pressed)
                                return "grey"
                            else
                                return "#B0B0B0"
                        }
                        radius: 20
                    }
                    policy: ScrollBar.AlwaysOn
                }
                width: parent.width
                height : parent.height - 100
                contentWidth: window.width  // The important part
                contentHeight: window.height  // Same
                clip : true                   // Prevent drawing column outside the scrollview borders

                //American Pizza
                RowLayout{
                    id:lay00
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: window.width/20
                    anchors.leftMargin: window.width/20
                    y:0
                    layoutDirection: Qt.RightToLeft
                    spacing: 0

                    Label {
                        id:lbl00
                        //                    Layout.alignment: Qt.AlignRight
                        anchors.right: parent.right
                        Layout.minimumWidth: 150
                        width: 160
                        //                            font.bold: true
                        font.family: casablancaFont.name
                        text: qsTr("پیتزا آمریکایی")
                        font.pointSize: 13
                        onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                image0.y = 50
                                image0.z = 2
                                lay00.z = 2
                                lbl00.z = 2
                                image0.width = 400
                                image0.height = 300

                                //                            headerLbl.color = "transparent"
                            }
                            onExited: {
                                image0.z = 0
                                lay00.z = 0
                                lbl00.z = 0
                                image0.width = 300
                                image0.height = 55

                                //                            headerLbl.color = "#041A2C"
                            }
                            onClicked: spinBox0.increase()
                        }
                    }

                    Rectangle{
                        id: image0
                        //                    Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent
                        Layout.minimumWidth: 300
                        width: 300
                        height: 55
                        Image {
                            anchors.fill: parent
                            source: "pics/AmericanPizza.jpg"
                            fillMode: Image.PreserveAspectCrop
                        }
                    }

                    SpinBox {
                        id: spinBox0
                        anchors.left: parent.left
                        Layout.alignment: Qt.AlignLeft
                        Layout.minimumWidth: 126
                        //                        Layout.maximumWidth: 126
                        Layout.minimumHeight: 30
                        Layout.maximumHeight: 60
                        font.bold: true
                        font.pointSize: 17
                        //                        Layout.maximumWidth: 50
                    }
                }

                //Italian Pizza
                RowLayout{
                    id:lay11
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: window.width/20
                    anchors.leftMargin: window.width/20
                    y:70
                    layoutDirection: Qt.RightToLeft
                    spacing: 0

                    Label {
                        id:lbl11
                        //                    Layout.alignment: Qt.AlignRight
                        anchors.right: parent.right
                        Layout.minimumWidth: 150
                        width: 160
                        //                            font.bold: true
                        font.family: casablancaFont.name
                        text: qsTr("پیتزا ایتالیایی")
                        font.pointSize: 13
                        onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                image11.y = 50
                                image11.z = 2
                                lay11.z = 2
                                lbl11.z = 2
                                image11.width = 400
                                image11.height = 300

                                //                            headerLbl.color = "transparent"
                            }
                            onExited: {
                                image11.z = 0
                                lay11.z = 0
                                lbl11.z = 0
                                image11.width = 300
                                image11.height = 55

                                //                            headerLbl.color = "#041A2C"
                            }
                            onClicked: spinBox11.increase()
                        }
                    }

                    Rectangle{
                        id: image11
                        //                    Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent
                        Layout.minimumWidth: 300
                        width: 300
                        height: 55
                        Image {
                            anchors.fill: parent
                            source: "pics/ItalianPizza.jpg"
                            fillMode: Image.PreserveAspectCrop
                        }
                    }

                    SpinBox {
                        id: spinBox11
                        anchors.left: parent.left
                        Layout.alignment: Qt.AlignLeft
                        Layout.minimumWidth: 126
                        //                        Layout.maximumWidth: 126
                        Layout.minimumHeight: 30
                        Layout.maximumHeight: 60
                        font.bold: true
                        font.pointSize: 17
                        //                        Layout.maximumWidth: 50
                    }
                }

                //Lazania
                RowLayout{
                    id:lay22
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: window.width/20
                    anchors.leftMargin: window.width/20
                    y:140
                    layoutDirection: Qt.RightToLeft
                    spacing: 0

                    Label {
                        id:lbl22
                        //                    Layout.alignment: Qt.AlignRight
                        anchors.right: parent.right
                        Layout.minimumWidth: 150
                        width: 160
                        //                            font.bold: true
                        font.family: casablancaFont.name
                        text: qsTr("لازانیا")
                        font.pointSize: 13
                        onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                image22.y = 50
                                image22.z = 2
                                lay22.z = 2
                                lbl22.z = 2
                                image22.width = 400
                                image22.height = 300

                                //                            headerLbl.color = "transparent"
                            }
                            onExited: {
                                image22.z = 0
                                lay22.z = 0
                                lbl22.z = 0
                                image22.width = 300
                                image22.height = 55

                                //                            headerLbl.color = "#041A2C"
                            }
                            onClicked: spinBox22.increase()
                        }
                    }

                    Rectangle{
                        id: image22
                        //                    Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent
                        Layout.minimumWidth: 300
                        width: 300
                        height: 55
                        Image {
                            anchors.fill: parent
                            source: "pics/Lazania.jpeg"
                            fillMode: Image.PreserveAspectCrop
                        }
                    }

                    SpinBox {
                        id: spinBox22
                        anchors.left: parent.left
                        Layout.alignment: Qt.AlignLeft
                        Layout.minimumWidth: 126
                        //                        Layout.maximumWidth: 126
                        Layout.minimumHeight: 30
                        Layout.maximumHeight: 60
                        font.bold: true
                        font.pointSize: 17
                        //                        Layout.maximumWidth: 50
                    }
                }

                //Milano Pasta
                RowLayout{
                    id:lay33
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: window.width/20
                    anchors.leftMargin: window.width/20
                    y:210
                    layoutDirection: Qt.RightToLeft
                    spacing: 0

                    Label {
                        id:lbl33
                        //                    Layout.alignment: Qt.AlignRight
                        anchors.right: parent.right
                        Layout.minimumWidth: 150
                        width: 160
                        //font.bold: true
                        font.family:casablancaFont.name
                        text: qsTr("پاستا میلانو")
                        font.pointSize: 13
                        onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                image33.y = 50
                                image33.z = 2
                                lay33.z = 2
                                lbl33.z = 2
                                image33.width = 400
                                image33.height = 300

                                //                            headerLbl.color = "transparent"
                            }
                            onExited: {
                                image33.z = 0
                                lay33.z = 0
                                lbl33.z = 0
                                image33.width = 300
                                image33.height = 55

                                //                            headerLbl.color = "#041A2C"
                            }
                            onClicked: spinBox33.increase()
                        }
                    }

                    Rectangle{
                        id: image33
                        //                    Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent
                        Layout.minimumWidth: 300
                        width: 300
                        height: 55
                        Image {
                            anchors.fill: parent
                            source: "pics/MilanoPasta.jpg"
                            fillMode: Image.PreserveAspectCrop
                        }
                    }

                    SpinBox {
                        id: spinBox33
                        anchors.left: parent.left
                        Layout.alignment: Qt.AlignLeft
                        Layout.minimumWidth: 126
                        //                        Layout.maximumWidth: 126
                        Layout.minimumHeight: 30
                        Layout.maximumHeight: 60
                        //font.bold: true
                        font.pointSize: 17
                        //                        Layout.maximumWidth: 50
                    }
                }

                //Bluns Pasta
                RowLayout{
                    id:lay44
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: window.width/20
                    anchors.leftMargin: window.width/20
                    y:280
                    layoutDirection: Qt.RightToLeft
                    spacing: 0

                    Label {
                        id:lbl44
                        //                    Layout.alignment: Qt.AlignRight
                        anchors.right: parent.right
                        Layout.minimumWidth: 150
                        width: 160
                        //font.bold: true
                        font.family:casablancaFont.name
                        text: qsTr("پاستا بلونز")
                        font.pointSize: 13
                        onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                image44.y = 50
                                image44.z = 2
                                lay44.z = 2
                                lbl44.z = 2
                                image44.width = 400
                                image44.height = 300

                                //                            headerLbl.color = "transparent"
                            }
                            onExited: {
                                image44.z = 0
                                lay44.z = 0
                                lbl44.z = 0
                                image44.width = 300
                                image44.height = 55

                                //                            headerLbl.color = "#041A2C"
                            }
                            onClicked: spinBox44.increase()
                        }
                    }

                    Rectangle{
                        id: image44
                        //                    Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent
                        Layout.minimumWidth: 300
                        width: 300
                        height: 55
                        Image {
                            anchors.fill: parent
                            source: "pics/pastaBluns.jpg"
                            fillMode: Image.PreserveAspectCrop
                        }
                    }

                    SpinBox {
                        id: spinBox44
                        anchors.left: parent.left
                        Layout.alignment: Qt.AlignLeft
                        Layout.minimumWidth: 126
                        //                        Layout.maximumWidth: 126
                        Layout.minimumHeight: 30
                        Layout.maximumHeight: 60
                        //font.bold: true
                        font.pointSize: 17
                        //                        Layout.maximumWidth: 50
                    }
                }

                //Pane Pasta
                RowLayout{
                    id:lay55
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: window.width/20
                    anchors.leftMargin: window.width/20
                    y:350
                    layoutDirection: Qt.RightToLeft
                    spacing: 0

                    Label {
                        id:lbl55
                        //                    Layout.alignment: Qt.AlignRight
                        anchors.right: parent.right
                        Layout.minimumWidth: 150
                        width: 160
                        //font.bold: true
                        font.family:casablancaFont.name
                        text: qsTr("پاستا پنه چیکن آلفردو")
                        font.pointSize: 13
                        onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                image55.y = 50
                                image55.z = 2
                                lay55.z = 2
                                lbl55.z = 2
                                image55.width = 400
                                image55.height = 300

                                //                            headerLbl.color = "transparent"
                            }
                            onExited: {
                                image55.z = 0
                                lay55.z = 0
                                lbl55.z = 0
                                image55.width = 300
                                image55.height = 55

                                //                            headerLbl.color = "#041A2C"
                            }
                            onClicked: spinBox55.increase()
                        }
                    }

                    Rectangle{
                        id: image55
                        //                    Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent
                        Layout.minimumWidth: 300
                        width: 300
                        height: 55
                        Image {
                            anchors.fill: parent
                            source: "pics/PastaPene.jpg"
                            fillMode: Image.PreserveAspectCrop
                        }
                    }

                    SpinBox {
                        id: spinBox55
                        anchors.left: parent.left
                        Layout.alignment: Qt.AlignLeft
                        Layout.minimumWidth: 126
                        //                        Layout.maximumWidth: 126
                        Layout.minimumHeight: 30
                        Layout.maximumHeight: 60
                        //font.bold: true
                        font.pointSize: 17
                        //                        Layout.maximumWidth: 50
                    }
                }

                //Lamb Chups
                RowLayout{
                    id:lay66
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: window.width/20
                    anchors.leftMargin: window.width/20
                    y:420
                    layoutDirection: Qt.RightToLeft
                    spacing: 0

                    Label {
                        id:lbl66
                        //                    Layout.alignment: Qt.AlignRight
                        anchors.right: parent.right
                        Layout.minimumWidth: 150
                        width: 160
                        //font.bold: true
                        font.family:casablancaFont.name
                        text: qsTr("لم چاپس")
                        font.pointSize: 13
                        onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                image66.y = 50
                                image66.z = 2
                                lay66.z = 2
                                lbl66.z = 2
                                image66.width = 400
                                image66.height = 300

                                //                            headerLbl.color = "transparent"
                            }
                            onExited: {
                                image66.z = 0
                                lay66.z = 0
                                lbl66.z = 0
                                image66.width = 300
                                image66.height = 55

                                //                            headerLbl.color = "#041A2C"
                            }
                            onClicked: spinBox66.increase()
                        }
                    }

                    Rectangle{
                        id: image66
                        //                    Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent
                        Layout.minimumWidth: 300
                        width: 300
                        height: 55
                        Image {
                            anchors.fill: parent
                            source: "pics/lambChaps.jpg"
                            fillMode: Image.PreserveAspectCrop
                        }
                    }

                    SpinBox {
                        id: spinBox66
                        anchors.left: parent.left
                        Layout.alignment: Qt.AlignLeft
                        Layout.minimumWidth: 126
                        //                        Layout.maximumWidth: 126
                        Layout.minimumHeight: 30
                        Layout.maximumHeight: 60
                        //font.bold: true
                        font.pointSize: 17
                        //                        Layout.maximumWidth: 50
                    }
                }

                //BeafStake
                RowLayout{
                    id:lay77
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: window.width/20
                    anchors.leftMargin: window.width/20
                    y:490
                    layoutDirection: Qt.RightToLeft
                    spacing: 0

                    Label {
                        id:lbl77
                        //                    Layout.alignment: Qt.AlignRight
                        anchors.right: parent.right
                        Layout.minimumWidth: 150
                        width: 160
                        //font.bold: true
                        font.family:casablancaFont.name
                        text: qsTr("بیف استیک")
                        font.pointSize: 13
                        onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                image77.y = 50
                                image77.z = 2
                                lay77.z = 2
                                lbl77.z = 2
                                image77.width = 400
                                image77.height = 300

                                //                            headerLbl.color = "transparent"
                            }
                            onExited: {
                                image77.z = 0
                                lay77.z = 0
                                lbl77.z = 0
                                image77.width = 300
                                image77.height = 55

                                //                            headerLbl.color = "#041A2C"
                            }
                            onClicked: spinBox77.increase()
                        }
                    }

                    Rectangle{
                        id: image77
                        //                    Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent
                        Layout.minimumWidth: 300
                        width: 300
                        height: 55
                        Image {
                            anchors.fill: parent
                            source: "pics/beafStake.jpeg"
                            fillMode: Image.PreserveAspectCrop
                        }
                    }

                    SpinBox {
                        id: spinBox77
                        anchors.left: parent.left
                        Layout.alignment: Qt.AlignLeft
                        Layout.minimumWidth: 126
                        //                        Layout.maximumWidth: 126
                        Layout.minimumHeight: 30
                        Layout.maximumHeight: 60
                        //font.bold: true
                        font.pointSize: 17
                        //                        Layout.maximumWidth: 50
                    }
                }

                //BeafEstraganof
                RowLayout{
                    id:lay88
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: window.width/20
                    anchors.leftMargin: window.width/20
                    y:560
                    layoutDirection: Qt.RightToLeft
                    spacing: 0

                    Label {
                        id:lbl88
                        //                    Layout.alignment: Qt.AlignRight
                        anchors.right: parent.right
                        Layout.minimumWidth: 150
                        width: 160
                        //font.bold: true
                        font.family:casablancaFont.name
                        text: qsTr("بیف استراگانوف")
                        font.pointSize: 13
                        onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                image88.z = 2
                                lay88.z = 2
                                lbl88.z = 2
                                image88.width = 400
                                image88.height = 300

                                //                            headerLbl.color = "transparent"
                            }
                            onExited: {
                                image88.z = 0
                                lay88.z = 0
                                lbl88.z = 0
                                image88.width = 300
                                image88.height = 55

                                //                            headerLbl.color = "#041A2C"
                            }
                            onClicked: spinBox88.increase()
                        }
                    }

                    Rectangle{
                        id: image88
                        //                    Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent
                        Layout.minimumWidth: 300
                        width: 300
                        height: 55
                        Image {
                            anchors.fill: parent
                            source: "pics/beafEstraganof.jpg"
                            fillMode: Image.PreserveAspectCrop
                        }
                    }

                    SpinBox {
                        id: spinBox88
                        anchors.left: parent.left
                        Layout.alignment: Qt.AlignLeft
                        Layout.minimumWidth: 126
                        //                        Layout.maximumWidth: 126
                        Layout.minimumHeight: 30
                        Layout.maximumHeight: 60
                        //font.bold: true
                        font.pointSize: 17
                        //                        Layout.maximumWidth: 50
                    }
                }

                //RoastBeaf Berger
                RowLayout{
                    id:lay99
                    anchors.right: parent.right
                    anchors.left: parent.left
                    anchors.rightMargin: window.width/20
                    anchors.leftMargin: window.width/20
                    y:630
                    layoutDirection: Qt.RightToLeft
                    spacing: 0

                    Label {
                        id:lbl99
                        //                    Layout.alignment: Qt.AlignRight
                        anchors.right: parent.right
                        Layout.minimumWidth: 150
                        width: 160
                        //font.bold: true
                        font.family:casablancaFont.name
                        text: qsTr("برگر رست بیف")
                        font.pointSize: 13
                        onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                        MouseArea{
                            anchors.fill: parent
                            hoverEnabled: true
                            onEntered: {
                                image99.z = 2
                                lay99.z = 2
                                lbl99.z = 2
                                image99.width = 400
                                image99.height = 300

                                //                            headerLbl.color = "transparent"
                            }
                            onExited: {
                                image99.z = 0
                                lay99.z = 0
                                lbl99.z = 0
                                image99.width = 300
                                image99.height = 55

                                //                            headerLbl.color = "#041A2C"
                            }
                            onClicked: spinBox99.increase()
                        }
                    }

                    Rectangle{
                        id: image99
                        //                    Layout.alignment: Qt.AlignHCenter
                        anchors.centerIn: parent
                        Layout.minimumWidth: 300
                        width: 300
                        height: 55
                        Image {
                            anchors.fill: parent
                            source: "pics/BergerRoastBeaf.jpg"
                            fillMode: Image.PreserveAspectCrop
                        }
                    }

                    SpinBox {
                        id: spinBox99
                        anchors.left: parent.left
                        Layout.alignment: Qt.AlignLeft
                        Layout.minimumWidth: 126
                        //                        Layout.maximumWidth: 126
                        Layout.minimumHeight: 30
                        Layout.maximumHeight: 60
                        //font.bold: true
                        font.pointSize: 17
                        //                        Layout.maximumWidth: 50
                    }
                }
            }

            Image {
                id: imageBack2
                anchors.fill: parent
                opacity: 0.1
                visible: true
                layer.enabled: false
                source: "pics/IranianRestaurantBackground.jpg"
                fillMode: Image.PreserveAspectCrop
            }
        }

        //منو ایرانی
        Page {
            id:page1
            title: qsTr("منو غذای ایرانی")

            Rectangle{
                z:1
                y:20
                height: 50
                width: parent.width
                color: "transparent"
                Text {
                    text: qsTr("منو غذای ایرانی")
                    font.pointSize: 25
                    font.bold: true
                    anchors.centerIn: parent
                    color: "#041A2C"
                }
            }

            //چلو ماهیچه
            RowLayout{
                id:lay0
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:90
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl0
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    font.bold: true
                    //font.family: "Arial"
                    text: qsTr("چلو ماهیچه")
                    font.pointSize: 19
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image.y = 50
                            image.z = 2
                            lay0.z = 2
                            lbl0.z = 2
                            image.width = 400
                            image.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image.z = 0
                            lay0.z = 0
                            lbl0.z = 0
                            image.width = 300
                            image.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: spinBox.increase()
                    }
                }

                Rectangle{
                    id: image
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/PF1.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox
                    anchors.left: parent.left
                    Layout.alignment: Qt.AlignLeft
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }
            }

            //سبزی پلو با ماهی
            RowLayout{
                id:lay4
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:160
                layoutDirection: Qt.RightToLeft

                Label {
                    id:lbl4
                    Layout.minimumWidth: 150
                    width: 160
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right:parent.right
                    font.pointSize: 19
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"
                    font.bold: true
                    //font.family: "Arial"
                    text: qsTr("سبزی پلو با ماهی")

                    MouseArea{

                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image4.z = 2
                            lay4.z = 2
                            lbl4.z = 2
                            image4.width = 400
                            image4.height = 300
                        }
                        onExited: {
                            image4.z = 0
                            lay4.z = 0
                            lbl4.z = 0
                            image4.width = 300
                            image4.height = 55
                        }
                        onClicked: spinBox4.increase()
                    }
                }

                Rectangle{
                    id: image4
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/PF4.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox4
                    //                    Layout.alignment: Qt.AlignLeft
                    anchors.left: parent.left

                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }

            }

            //چلو کباب کوبیده
            RowLayout{
                id:lay1
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:230
                layoutDirection: Qt.RightToLeft
                spacing: 0

                Label {
                    id:lbl1
                    Layout.alignment: Qt.AlignRight
                    anchors.right: parent.right
                    Layout.minimumWidth: 150
                    width: 160
                    font.pointSize: 19
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"
                    font.bold: true
                    //font.family: "Arial"
                    text: qsTr("چلو کباب کوبیده")

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image1.z = 2
                            lay1.z = 2
                            lbl1.z = 2
                            image1.width = 400
                            image1.height = 300

                            //                            headerLbl.color = "transparent"
                        }
                        onExited: {
                            image1.z = 0
                            lay1.z = 0
                            lbl1.z = 0
                            image1.width = 300
                            image1.height = 55

                            //                            headerLbl.color = "#041A2C"
                        }
                        onClicked: spinBox1.increase()
                    }
                }

                Rectangle{
                    id: image1
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/PF2.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox1
                    Layout.alignment: Qt.AlignLeft
                    anchors.left: parent.left
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }

            }

            //چلو کباب جوجه
            RowLayout{
                id:lay3
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:300
                layoutDirection: Qt.RightToLeft

                Label {
                    id:lbl3
                    Layout.minimumWidth: 150
                    width: 160
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right:parent.right
                    font.pointSize: 19
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"
                    font.bold: true
                    //font.family: "Arial"
                    text: qsTr("چلو کباب جوجه")

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image3.z = 2
                            lay3.z = 2
                            lbl3.z = 2
                            image3.width = 400
                            image3.height = 300
                        }
                        onExited: {
                            image3.z = 0
                            lay3.z = 0
                            lbl3.z = 0
                            image3.width = 300
                            image3.height = 55
                        }
                        onClicked: spinBox3.increase()
                    }
                }

                Rectangle{
                    id: image3
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/jooje2.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox3
                    //                    Layout.alignment: Qt.AlignLeft
                    anchors.left: parent.left

                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }

            }

            //زرشک پلو با مرغ
            RowLayout{
                id:lay2
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:370
                layoutDirection: Qt.RightToLeft

                Label {
                    id:lbl2
                    Layout.minimumWidth: 150
                    width: 160
                    Layout.alignment: Qt.AlignRight
                    anchors.right:parent.right
                    font.pointSize: 19
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"
                    font.bold: true
                    //font.family: "Arial"
                    text: qsTr("زرشک پلو با مرغ")

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: spinBox2.increase()
                        onEntered: {
                            image2.z = 2
                            lay2.z = 2
                            lbl2.z = 2
                            image2.width = 400
                            image2.height = 300
                        }
                        onExited: {
                            image2.z = 0
                            lay2.z = 0
                            lbl2.z = 0
                            image2.width = 300
                            image2.height = 55
                        }
                    }
                }

                Rectangle{
                    id: image2
                    //                     Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/PF3.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox2
                    Layout.alignment: Qt.AlignLeft
                    anchors.left: parent.left
                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }

            }

            //چلو قرمه سبزی
            RowLayout{
                id:lay6
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:440
                layoutDirection: Qt.RightToLeft

                Label {
                    id:lbl6
                    Layout.minimumWidth: 150
                    width: 160
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right:parent.right
                    font.pointSize: 19
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"
                    font.bold: true
                    //font.family: "Arial"
                    text: qsTr("چلو قرمه سبزی")

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: spinBox6.increase()
                        onEntered: {
                            image6.z = 2
                            lay6.z = 2
                            lbl6.z = 2
                            image6.width = 400
                            image6.height = 300
                        }
                        onExited: {
                            image6.z = 0
                            lay6.z = 0
                            lbl6.z = 0
                            image6.width = 300
                            image6.height = 55
                        }
                    }
                }

                Rectangle{
                    id: image6
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/PF6.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox6
                    //                    Layout.alignment: Qt.AlignLeft
                    anchors.left: parent.left

                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }

            }

            //چلو قیمه
            RowLayout{
                id:lay7
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:510
                layoutDirection: Qt.RightToLeft

                Label {
                    id:lbl7
                    Layout.minimumWidth: 150
                    width: 160
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right:parent.right
                    font.pointSize: 19
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"
                    font.bold: true
                    //font.family: "Arial"
                    text: qsTr("چلو قیمه")

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: spinBox7.increase()
                        onEntered: {
                            image7.z = 2
                            lay7.z = 2
                            lbl7.z = 2
                            image7.width = 400
                            image7.height = 250
                        }
                        onExited: {
                            image7.z = 0
                            lay7.z = 0
                            lbl7.z = 0
                            image7.width = 300
                            image7.height = 55
                        }
                    }
                }

                Rectangle{
                    id: image7
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/PF7.png"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox7
                    //                    Layout.alignment: Qt.AlignLeft
                    anchors.left: parent.left

                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }

            }

            //دیزی سنتی
            RowLayout{
                id:lay5
                anchors.right: parent.right
                anchors.left: parent.left
                anchors.rightMargin: window.width/20
                anchors.leftMargin: window.width/20
                y:580
                layoutDirection: Qt.RightToLeft

                Label {
                    id:lbl5
                    Layout.minimumWidth: 150
                    width: 160
                    //                    Layout.alignment: Qt.AlignRight
                    anchors.right:parent.right
                    font.pointSize: 19
                    onZChanged: z == 2 ? color = "#EA4A4A" : color = "black"
                    font.bold: true
                    //font.family: "Arial"
                    text: qsTr("دیزی سنتی")

                    MouseArea{
                        anchors.fill: parent
                        hoverEnabled: true
                        onEntered: {
                            image5.z = 2
                            lay5.z = 2
                            lbl5.z = 2
                            image5.width = 400
                            image5.height = 300
                        }
                        onExited: {
                            image5.z = 0
                            lay5.z = 0
                            lbl5.z = 0
                            image5.width = 300
                            image5.height = 55
                        }
                        onClicked: spinBox5.increase()
                    }
                }

                Rectangle{
                    id: image5
                    //                    Layout.alignment: Qt.AlignHCenter
                    anchors.centerIn: parent
                    Layout.minimumWidth: 300
                    width: 300
                    height: 55
                    Image {
                        anchors.fill: parent
                        source: "pics/PF5.jpg"
                        fillMode: Image.PreserveAspectCrop
                    }
                }

                SpinBox {
                    id: spinBox5
                    //                    Layout.alignment: Qt.AlignLeft
                    anchors.left: parent.left

                    Layout.minimumWidth: 126
                    //                        Layout.maximumWidth: 126
                    Layout.minimumHeight: 30
                    Layout.maximumHeight: 60
                    font.bold: true
                    font.pointSize: 17
                    //                        Layout.maximumWidth: 50
                }

            }

            Image {
                id: image8
                anchors.fill: parent
                opacity: 0.1
                visible: true
                layer.enabled: false
                source: "pics/IranianRestaurantBackground.jpg"
                fillMode: Image.PreserveAspectCrop
            }
        }
    }
}
