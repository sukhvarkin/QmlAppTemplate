# QmlAppTemplate

A Qt5 / QML application template, with a full set of visual controls, helper modules, as well as build and deploy scripts and CI setups.

## About

#### Dependencies

You will need a C++17 compiler and Qt 5.15

```bash
$ sudo apt-get install -y build-essential qtbase5-dev qtdeclarative5-dev qtquickcontrols2-5-dev qml-module-qtquick2 qml-module-qtquick-controls \
libqt5svg5 libqt5svg5-dev libssl-dev libtool autoconf unzip wget libssl1.1 \
qml-module-qtquick-controls2 qml-module-qt-labs-settings \
qml-module-qtquick-layouts qml-module-qt-labs-qmlmodels \
qml-module-qtquick-dialogs qml-module-qtquick-layouts qml-module-qtquick-window2 \
```

#### Building QmlAppTemplate

```bash
$ git clone https://github.com/emericg/QmlAppTemplate.git --recursive
$ cd QmlAppTemplate/build/
$ qmake .. # configure with QMake
$ cmake .. # OR configure with CMake
$ make
```

#### C++ modules

> [AppUtils](src/thirdparty/AppUtils/README.md) Various general purpose helpers

> [SingleApplication](src/thirdparty/SingleApplication/README.md) Keep only one instance of your application active at a time

#### QML components

> TODO

#### Deploy scripts

> [Linux](deploy_linux.sh) application ZIP and AppImage

> [Windows](deploy_windows.sh) application ZIP and NSIS installer

#### GitHub CI workflows

These files are also useful to get an idea about the whole build and deploy process.

> [Desktop (cmake)](.github/workflows/builds_desktop_cmake.yml) Linux, macOS and Windows workflow

> [Linux flatpak](.github/workflows/flatpak.yml) "on demand" workflow

## Screenshots

![GUI_DESKTOP1](https://i.imgur.com/4QGJn5G.png)
![GUI_DESKTOP2](https://i.imgur.com/e0VWdYz.png)

## License

[![GitHub action](https://img.shields.io/github/actions/workflow/status/emericg/QmlAppTemplate/builds_desktop.yml?style=flat-square)](https://github.com/emericg/QmlAppTemplate/actions/workflows/builds_desktop.yml)
[![GitHub action](https://img.shields.io/github/actions/workflow/status/emericg/QmlAppTemplate/builds_mobile.yml?style=flat-square)](https://github.com/emericg/QmlAppTemplate/actions/workflows/builds_mobile.yml)
[![GitHub issues](https://img.shields.io/github/issues/emericg/QmlAppTemplate.svg?style=flat-square)](https://github.com/emericg/QmlAppTemplate/issues)
[![License: GPL v3](https://img.shields.io/badge/license-GPL%20v3-blue.svg?style=flat-square)](http://www.gnu.org/licenses/gpl-3.0)

QmlAppTemplate is free software; you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation; either version 3 of the License, or (at your option) any later version.  
Read the [LICENSE](LICENSE.md) file or [consult the license on the FSF website](https://www.gnu.org/licenses/gpl-3.0.txt) directly.

> Emeric Grange <emeric.grange@gmail.com>
