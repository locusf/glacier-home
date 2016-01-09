
// This file is part of colorful-home, a nice user experience for touchscreens.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//
// Copyright (c) 2011, Tom Swindell <t.swindell@rubyx.co.uk>
// Copyright (c) 2012, Timur Kristóf <venemo@fedoraproject.org>

import QtQuick 2.1
import org.nemomobile.lipstick 0.1
import Material 0.1
// Feeds page:
// the place for an event feed.
Flickable {
    id: mainFlickable

    contentHeight: rootitem.height
    contentWidth: parent.width
    Item {
        id: rootitem
        width: parent.width
        height: childrenRect.height
        // Day of week
        Row {
            id: daterow
            height: displayCurrentDate.height + 15
            Label {
                id: displayDayOfWeek
                text: Qt.formatDateTime(wallClock.time, "dddd") + ", "
                color: "white"
                font.pointSize: 12
                font.bold: true
                anchors {
                    top: parent.top
                    left: parent.left
                    topMargin: 30
                    leftMargin: 20
                }
            }

            // Current date
            Label {
                id: displayCurrentDate
                text: Qt.formatDate(wallClock.time, "d MMMM yyyy")
                font.pointSize: 12
                width: rootitem.width - displayDayOfWeek.width - 20
                wrapMode: Text.WordWrap
                anchors {
                    left: displayDayOfWeek.right
                    top: parent.top
                    topMargin: 30
                }
            }
        }

        Column {
            id: notificationColumn
            anchors.top: daterow.bottom
            anchors.topMargin: 20
            spacing: 10
            Repeater {
                model: NotificationListModel {
                    id: notifmodel
                }
                delegate:
                    MouseArea {
                        height: Math.max(appSummary.height,appBody.height)
                        width: rootitem.width

                        onClicked: {
                            if (modelData.userRemovable) {
                                modelData.actionInvoked("default")
                            }
                        }

                        Image {
                            id: appIcon
                            source: {
                                if (modelData.icon)
                                    return "image://theme/" + modelData.icon
                                else
                                    return ""
                            }
                        }

                        Label {
                            id: appSummary
                            text: modelData.summary
                            width: (rootitem.width-appIcon.width)/2
                            font.pointSize: 10
                            anchors.left: appIcon.right
                            wrapMode: Text.Wrap
                        }
                        Label {
                            id: appBody
                            width: (rootitem.width-appIcon.width)/2
                            text: modelData.body
                            font.pointSize: 8
                            wrapMode: Text.Wrap
                            anchors.left: appSummary.right
                        }
                    }
                }
            }
        }
}

