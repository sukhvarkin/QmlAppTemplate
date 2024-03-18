cmake_minimum_required(VERSION 3.20)

project(bravo-qml VERSION 0.1 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_AUTOMOC ON)
set(CMAKE_AUTORCC ON)

string(TIMESTAMP CURRENT_TIMESTAMP "%s" UTC)
set(APP_NAME ${CMAKE_PROJECT_NAME})
set(APP_VERSION ${CMAKE_PROJECT_VERSION})
set(APP_VERSION_CODE ${TIMESTAMP})

include(i18n/module.cmake)

################################################################################

message(STATUS "[CMAKE] CMAKE_VERSION               = ${CMAKE_VERSION}")
message(STATUS "[CMAKE] CMAKE_PREFIX_PATH           = ${CMAKE_PREFIX_PATH}")
message(STATUS "[SYSTEM] (HOST) SYSTEM NAME         = ${CMAKE_HOST_SYSTEM_NAME}")
message(STATUS "[SYSTEM] (HOST) SYSTEM VERSION      = ${CMAKE_HOST_SYSTEM_VERSION}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM NAME       = ${CMAKE_SYSTEM_NAME}")
message(STATUS "[SYSTEM] (TARGET) SYSTEM VERSION    = ${CMAKE_SYSTEM_VERSION}")
message(STATUS "[PROJECT] SOURCE_DIR                = ${CMAKE_CURRENT_SOURCE_DIR}")
message(STATUS "[PROJECT] BUILD_TYPE                = ${CMAKE_BUILD_TYPE}")
message(STATUS "[PROJECT] TOOLCHAIN_FILE            = ${CMAKE_TOOLCHAIN_FILE}")
message(STATUS "[PROJECT] QT_HOST_PATH              = ${QT_HOST_PATH}")

################################################################################

find_package(Qt5 REQUIRED COMPONENTS Core Gui Qml Quick QuickControls2 Svg)

add_executable(${CMAKE_PROJECT_NAME}
    src/SettingsManager.cpp src/SettingsManager.h
    src/main.cpp
    qml/qml.qrc
    qml/components.qrc
    assets/assets.qrc
    ${TRANSLATINS_QRC_FILE}
)

target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC src/thirdparty/)

# AppUtils
add_subdirectory(src/thirdparty/AppUtils)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE AppUtils)

# SingleApplication
set(QAPPLICATION_CLASS QGuiApplication)
add_subdirectory(src/thirdparty/SingleApplication)
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE SingleApplication)

# Qt
target_link_libraries(${CMAKE_PROJECT_NAME} PRIVATE
    Qt5::Core
    Qt5::Gui
    Qt5::Qml
    Qt5::Quick
    Qt5::QuickControls2
    Qt5::Svg
)

################################################################################

## Windows
if(WIN32)
    set_target_properties(${CMAKE_PROJECT_NAME} PROPERTIES
        WIN32_EXECUTABLE ON
    )

    target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE
        _USE_MATH_DEFINES
    )
endif()

## Debug or release
if(CMAKE_BUILD_TYPE STREQUAL Release)
    target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE
        NDEBUG
        QT_NO_DEBUG
        QT_NO_DEBUG_OUTPUT
    )
endif()

################################################################################

if(lupdate_only)
    target_sources(${CMAKE_PROJECT_NAME} PUBLIC
        qml/*.js qml/*.qml
        qml/components/*.qml
        qml/components_generic/*.qml
        qml/components_js/*.js
    )
endif()

################################################################################

install(TARGETS ${CMAKE_PROJECT_NAME}
    BUNDLE DESTINATION .
    ARCHIVE DESTINATION .
    LIBRARY DESTINATION .
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
