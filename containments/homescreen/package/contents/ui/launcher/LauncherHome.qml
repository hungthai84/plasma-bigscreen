/*
 * Copyright 2019 Aditya Mehra <aix.m@outlook.com>
 * Copyright 2015 Marco Martin <mart@kde.org>
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  2.010-1301, USA.
 */

import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3 as Controls
import QtQuick.Window 2.2
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.kquickcontrolsaddons 2.0
import org.kde.private.biglauncher 1.0 as Launcher
import org.kde.kirigami 2.11 as Kirigami

import "delegates" as Delegates
import "views" as Views
import org.kde.mycroft.bigscreen 1.0 as BigScreen


FocusScope {
    anchors {
        fill: parent
        margins: units.smallSpacing * 2
    }

    ColumnLayout {
        id: launcherHomeColumn
        anchors {
            left: parent.left
            right: parent.right
        }
        property Item currentSection
        y: currentSection ? -currentSection.y : 0
        Behavior on y {
            //Can't be an Animator
            NumberAnimation {
                duration: Kirigami.Units.longDuration * 2
                easing.type: Easing.InOutQuad
            }
        }
        height: parent.height
        spacing: 0
        

        BigScreen.TileView {
            id: gridView
            title: i18n("Voice Apps")
            model: plasmoid.nativeInterface.voiceAppListModel
            currentIndex: 0
            focus: true
            onActiveFocusChanged: if (activeFocus) launcherHomeColumn.currentSection = gridView
            delegate: Delegates.VoiceAppDelegate {
                property var modelData: typeof model !== "undefined" ? model : null
                
            }

            navigationUp: shutdownIndicator
            navigationDown: gridView2
        }

        BigScreen.TileView {
            id: gridView2
            title: i18n("Apps & Games")
            model: plasmoid.nativeInterface.applicationListModel
            currentIndex: 0
            focus: false
            onActiveFocusChanged: if (activeFocus) launcherHomeColumn.currentSection = gridView2
            delegate: Delegates.AppDelegate {
                property var modelData: typeof model !== "undefined" ? model : null
            }
            
            navigationUp: gridView
            navigationDown: gridView3
        }
        
        BigScreen.TileView {
            id: gridView3
            title: i18n("Settings")
            model: actions

            property list<Controls.Action> actions: [
                Controls.Action {
                    text: i18n("Wireless")
                    icon.name: "network-wireless-connected-100"
                    onTriggered: plasmoid.nativeInterface.executeCommand("plasma-settings -s -m kcm_mobile_wifi")
                },
                Controls.Action {
                    text: i18n("Audio")
                    icon.name: "audio-volume-high"
                    onTriggered: plasmoid.nativeInterface.executeCommand("plasma-settings -s -m kcm_audiodevice")

                },
                Controls.Action {
                    text: i18n("Wallpaper")
                    icon.name: "preferences-desktop-vallpaper"
                    onTriggered: plasmoid.action("configure").trigger();
                },
                Controls.Action {
                    text: i18n("Mycroft")
                    icon.name: "mycroft"
                    onTriggered: print("Mycroft Clicked")
                }
            ]

            onActiveFocusChanged: if (activeFocus) launcherHomeColumn.currentSection = gridView3
            delegate: Delegates.SettingDelegate {
                property var modelData: typeof model !== "undefined" ? model : null
            }
            
            navigationUp: gridView2
            navigationDown: null
        }

        Component.onCompleted: {
            gridView.forceActiveFocus();
        }

        Connections {
            target: root
            onActivateAppView: {
                gridView.forceActiveFocus();
            }
        }
    }
}

