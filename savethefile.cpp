#include "savethefile.h"

saveTheFile::saveTheFile()
{
    char szBuf[128];
    memset(szBuf, 0x00, sizeof (szBuf));
    getcwd(szBuf, sizeof(szBuf) - 1);
    QString S(szBuf);
    Path = S + "/file/";
    QDir dir(Path);
    if (!dir.exists()){
        dir.mkdir(Path);
    }
}

bool saveTheFile::getInputText(QString Today, QString title, QString content)
{
    if (title == "" && content == "")
    {
        return false;
    } else {
        QString fileName = Today;
        QFile file(Path + fileName + ".txt");
        if (!file.open(QIODevice::WriteOnly))
        {
            qDebug() << "write error";
            return false;
        }
        QByteArray writeTitle = title.toLatin1();
        QByteArray writeContent = content.toLatin1();
        file.write(writeTitle);
        file.write("\n");
        file.write(writeContent);
        file.close();
        return true;
    }
}

bool saveTheFile::getFileName(QString year, QString month, QString date)
{
    QString signDay = year + "-" + month + "-" + date;
    QDir qd(Path);
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
    QDir pd(Path);
    QFileInfoList subFileList = pd.entryInfoList(QDir::Files | QDir::CaseSensitive);
    return subFileList.size();
}

QString saveTheFile::outPutFileContent(QString year, QString month, QString date)
{
    QString fileName = year + "-" + month + "-" + date;
    QFile file(Path + fileName + ".txt");
    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    {
        qDebug() << "File can not open";
        exit(100);
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
}

bool saveTheFile::deleteFile(QString choseDay)
{
    QString FileName  = choseDay;

    if (QFile::remove(Path + FileName + ".txt"))
    {
        return true;
    } else {
        qDebug() << "delete file error";
        return false;
    }
}







