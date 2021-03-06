/***************************************************************************
 * Whatsoever ye do in word or deed, do all in the name of the             *
 * Lord Jesus, giving thanks to God and the Father by him.                 *
 * - Colossians 3:17                                                       *
 *                                                                         *
 * Ubuntu Tasks - A task management system for Ubuntu Touch                *
 * Copyright (C) 2013 Michael Spencer <sonrisesoftware@gmail.com>          *                                                                         *
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
import "../ubuntu-ui-extras"

Page {
    id: root

    title: wideAspect ? i18n.tr("Tasks")
                      : projectName

    property string projectName: overview ? i18n.tr("Overview") : currentProject.name

    property var type: overview ? "overview" : "project"

    property bool overview: currentProject === null

    property var currentProject: null

    property bool showArchived: false

    Sidebar {
        id: sidebar

        ProjectsList {
            id: projectsList
        }

        //anchors.topMargin: units.gu(9.5)

        expanded: wideAspect
    }

    flickable: wideAspect ? null
                          : overview ? overviewTasksList.flickable
                                     : list.flickable

    onFlickableChanged: {
        if (flickable === null) {
            overviewTasksList.flickable.topMargin = 0
            overviewTasksList.flickable.contentY = 0

            list.flickable.topMargin = 0
            list.flickable.contentY = 0
        } else {
            overviewTasksList.flickable.topMargin = units.gu(9.5)
            overviewTasksList.flickable.contentY = -units.gu(9.5)

            list.flickable.topMargin = units.gu(9.5)
            list.flickable.contentY = -units.gu(9.5)
        }
    }

    Item {
        anchors {
            top: parent.top
            bottom: addBar.top//parent.bottom
            right: parent.right
            left: sidebar.right
        }

        OverviewTasksList {
            id: overviewTasksList

            anchors.fill: parent
            visible: overview
        }

        TasksList {
            id: list

            anchors.fill: parent

            visible: !overview

            showAddBar: false
            project: currentProject
        }
    }

    QuickAddBar {
        id: addBar
        expanded: currentProject === null ? false : currentProject.supportsAction("addTask")
        anchors.left: sidebar.right
    }

    onActiveChanged: tools.opened = wideAspect

    tools: ToolbarItems {
        locked: wideAspect
        opened: wideAspect

        ToolbarButton {
            id: newProjectButton
            iconSource: icon("add")
            text: i18n.tr("New Project")
            visible:  sidebar.expanded || currentProject === null

            onTriggered: {
                newProject(newProjectButton)
            }
        }

        Item {
            height: parent.height
            width: units.gu(0.5)
        }

        ToolbarButton {
            iconSource: icon("add")
            text: i18n.tr("Add Task")

            enabled: currentProject === null ? true : currentProject.supportsAction("addTask")
            visible: !wideAspect || currentProject !== null

            onTriggered: {
                if (currentProject === null)
                    tabs.selectedTabIndex = uncategorizedPage.tabIndex
                pageStack.push(Qt.resolvedUrl("AddTaskPage.qml"), {project: currentProject === null ? uncategorizedProject : currentProject})
            }
        }

        ToolbarButton {
            id: projectButton
            iconSource: icon("edit")
            text: i18n.tr("Edit")
            visible:  currentProject !== null && !currentProject.special

            onTriggered: {
                PopupUtils.open(editProjectDialog, projectButton, {project: currentProject})
            }
        }

        ToolbarButton {
            id: archiveButton
            iconSource: icon("save")
            text: i18n.tr("Archive")
            visible:  currentProject !== null && !currentProject.special

            onTriggered: {
                if (!wideAspect)
                    pageStack.pop()
                undoStack.setProperty(i18n.tr("Archive %1").arg(currentProject.name), currentProject, "archived", true)
                currentProject = null
            }
        }

        ToolbarButton {
            text: i18n.tr("Statistics")
            iconSource: icon("graphs")
            visible: currentProject != null && currentProject.backend.supportsStatistics

            onTriggered: {
                showStatistics(currentProject)
            }
        }

        ToolbarButton {
            id: optionsButton
            text: i18n.tr("Options")
            iconSource: icon("settings")
            visible: wideAspect || currentProject !== null

            onTriggered: {
                PopupUtils.open(optionsPopover, optionsButton)
            }
        }
    }

    Component {
        id: optionsPopover

        OptionsPopover {

        }
    }
}
