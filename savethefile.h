#ifndef SAVETHEFILE_H
#define SAVETHEFILE_H
#include <QObject>
#include <QFile>
#include <QDebug>
using namespace std;

class saveTheFile : public QObject
{
    Q_OBJECT
public:
    saveTheFile();
    Q_INVOKABLE void getInputText(QString Today, QString title, QString content);
};

#endif // SAVETHEFILE_H
