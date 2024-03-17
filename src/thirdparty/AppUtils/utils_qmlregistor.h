#ifndef UTILS_QMLREGISTOR_H
#define UTILS_QMLREGISTOR_H

#include <QtQml>
#include <QList>

namespace Qml {

namespace Register {

template <class T>
struct Type {
    Type() {
        auto initializer = []() {
            qmlRegisterType<T>();
        };
#ifdef _MSC_VER
        Queue::GetList().append(initializer);
#else
        initializer();
#endif
    }
};
}
}

#endif // UTILS_QMLREGISTOR_H
