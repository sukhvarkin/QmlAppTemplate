#include "SettingsManager.h"

#include <utils_app.h>
#include <utils_screen.h>
#include <utils_sysinfo.h>
#include <utils_language.h>

#include <SingleApplication>

#include <QtGlobal>
#include <QLibraryInfo>
#include <QVersionNumber>

#include <QQmlApplicationEngine>
#include <QQmlContext>
#include <QQuickWindow>
#include <QQuickStyle>
#include <QSurfaceFormat>

/* ************************************************************************** */

int main(int argc, char *argv[])
{

#if defined(Q_OS_LINUX) && !defined(Q_OS_ANDROID)
    // NVIDIA driver suspend&resume hack
    auto format = QSurfaceFormat::defaultFormat();
    format.setOption(QSurfaceFormat::ResetNotification);
    QSurfaceFormat::setDefaultFormat(format);
#endif

    SingleApplication app(argc, argv, false);

    // Application name
    app.setApplicationName("Bravo");
    app.setApplicationDisplayName("Bravo");
    app.setOrganizationName("IPG");
    app.setOrganizationDomain("IPG");

    QIcon appIcon(":/assets/logos/logo.svg");
    app.setWindowIcon(appIcon);

    // Init app components
    auto sm = SettingsManager::getInstance();
    if (!sm)
    {
        qWarning() << "Cannot init app components!";
        return EXIT_FAILURE;
    }

    // Init generic utils
    auto utilsApp = UtilsApp::getInstance();
    auto utilsScreen = UtilsScreen::getInstance();
    auto utilsSysinfo = UtilsSysInfo::getInstance();
    auto utilsLanguage = UtilsLanguage::getInstance();

    if (!utilsScreen || !utilsApp || !utilsLanguage)
    {
        qWarning() << "Cannot init generic utils!";
        return EXIT_FAILURE;
    }

    // Translate the application
    utilsLanguage->loadLanguage(sm->getAppLanguage());

    // ThemeEngine
    qmlRegisterSingletonType(QUrl("qrc:/qml/ThemeEngine.qml"), "ThemeEngine", 1, 0, "Theme");


    // Then we start the UI
    QQmlApplicationEngine engine;
    QQmlContext *engine_context = engine.rootContext();

    engine_context->setContextProperty("settingsManager", sm);
    engine_context->setContextProperty("utilsApp", utilsApp);
    engine_context->setContextProperty("utilsLanguage", utilsLanguage);
    engine_context->setContextProperty("utilsScreen", utilsScreen);
    engine_context->setContextProperty("utilsSysinfo", utilsSysinfo);

    engine.load(QUrl(QStringLiteral("qrc:/qml/DesktopApplication.qml")));

    if (engine.rootObjects().isEmpty())
    {
        qWarning() << "Cannot init QmlApplicationEngine!";
        return EXIT_FAILURE;
    }

    // For i18n retranslate
    utilsLanguage->setQmlEngine(&engine);

    auto window = qobject_cast<QQuickWindow *>(engine.rootObjects().value(0));
    if (!window) {
        return EXIT_FAILURE;
    }

    utilsApp->setQuickWindow(window);

    QObject::connect(&app, &SingleApplication::instanceStarted, window, &QQuickWindow::show);
    QObject::connect(&app, &SingleApplication::instanceStarted, window, &QQuickWindow::raise);


    return app.exec();

}

/* ************************************************************************** */
