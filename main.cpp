#include <QApplication>
#include <QQmlApplicationEngine>
#include <QFontDatabase>
#include <QQmlContext>
#include "myprint.h"
//#include <QtMultimedia/QMediaPlayer>


void InstallDefaultFont()
{
    qint32 fontId = QFontDatabase::addApplicationFont(":/fonts/IranNastaliq.ttf");
    QStringList fontList = QFontDatabase::applicationFontFamilies(fontId);

    QString family = fontList.at(0);
    auto font = QFont(family);
    font.setStyleHint(QFont::Monospace);
    QGuiApplication::setFont(font);
}

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QApplication app(argc, argv);
    app.setApplicationName("KhorshidRestaurant-CustomerOrder");
    app.setApplicationVersion("1.0");
    app.setApplicationDisplayName("KhorshidRestaurant-CustomerOrder");
    app.setDesktopFileName("KhorshidRestaurant");


//    QMediaPlayer *player = new QMediaPlayer;
//    player->setMedia(QUrl::fromLocalFile("/musics/Eftekhari-CheshmBeRaah.mp3"));
//    player->setVolume(50);
//    player->play();

    InstallDefaultFont();/*
    QFont font("Courier New");
    font.setStyleHint(QFont::Monospace);
    QApplication::setFont(font);*/

    QQmlApplicationEngine engine;

    MYPrint  print;
    engine.rootContext()->setContextProperty("PRINT", &print);

    const QUrl url(QStringLiteral("qrc:/SplashScreen.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
