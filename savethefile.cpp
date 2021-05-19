#include "savethefile.h"

saveTheFile::saveTheFile()
{

}

void saveTheFile::getInputText(QString Today, QString title, QString content)
{
    if (title == "" && content == "")
    {
        return;
    } else {
        QString fileName = Today;
        QFile file(PATH + fileName + ".txt");
        if (!file.open(QIODevice::WriteOnly))
        {
            qDebug() << "write error";
            return;
        }
        QByteArray writeTitle = title.toLatin1();
        QByteArray writeContent = content.toLatin1();
        file.write(writeTitle);
        file.write("\n");
        file.write(writeContent);
        file.close();
    }

}

bool saveTheFile::getFileName(QString year, QString month, QString date)
{
    QString signDay = year + "-" + month + "-" + date;
    QDir qd(PATH);
    QFileInfoList subFileList = qd.entryInfoList(QDir::Files | QDir::CaseSensitive);
    for (int i = 0; i < subFileList.size(); i++)
    {
        QString suffix = subFileList[i].suffix();
        if (suffix.compare("txt") == 0)
        {
            if (qPrintable(subFileList[i].baseName()) == signDay)
            {
                return true;
            }
        }
    }
    return false;
}

int saveTheFile::getFileNameNumber()
{
    QDir pd(PATH);
    QFileInfoList subFileList = pd.entryInfoList(QDir::Files | QDir::CaseSensitive);
    return subFileList.size();
}

QString saveTheFile::outPutFileContent(QString year, QString month, QString date)
{
    QString fileName = year + "-" + month + "-" + date;
    QFile file(PATH + fileName + ".txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug() << "File can not open";
        return 0;
    }
    QString firstTitle;
    QString secondContent;
    QTextStream in(&file);
    while(!in.atEnd()){
        QString line = in.readAll();
        firstTitle = line.section("\n", 0, 0);
        secondContent = line.section("\n", 1, 1);
    }
    if (addNumber == 0){
        addNumber = 1;
        return firstTitle;
    } else if (addNumber == 1){
        addNumber = 0;
        return secondContent;
    }
    file.close();
}

void saveTheFile::deleteFile(QString choseDay)
{
    QString FileName  = choseDay;
//    QString FileName = "2021-5-1";

    if (QFile::remove(PATH + FileName + ".txt"))
    {
        qDebug() << "delete file secces";
    } else {
        qDebug() << "delete file error";
        qDebug() << choseDay;
    }
}







