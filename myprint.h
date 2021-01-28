#ifndef MYPRINT_H
#define MYPRINT_H

#include <QObject>
#include <QVariant>


class MYPrint :public QObject
{
    Q_OBJECT

public:
    MYPrint();
    Q_INVOKABLE void print(QVariant data);

};

#endif // MYPRINT_H
