/***************************************************************************
 * Whatsoever ye do in word or deed, do all in the name of the             *
 * Lord Jesus, giving thanks to God and the Father by him.                 *
 * - Colossians 3:17                                                       *
 *                                                                         *
 * Ubuntu Tasks - A task management system for Ubuntu Touch                *
 * Copyright (C) 2013 Michael Spencer <spencers1993@gmail.com>             *
 *                                                                         *
 * This program is free software: you can redistribute it and/or modify    *
 * it under the terms of the GNU General Public License as published by    *
 * the Free Software Foundation, either version 3 of the License, or       *
 * (at your option) any later version.                                     *
 *                                                                         *
 * This program is distributed in the hope that it will be useful,         *
 * but WITHOUT ANY WARRANTY; without even the implied warranty of          *
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the            *
 * GNU General Public License for more details.                            *
 *                                                                         *
 * You should have received a copy of the GNU General Public License       *
 * along with this program. If not, see <http://www.gnu.org/licenses/>.    *
 ***************************************************************************/
import QtQuick 2.0
import Ubuntu.Components 0.1
import Ubuntu.Components.ListItems 0.1
import Ubuntu.Components.Popups 0.1
import "../components"

Page {
    id: root

    title: task.category

    property Task task

    property alias editing: taskItem.editing

//    property color headerColor: labelHeaderColor(task.label)
//    property color backgroundColor: labelColor(task.label)
//    property color footerColor: labelFooterColor(task.label)

    TaskItem {
        id: taskItem
        task: root.task
        anchors.fill: parent
        anchors.margins: units.gu(1)
    }

    tools: ToolbarItems {
//        ToolbarButton {
//            text: i18n.tr("Move")
//            iconSource: icon("location")
//            onTriggered: {
//                PopupUtils.open(Qt.resolvedUrl("../components/CategoriesPopover.qml"), caller, {
//                                    task: root.task
//                                })
//            }
//        }

        ToolbarButton {
            text: i18n.tr("Delete")
            iconSource: icon("delete")
            onTriggered: {
                pageStack.pop()
                task.remove()
            }
        }
    }
}
