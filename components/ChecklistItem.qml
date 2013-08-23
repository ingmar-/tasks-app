/***************************************************************************
 * Whatsoever ye do in word or deed, do all in the name of the             *
 * Lord Jesus, giving thanks to God and the Father by him.                 *
 * - Colossians 3:17                                                       *
 *                                                                         *
 * Ubuntu Tasks - A task management system for Ubuntu Touch                *
 * Copyright (C) 2013 Michael Spencer <sonrisesoftware@gmail.com>             *
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
import "../ubuntu-ui-extras"

Empty {
    id: root

    property alias completed: checkBox.checked
    property var checklist
    property int itemIndex

    Row {
        anchors {
            left: parent.left
            right: parent.right
            margins: units.gu(2)
            verticalCenter: parent.verticalCenter
        }

        spacing: units.gu(1)

        CheckBox {
            id: checkBox

            anchors.verticalCenter: parent.verticalCenter

            __acceptEvents: task.editable
            checked: checklist[itemIndex].completed
            onCheckedChanged: {
                checklist[itemIndex].completed = checked
                task.checklist = checklist
            }
        }

        EditableLabel {
            id: label
            anchors.verticalCenter: parent.verticalCenter
            width: parent.width - checkBox.width - parent.spacing

            editable: task.editable
            text: checklist[itemIndex].text
            onTextChanged: {
                checklist[itemIndex].text = text
                task.checklist = checklist
            }

            customClicking: true
        }
    }

    highlightWhenPressed: false

    removable: true
    onItemRemoved: {
        task.checklist.splice(itemIndex,1)
        task.checklist = task.checklist
    }

    backgroundIndicator: ListItemBackground {
        iconSource: icon("delete-white")
        text: i18n.tr("Delete")

        state: swipingState
    }

    onClicked: label.edit()
}
