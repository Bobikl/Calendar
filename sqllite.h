#ifndef SQLLITE_H
#define SQLLITE_H
#include <QtSql/QSqlDatabase>
#include <QtSql/QSqlError>
#include <QtSql/QSqlQuery>
#include <QObject>
#include <QDebug>
class sqlLite : public QObject
{
    Q_OBJECT
public:
    sqlLite();
    QSqlDatabase database;
    QString calendarTable = "calendarSign";
    int number = 0;
    int size = 0;
    Q_INVOKABLE QStringList sqlListTest;
    Q_INVOKABLE void conectionSql();
    Q_INVOKABLE bool insertTable(int y, int m, int d, QString title, QString content);
    Q_INVOKABLE bool tableIsExits(QSqlQuery &query, QString tableName);
    Q_INVOKABLE bool findTable(int y, int m, int d);
    Q_INVOKABLE bool deleteTable(int y, int m, int d);
    Q_INVOKABLE void forEachTable();
    Q_INVOKABLE QString outPutTitleContent(int y, int m, int d);
    Q_INVOKABLE int getSqlSize();
    Q_INVOKABLE QString slideInsert(int i);
};

#endif // SQLLITE_H
