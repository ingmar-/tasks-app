# More information: https://wiki.ubuntu.com/Touch/Testing
#
# Notes for autopilot tests:
# -----------------------------------------------------------
# In order to run autopilot tests:
# sudo apt-add-repository ppa:autopilot/ppa
# sudo apt-get update
# sudo apt-get install python-autopilot autopilot-qt
#############################################################

all:

autopilot:
	chmod +x tests/autopilot/run
	tests/autopilot/run

check:
	qmltestrunner -input tests/unit

run:
	/usr/bin/qmlscene $@ ubuntu-tasks.qml

icon:
	inkscape --export-png=icons/$(ICON).png --export-dpi=32 --export-background-opacity=0 --without-gui /usr/share/icons/ubuntu-mobile/actions/scalable/$(ICON).svg

clean:
	rm ~/.local/share/Qt\ Project/QtQmlViewer/ubuntu-tasks.db

package:
	./clickpkg $(VERSION)
