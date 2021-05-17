#include "savethefile.h"

saveTheFile::saveTheFile()
{

}

void saveTheFile::getInputText(QString Today, QString title, QString content)
{
    QString fileName = Today;
    QFile file("/home/lbw/Desktop/Qt/build-Calendar-Desktop-Debug/file/" + fileName);
    if (!file.open(QIODevice::WriteOnly))
        qDebug() << "error";
    QByteArray writeTitle = title.toLatin1();
    QByteArray writeContent = content.toLatin1();
    file.write(writeTitle);
    file.write("\n");
    file.write(writeContent);
    file.close();
}
