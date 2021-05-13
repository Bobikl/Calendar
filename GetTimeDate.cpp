#include "GetTimeDate.h"

GetTimeDate::GetTimeDate()
{

}


QString GetTimeDate::getTimeDateRet(QString x)
{
    QString qstr = x;
    string cstr;
    QString Rqstr;
    cstr = qstr.toStdString();
//    cstr = string((const char *)qstr.toLocal8Bit());
    string qdebug;
//    string strLenS = to_string(strLen);

//    for (int i = 23; i < 28; i ++)
//    {
//        qDebug() << cstr[i];
//    }
//    qDebug() << cstr[7];
    qDebug() << cstr[23];
    qDebug() << cstr[24];

    string sYear = to_string(cstr[23]) + to_string(cstr[24]) + to_string(cstr[25]) + to_string(cstr[26]);

    Rqstr = QString::fromStdString(sYear);
//    return Rqstr;

}
