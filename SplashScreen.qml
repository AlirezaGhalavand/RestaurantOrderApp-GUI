import QtQuick 2.14
import QtQuick.Controls 2.14
import QtQuick.Window 2.14
import QtQuick.Layouts 1.14
import QtGraphicalEffects 1.0
import QtMultimedia 5.14

ApplicationWindow {

    id: splashWindow
    visible: true
    width: 900
    minimumWidth: 900
    maximumWidth: 1200

    height: 800
    minimumHeight: 800
    maximumHeight: 800

    flags: Qt.Window | Qt.FramelessWindowHint

    property int slderIndex: 0

    Component.onCompleted: {

        playMusic.play();

        slider.model.append({image:"splashPics/01.jpg"})
        slider.model.append({image:"splashPics/02.jpg"})
        slider.model.append({image:"splashPics/03.jpg"})
        slider.model.append({image:"splashPics/04.jpg"})
        slider.model.append({image:"splashPics/13.jpg"})
        slider.model.append({image:"splashPics/06.jpg"})
        slider.model.append({image:"splashPics/07.jpg"})
        slider.model.append({image:"splashPics/08.jpg"})
        slider.model.append({image:"splashPics/09.jpg"})
        slider.model.append({image:"splashPics/10.jpg"})
        slider.model.append({image:"splashPics/11.jpg"})
        slider.model.append({image:"splashPics/12.jpg"})
        slider.model.append({image:"splashPics/13.jpg"})
        slider.model.append({image:"splashPics/14.jpg"})

        timer.start()
        pauseAnimation.running = true
    }

    Audio {
           id: playMusic
           source: "/musics/music1.mp3"
           loops:Audio.Infinite
           volume: 0.5
       }

    Text {
        id: loadingBigTite
        anchors.centerIn: parent
        text: qsTr("به رستوران خورشید خوش آمدید")
        font.pointSize:60
//        font.bold: true
        color: "white"
        z:2
        layer.enabled: true
        layer.effect: DropShadow {
//            verticalOffset: 4
//            color: "black"//"#80000000"
//            radius: 1
//            samples: 3

            horizontalOffset: 4
            radius: 4
            samples: 3
            color: "black"//"#000000"
            verticalOffset: 2
            spread: 0

        }
    }

    SwipeView{
        id:slider
        anchors.top: parent.top
        //        anchors.topMargin:verticalMargin
        height: parent.height
        width: parent.width
        x:(parent.width-width)/2//make item horizontally center
        property var model :ListModel{}
        clip:true
        Repeater {
            model:slider.model
            Image{
                width: slider.width
                height: slider.height
                source: image
                fillMode: Image.Stretch
            }
        }
    }

    Text {
        id: loadingTite
        anchors.bottom: control.top
        anchors.left: control.left
        anchors.right: control.right
        text: qsTr("لطفا منتظر بمانید...")
        color: "white"
        font.pointSize:20
        layer.enabled: true
        layer.effect: DropShadow {
            horizontalOffset: 4
            radius: 4
            samples: 3
            color: "black"//"#000000"
            verticalOffset: 2
            spread: 0
        }
    }

    BusyIndicator{
        id:control
        x: (parent.width-width)/2
        y: parent.height - 100
        z:2
        //        Component.onCompleted: {
        //                            contentItem.pen = "transparent"
        //                            contentItem.fill = "red"
        //                        }

        width: 100
        height: 100

        running: true

        contentItem: Item {
            implicitWidth: 64
            implicitHeight: 64

            Item {
                id: busyItem
                x: parent.width / 2 - 32
                y: parent.height / 2 - 32
                width: 64
                height: 64
                opacity: control.running ? 1 : 0

                Behavior on opacity {
                    OpacityAnimator {
                        duration: 250
                    }
                }

                RotationAnimator {
                    target: busyItem
                    running: control.visible && control.running
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
        id:timer
        repeat: true
        interval: 1000
        onTriggered: {

            if(slderIndex == slider.count)
                slderIndex = 0;

            slider.currentIndex = slderIndex;

            slderIndex = slderIndex + 1;
        }

    }

    Loader{
        id:loaderMain
        anchors.fill: parent
        active: false
        //    visible: false
        asynchronous: true

    }

    Connections{
        target: loaderMain.item
        onClose: {
            imgEnd.visible = true
            timerClose.start()
        }
    }

    Timer{
        id:timerClose
        repeat: false
        interval: 3000
        onTriggered: splashWindow.close()
    }

    Image {
        id: imgEnd
        z:2
        anchors.fill: parent
        visible: false
        source: "splashPics/09.jpg"
        fillMode: Image.PreserveAspectCrop

        Text {
            id: name
            x:(parent.width-width)/2
            y:150
            text: qsTr("با تشکر از حسن انتخاب شما")
            font.pointSize: 40
//            font.bold: true
            color: "#081300"
            layer.enabled: true
            layer.effect: DropShadow {
                horizontalOffset: 4
                radius: 4
                samples: 3
                color: "white"//"#000000"
                verticalOffset: 2
                spread: 0
            }
        }
    }

    PauseAnimation {
        id:pauseAnimation
        duration: 8000
        running: false
        onRunningChanged: {
            if(running == false)
            {
                loaderMain.source = "main.qml"
                loaderMain.active = true
                //                slider.visible = false
                timer.stop()
                control.running = false
                loadingBigTite.visible = false
                loadingBigTite_english.visible = false
                loadingTite.visible = false
            }
        }
    }
}
