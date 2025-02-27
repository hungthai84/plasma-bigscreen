/*
    Copyright 2019 MArco MArtni <mart@kde.org>
    Copyright 2013-2017 Jan Grulich <jgrulich@redhat.com>

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Lesser General Public
    License as published by the Free Software Foundation; either
    version 2.1 of the License, or (at your option) version 3, or any
    later version accepted by the membership of KDE e.V. (or its
    successor approved by the membership of KDE e.V.), which shall
    act as a proxy defined in Section 6 of version 3 of the license.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Lesser General Public License for more details.

    You should have received a copy of the GNU Lesser General Public
    License along with this library.  If not, see <http://www.gnu.org/licenses/>.
*/

import QtQuick 2.14
import QtQuick.Layouts 1.14
import org.kde.plasma.core 2.0 as PlasmaCore
import org.kde.plasma.components 2.0 as PlasmaComponents
import org.kde.plasma.networkmanagement 0.2 as PlasmaNM
import org.kde.kirigami 2.12 as Kirigami
import org.kde.plasma.private.nanoshell 2.0 as NanoShell

AbstractIndicator {
    id: connectionIcon

    icon.name: connectionIconProvider.connectionIcon

    PlasmaComponents.BusyIndicator {
        id: connectingIndicator

        anchors.fill: parent
        running: connectionIconProvider.connecting
        visible: running
    }

    PlasmaNM.NetworkStatus {
        id: networkStatus
    }

    PlasmaNM.NetworkModel {
        id: connectionModel
    }

    PlasmaNM.Handler {
        id: handler
    }

    PlasmaNM.ConnectionIcon {
        id: connectionIconProvider
    }
    onClicked: {
        NanoShell.StartupFeedback.open(
                            connectionIconProvider.connectionIcon,
                            i18n("Network"),
                            connectionIcon.Kirigami.ScenePosition.x + connectionIcon.width/2,
                            connectionIcon.Kirigami.ScenePosition.y + connectionIcon.height/2,
                            Math.min(connectionIcon.width, connectionIcon.height));
        plasmoid.nativeInterface.executeCommand("plasma-settings -s -m kcm_mediacenter_wifi")
    }
}
