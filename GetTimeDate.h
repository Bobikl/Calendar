#ifndef GETTIMEDATE_H
#define GETTIMEDATE_H
#include <iostream>
#include <QObject>
#include <string>
#include <QDebug>
using namespace std;

class GetTimeDate : public QObject
{
    Q_OBJECT
public:
    GetTimeDate();
    Q_INVOKABLE QString getTimeDateRet(QString x);
};

#endif // GETTIMEDATE_H
