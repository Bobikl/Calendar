#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <savethefile.h>
#include <sqllite.h>

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif

    qmlRegisterType<saveTheFile>("CalendarSave", 1, 0, "SaveTheFile");
    qmlRegisterType<sqlLite>("InsertSql", 1, 0, "SqlLite");
    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;
//    app.setOrganizationName("Calendar");
//    app.setOrganizationDomain("Calendar.com");
//    app.setApplicationName("Awesome Calendar");
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
