#include "sqllite.h"

sqlLite::sqlLite()
{

}

void sqlLite::conectionSql()
{
    database = QSqlDatabase::addDatabase("QSQLITE");
    database.setDatabaseName("myDatabase.db");
    if (!database.open())
    {
        qDebug() << "Error: Faild to content database " << database.lastError();
    } else {
        qDebug() << "Succed to content database ";
    }

    QSqlQuery sql_query;
    QString createTable = QString("create table %1(year int, month int, date int, title text, content text)").arg(calendarTable);
    if (!tableIsExits(sql_query, calendarTable))
    {
        if (!sql_query.exec(createTable))
        {
            qDebug() << "Error: Fail to create table " << sql_query.lastError();
        } else {
            qDebug() << "Table create!";
        }
    }

    sql_query.clear();
}

bool sqlLite::insertTable(int y, int m, int d, QString title, QString content)
{
    QSqlQuery sql_query;
    if (findTable(y, m, d))
    {
        //删除重新插入
        deleteTable(y, m, d);
    }
    if (!sql_query.exec(QString("INSERT INTO '%1' VALUES('%2', '%3', '%4', \"%5\", \"%6\")").arg(calendarTable).arg(y).arg(m).arg(d).arg(title).arg(content)))
    {
        qDebug() << sql_query.lastError();
        return false;
    }
    else
    {
        qDebug() << "insert succed";
        return true;
    }
    sql_query.clear();
    return true;
}

bool sqlLite::tableIsExits(QSqlQuery &query, QString tableName)
{
    QString sql = QString("select * from sqlite_master where name='%1'").arg(tableName);
    query.exec(sql);
    return query.next();
}

bool sqlLite::findTable(int y, int m, int d)
{
    QSqlQuery sql_query;
    sql_query.exec(QString("select * from %1").arg(calendarTable));
    if(!sql_query.exec())
    {
        qDebug()<<sql_query.lastError();
        return false;
    }
    else
    {
        while(sql_query.next())
        {
            int Y = sql_query.value(0).toInt();
            int M = sql_query.value(1).toInt();
            int D = sql_query.value(2).toInt();
            if (Y == y && M == m && D == d)
            {
                return true;
                break;
            }
        }
    }
    sql_query.clear();
    return false;
}

bool sqlLite::deleteTable(int y, int m, int d)
{
    QSqlQuery sql_query;
    if (!sql_query.exec(QString("DELETE FROM %1 WHERE year='%2' and month='%3' and date='%4'").arg(calendarTable).arg(y).arg(m).arg(d)))
    {
        qDebug() << "delete Error";
        return false;
    }
    else
    {
        qDebug() << "delete succed";
        return true;
    }
    sql_query.clear();
    return false;
}

QString sqlLite::outPutTitleContent(int y, int m, int d)
{
    QString title;
    QString content;
    QSqlQuery sql_query;
    sql_query.exec(QString("select * from %1").arg(calendarTable));
    if(!sql_query.exec())
    {
        qDebug()<<sql_query.lastError();
    }
    else
    {
        while(sql_query.next())
        {
            int Y = sql_query.value(0).toInt();
            int M = sql_query.value(1).toInt();
            int D = sql_query.value(2).toInt();
            if (Y == y && M == m && D == d)
            {
                title = sql_query.value(3).toString();
                content = sql_query.value(4).toString();
                break;
            }
        }
    }
    sql_query.clear();
    return title + "-" + content;
}

int sqlLite::getSqlSize()
{
    QSqlQuery sql_query;
    QString y;
    QStringList sqlListSign;
    sql_query.exec(QString("select * from %1").arg(calendarTable));
    if(!sql_query.exec())
    {
        qDebug()<<sql_query.lastError();
    }
    else
    {
        while(sql_query.next())
        {
            y = sql_query.value(0).toString();
            sqlListSign << y;
        }
    }
    sql_query.clear();
    size = sqlListSign.size();
    return size;
}

QString sqlLite::slideInsert(int i)
{
    QSqlQuery sql_query;
    QString y;
    QString m;
    QString d;
    QString title;
    QString content;
    QStringList sqlListSign;
    sql_query.exec(QString("select * from %1").arg(calendarTable));
    if(!sql_query.exec())
    {
        qDebug()<<sql_query.lastError();
    }
    else
    {
        while(sql_query.next())
        {
            y = sql_query.value(0).toString();
            m = sql_query.value(1).toString();
            d = sql_query.value(2).toString();
            title = sql_query.value(3).toString();
            content = sql_query.value(4).toString();
            sqlListSign << y + "-" + m + "-" + d + "-" + title + "-" + content;
        }
    }
    sql_query.clear();
    return sqlListSign[i];
}

sqlLite::~sqlLite()
{

}
