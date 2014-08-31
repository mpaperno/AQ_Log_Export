#include "config.h"
#include "aqlogexporter.h"
#include <QApplication>
#include <QSettings>
#include <QFileInfo>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);

	 // Set application name
	 a.setApplicationName(APP_NAME);
	 a.setApplicationVersion(APP_VERSION_TXT);
	 a.setOrganizationName(APP_ORG);
	 a.setOrganizationDomain(APP_DOMAIN);

	 // Set settings format
	 QSettings::setDefaultFormat(QSettings::IniFormat);

    AQLogExporter w;
    w.show();

	 QString fileArg = a.arguments().last();
	 if (a.arguments().at(0) != fileArg && fileArg.length() && QFileInfo(fileArg).exists())
		 w.setLogFile(fileArg);
    
    return a.exec();
}
