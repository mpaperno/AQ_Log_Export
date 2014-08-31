#-------------------------------------------------
#
# Project created by QtCreator 2013-05-19T17:47:38
#
#-------------------------------------------------

QT       += core gui

greaterThan(QT_MAJOR_VERSION, 4): QT += widgets

TARGET = AQ_Log_Export
TEMPLATE = app
BASEDIR = $${_PRO_FILE_PWD_}
TARGETDIR = $${OUT_PWD}
BUILDDIR = $${OUT_PWD}/build

OBJECTS_DIR = $${BUILDDIR}/obj
MOC_DIR = $${BUILDDIR}/moc
UI_DIR = $${BUILDDIR}/ui
RCC_DIR = $${BUILDDIR}/rcc


SOURCES += main.cc\
        aqlogexporter.cc

HEADERS  += aqlogexporter.h \
    config.h

FORMS    += aqlogexporter.ui

RESOURCES += resources.qrc


# Windows (32bit)
win32-msvc2008|win32-msvc2010 {

	RC_FILE = icon.rc

	# Copy dependencies
	BASEDIR = $$replace(BASEDIR, "/", "\\")
	greaterThan(QT_MAJOR_VERSION, 4) {
		QTLIBDLLPFX = "Qt5"
		QTLIBDLLSFX = ".dll"
	} else {
		QTLIBDLLPFX = "Qt"
		QTLIBDLLSFX = "4.dll"
	}
	CONFIG(release, debug|release) {
		TARGETDIR = $$replace(TARGETDIR,"/","\\")\\release
	}
	CONFIG(debug, debug|release) {
	  TARGETDIR = $$replace(TARGETDIR, "/", "\\")\\debug
	  greaterThan(QT_MAJOR_VERSION, 4) {
			QTLIBDLLSFX = "d.dll"
	  } else {
			QTLIBDLLSFX = "d4.dll"
	  }
	}

	# Copy AQ files
	QMAKE_POST_LINK += $$quote(xcopy /D /Y "$${BASEDIR}\\bin\\aq_win_all\\*" "$${TARGETDIR}\\aq\\bin" /E /I $$escape_expand(\\n))
	# Qt library DLLs
	QMAKE_POST_LINK += $$quote(xcopy /D /Y "$$(QTDIR)\\bin\\$${QTLIBDLLPFX}Core$${QTLIBDLLSFX}" "$$TARGETDIR"$$escape_expand(\\n))
	QMAKE_POST_LINK += $$quote(xcopy /D /Y "$$(QTDIR)\\bin\\$${QTLIBDLLPFX}Gui$${QTLIBDLLSFX}" "$$TARGETDIR"$$escape_expand(\\n))

	CONFIG(release, debug|release) {
		# Copy Visual Studio DLLs
		win32-msvc2010 {
			 QMAKE_POST_LINK += $$quote(xcopy /D /Y "\"C:\\Program Files \(x86\)\\Microsoft Visual Studio 10.0\\VC\\redist\\x86\\Microsoft.VC100.CRT\\*.dll\""  "$${TARGETDIR}\\"$$escape_expand(\\n))
		}
	}
}

# MAC OS X
macx|macx-g++42|macx-g++|macx-llvm: {

	ICON = resources/app_icon.icns

	# Copy AQ files
	QMAKE_POST_LINK += && mkdir -p $${BASEDIR}/$${TARGET}.app/Contents/MacOS/aq/bin
	QMAKE_POST_LINK += && cp -rf $${BASEDIR}/bin/aq_osx_all/* $${TARGETDIR}/$${TARGET}.app/Contents/MacOS/aq/bin
	QMAKE_POST_LINK += && chmod +x $${BASEDIR}/$${TARGET}.app/Contents/MacOS/aq/bin/*

}

# GNU/Linux
linux-g++|linux-g++-64{

	debug {
		TARGETDIR = $${TARGETDIR}/debug
	}
	release {
		TARGETDIR = $${TARGETDIR}/release
	}
	# Validated copy commands
	!exists($$TARGETDIR) {
		QMAKE_POST_LINK += && mkdir -p $${TARGETDIR}
	}

	DESTDIR = $$TARGETDIR

	# Copy AQ files
	QMAKE_POST_LINK += && mkdir -p $${TARGETDIR}/aq/bin
	QMAKE_POST_LINK += && cp -rf $${BASEDIR}/bin/aq_unix_all/* $${TARGETDIR}/aq/bin
	QMAKE_POST_LINK += && chmod +x $${TARGETDIR}/aq/bin/*
}
