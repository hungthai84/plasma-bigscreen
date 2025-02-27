/*
 *   SPDX-FileCopyrightText: 2019-2020 Aditya Mehra <aix.m@outlook.com>
 *
 *   SPDX-License-Identifier: GPL-2.0-or-later OR GPL-3.0-or-later OR LicenseRef-KDE-Accepted-GPL
 */

import QtQuick.Layouts 1.14
import QtQuick 2.14
import QtQuick.Window 2.14
import QtQuick.Controls 2.14
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kirigami 2.12 as Kirigami
import org.kde.kdeconnect 1.0
import org.kde.kcm 1.1 as KCM
import org.kde.mycroft.bigscreen 1.0 as BigScreen
import "delegates" as Delegates

KCM.SimpleKCM {
    id: root
    
    title: i18n("KDE Connect")
    background: null
    leftPadding: Kirigami.Units.smallSpacing
    topPadding: 0
    rightPadding: Kirigami.Units.smallSpacing
    bottomPadding: 0
    
    Component.onCompleted: {
        connectionView.forceActiveFocus();
        console.log(DevicesModel.rowCount);
    }
    
    footer: Button {
        id: kcmcloseButton
        implicitHeight: Kirigami.Units.gridUnit * 2
        anchors.left: parent.left
        anchors.right: parent.right
        
        background: Rectangle {
            color: kcmcloseButton.activeFocus ? Kirigami.Theme.highlightColor : Kirigami.Theme.backgroundColor
        }
        
        contentItem: Item {
            RowLayout {
                anchors.centerIn: parent
                Kirigami.Icon {
                    Layout.preferredWidth: Kirigami.Units.iconSizes.small
                    Layout.preferredHeight: Kirigami.Units.iconSizes.small
                    source: "window-close"
                }
                Label {
                    text: i18n("Exit")
                }
            }
        } 

        Keys.onUpPressed: connectionView.forceActiveFocus()
        
        onClicked: {
            Window.window.close()
        }
        
        Keys.onReturnPressed: {
            Window.window.close()
        }
    }

    DevicesModel {
        id: allDevicesModel
    }
        
    contentItem: FocusScope {    
        ColumnLayout {
            anchors.left: parent.left
            anchors.leftMargin: Kirigami.Units.largeSpacing
            anchors.top: parent.top
            anchors.topMargin: Kirigami.Units.largeSpacing
            width: parent.width - deviceConnectionView.width
            height: parent.height
        
            BigScreen.TileView {
                id: connectionView
                focus: true
                model:  allDevicesModel
                Layout.alignment: Qt.AlignTop
                title: allDevicesModel.count > 0 ? "Found Devices" : "No Devices Found"
                currentIndex: 0
                delegate: Delegates.DeviceDelegate{}
                navigationDown: kcmcloseButton
                Behavior on x {
                    NumberAnimation {
                        duration: Kirigami.Units.longDuration * 2
                        easing.type: Easing.InOutQuad
                    }
                }
                onCurrentItemChanged: {
                    deviceConnectionView.currentDevice = currentItem.deviceObj
                }
            }
        }
                
        DeviceConnectionView {
            id: deviceConnectionView
            anchors.top: parent.top
            anchors.bottom: parent.bottom
            anchors.right: parent.right
            visible: allDevicesModel.count > 0 ? 1 : 0
            anchors.rightMargin: -Kirigami.Units.smallSpacing
            width: parent.width / 3.5
        }
    }
}
