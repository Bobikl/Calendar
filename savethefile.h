#ifndef SAVETHEFILE_H
#define SAVETHEFILE_H
#include <QObject>
#include <QDebug>
#include <QDir>
#include <unistd.h>
#include <string.h>
#define PATH "/home/lbw/Desktop/Qt/build-Calendar-Desktop-Debug/file/"
using namespace std;

class saveTheFile : public QObject
{
    Q_OBJECT
public:
    saveTheFile();
    int addNumber = 0;
    QString Path;
    Q_INVOKABLE bool getInputText(QString Today, QString title, QString content);
    Q_INVOKABLE bool getFileName(QString year, QString month, QString date);
    Q_INVOKABLE int getFileNameNumber();
    Q_INVOKABLE QString outPutFileContent(QString year, QString month, QString date);
    Q_INVOKABLE void deleteFile(QString choseDay);
};

#endif // SAVETHEFILE_H
