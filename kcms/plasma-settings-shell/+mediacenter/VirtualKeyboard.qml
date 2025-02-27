/*
 *   SPDX-FileCopyrightText: 2019-2020 Marco Martin <mart@kde.org>
 *
 *   SPDX-License-Identifier: GPL-2.0-or-later OR GPL-3.0-or-later OR LicenseRef-KDE-Accepted-GPL
 */

import QtQuick 2.14
import QtQuick.VirtualKeyboard 2.2

InputPanel {
    id: inputPanel
    active:  Qt.inputMethod.visible
    visible: active
    width: parent.width

    //keep the default keyboard size

    //onHeightChanged: resizeKeyboard();
    //onWidthChanged: resizeKeyboard();
    //function resizeKeyboard() {
        //keyboard.style.keyboardDesignWidth = width*3
        //keyboard.style.keyboardDesignHeight = height*3
    //}
    //Component.onCompleted: resizeKeyboard()
}
