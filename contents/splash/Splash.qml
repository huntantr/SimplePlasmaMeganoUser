/*
 *   Copyright 2014 Marco Martin <mart@kde.org>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License version 2,
 *   or (at your option) any later version, as published by the Free
 *   Software Foundation
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details
 *
 *   You should have received a copy of the GNU General Public
 *   License along with this program; if not, write to the
 *   Free Software Foundation, Inc.,
 *   51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
 */

import QtQuick 2.5
import QtGraphicalEffects 1.0

import org.kde.kcoreaddons 1.0 as KCoreAddons // kuser

Rectangle {

    id: root
    color: "#1f1c28"
    //Image {source: "images/background.png"}
    property int stage

    onStageChanged: {
        if (stage == 1) {
            introAnimation.running = true;
        } else if (stage == 5) {
            introAnimation.target = busyIndicator;
            introAnimation.from = 1;
            introAnimation.to = 0;
            introAnimation.running = true;
        }
    }

    Item {
        id: content
        anchors.fill: parent
        opacity: 0
        TextMetrics {
            id: units
            text: "M"
            property int gridUnit: boundingRect.height
            property int largeSpacing: units.gridUnit
            property int smallSpacing: Math.max(2, gridUnit/4)
        }

        KCoreAddons.KUser {
            id: kuser
        }

        Image {
            id: logo
            property real size: units.gridUnit * 7
            opacity: 0.9
            anchors.centerIn: parent
            source: "images/kde.svg"

            sourceSize.width: size
            sourceSize.height: size
            
            ScaleAnimator on scale {
                from: 0;
                to: 1;
                duration: 1000
            }
            
        }
        
        FontLoader {
         source: "../components/artwork/fonts/OpenSans-Light.ttf"
        }

        Text {
            id: date
            text:Qt.formatDateTime(new Date(),"dddd dd | MMMM")
            font.pointSize: 35
            color: "#a1b4ba"
            font { family: "OpenSans Light"; weight: Font.Light ;capitalization: Font.Capitalize}
            anchors.horizontalCenter: parent.horizontalCenter
            y: (parent.height - height) / 2.7
            
            OpacityAnimator on opacity{
                from: 0
                to: 1
                duration: 400
                easing.type: Easing.InOutQuad
            }
        }

       Image {
            id: cargandoefecto
            y: root.height - (root.height - logo.y) / 1.9 - height/2
            anchors.horizontalCenter: parent.horizontalCenter
            source: "images/eclipse.svg"
            opacity: 0.9
            sourceSize.height: units.gridUnit * 4
            sourceSize.width: units.gridUnit * 4
            
            OpacityAnimator on opacity{
                from: 0
                to: 1
                duration: 1500
                easing.type: Easing.InOutQuad
            }
            
            RotationAnimator on rotation {
                id: rotationAnimator1
                from: 0
                to: 360
                duration: 1500
                loops: Animation.Infinite
            }
            
            ScaleAnimator on scale {
                from: 0;
                to: 1;
                duration: 1500
            }
        }
        
        

         Row {
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                right: parent.right
                rightMargin: units.gridUnit * 1.5
                margins: units.gridUnit
            }
            Image {
                //source: "images/tux.png"
                source: kuser.faceIconUrl.toString()
                sourceSize.height: units.gridUnit * 4
                sourceSize.width: units.gridUnit * 4
                
                OpacityAnimator on opacity{
                    from: 0
                    to: 1
                    duration: 1000
                    easing.type: Easing.InOutQuad
                }

            }
        }
        
        Row {
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                left: parent.left
                rightMargin: units.gridUnit * 1.5
                margins: units.gridUnit
            }
            Text {
                id: fechacompleta
                text:Qt.formatDateTime(new Date(),"dd/MM/yy | hh:mm AP")
                font.pointSize: 12
                color: "#a1b4ba"
                font { family: "OpenSans Light"; weight: Font.Light ;capitalization: Font.Capitalize}
                
                OpacityAnimator on opacity{
                    from: 0
                    to: 1
                    duration: 400
                    easing.type: Easing.InOutQuad
                }
            }
        }
    
    Row {
            spacing: units.smallSpacing*2
            anchors {
                bottom: parent.bottom
                left: parent.left
                rightMargin: 0
                margins: 0
            }
            Rectangle {
                id: progressBar
                radius: height
                color: "#31363b"
                opacity: 0.9
                height: Math.round(units.gridUnit/6)
                width: root.width
                Rectangle {
                    radius: 3
                    anchors {
                        left: parent.left
                        top: parent.top
                        bottom: parent.bottom
                    }
                    width: (root.width/5) * (stage - 1)
                    color: "#bd93f9"
                    Behavior on width {
                        PropertyAnimation {
                            duration: 450
                            easing.type: Easing.InOutQuad
                        }
                    }
                }
            }
        }
  
    }

    
    OpacityAnimator {
        id: introAnimation
        running: false
        target: content
        from: 0
        to: 1
        duration: 1000
        easing.type: Easing.InOutQuad
    }
    
}
