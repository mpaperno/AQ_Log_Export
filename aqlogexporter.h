#ifndef AQLOGEXPORTER_H
#define AQLOGEXPORTER_H

#include <QMainWindow>
#include <QProcess>
#include <QSettings>

class QTranslator;

typedef QHash<QString, QTranslator*> Translators;

namespace Ui {
class AQLogExporter;
}

class AQLogExporter : public QMainWindow
{
    Q_OBJECT
    
public:
    explicit AQLogExporter(QWidget *parent = 0);
    ~AQLogExporter();

	void setLogFile(QString &logFile);

protected:
	enum statusMsgTypes { MSG_PLAIN, MSG_INFO, MSG_SUCCESS, MSG_WARNING, MSG_ERROR};


private:
	void newLogFile();
	void newOutputFile();
	void toggleGPSTrackOpts(bool enable);
	void setExportTypeOptions(QString typ);
	void writeMsgToStatusWindow(QString msg, statusMsgTypes typ = MSG_INFO);
	void scrollStatusWindow();
	void readSettings();
	void writeSettings();

	void loadTranslations();

signals:
	void formValidRecheck();

protected slots:
	void changeEvent(QEvent *e);

private slots:
	void setLanguage(const QString &locale);
	void createLanguageMenu(void);
	void languageChanged(QAction* action);
	void loadLanguage(const QString& lang);

	void extProcessExit(int exitcode);
	void extProcessStdErr();
	void extProcessError(QProcess::ProcessError err);
	bool validateForm(bool showAlert = false);
	void autoExportFileName();
	void startExport();

	void on_lineEdit_inputFile_editingFinished();
	void on_lineEdit_outputFile_editingFinished();
	void on_checkBox_triggerUseGmblTrigger_toggled(bool checked);
	void on_spinBox_triggerChannel_valueChanged(int arg1);
	void on_comboBox_exportFormat_activated(const QString &arg1);
	void on_checkBox_gpsTrack_toggled(bool checked);
	void on_checkBox_gpsWaypoints_toggled(bool checked);
	void on_checkBox_allValues_clicked();
	void on_pushButton_doExport_clicked();
	void on_toolButton_selectLogFile_clicked();
	void on_toolButton_selectOutputFile_clicked();
	void on_toolButton_openOutput_clicked();
	void on_toolButton_browseOutput_clicked();
	void on_toolButton_autoExportFile_clicked();

private:
	QString langPath;
	QTranslator* currentTranslator;
	Translators translators;
	QString defaultLanguage;     /**< contains the default language */
	QString currentLanguage;     /**< contains the currently loaded language */


	Ui::AQLogExporter *ui;
	QSettings settings;
	QProcess ps_export;
	QString savedOutputPath;
	QString savedLogfilePath;
	QString lastOutfilePath;
	QStringList flatExpTypes;
	QStringList xmlExpTypes;
	QStringList allExpTypes;
	bool outFileWasSelectedViaBrowse;

};

#endif // AQLOGEXPORTER_H
