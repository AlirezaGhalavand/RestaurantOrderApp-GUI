#include "myprint.h"
#include <QtPrintSupport/QPrinter>
#include <QPainter>
#include <QtPrintSupport/QPrintDialog>
#include <QPixmap>
#include <QImage>
#include <QDebug>

MYPrint::MYPrint()
{

}

void MYPrint::print(QVariant data)
{
    QImage img = qvariant_cast<QImage>(data);
    QPrinter printer;
          QPrintDialog *dlg = new QPrintDialog(&printer,0);
          if(dlg->exec() == QDialog::Accepted) {
                  QPainter painter(&printer);
                  painter.drawImage(QPoint(0,0),img);
                  painter.end();
          }
}
