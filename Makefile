DISTRIB := Deepin
DISCODE := lion
VERSION := 15.10.1
RELEASE := stable 

all: build

build:
	sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version.in > files/desktop-version
	sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" -e "s|@@DISTRIB@@|$(DISTRIB)|g" -e "s|@@DISCODE@@|$(DISCODE)|g" files/lsb-release.in > files/lsb-release

install:
	mkdir -p ${DESTDIR}/etc
	mkdir -p ${DESTDIR}/usr/share/i18n
	mkdir -p ${DESTDIR}/usr/share/distro-info
	mkdir -p ${DESTDIR}/usr/share/python-apt/templates
	mkdir -p ${DESTDIR}/usr/share/backgrounds/deepin
	install -Dm644 files/i18n_dependent.json  ${DESTDIR}/usr/share/i18n/i18n_dependent.json
	install -Dm644 files/language_info.json  ${DESTDIR}/usr/share/i18n/language_info.json
	install -Dm644 files/desktop-version ${DESTDIR}/usr/lib/deepin/desktop-version
	install -Dm644 files/lsb-release     ${DESTDIR}/etc/lsb-release
	install -Dm644 files/appstore.json     ${DESTDIR}/etc/appstore.json
	install -Dm644 files/deepin-logo.png ${DESTDIR}/usr/share/plymouth/deepin-logo.png
	[ -e files/systemd.conf ] && install -Dm644 files/systemd.conf ${DESTDIR}/etc/systemd/system.conf.d/deepin-base.conf
	install -Dm644 files/Deepin.info     ${DESTDIR}/usr/share/python-apt/templates/Deepin.info
	install -Dm644 files/Deepin.mirrors     ${DESTDIR}/usr/share/python-apt/templates/Deepin.mirrors
	#ln -sf /usr/share/distro-info/debian.csv ${DESTDIR}/usr/share/distro-info/deepin.csv
	#echo "version,codename,series,created,release,eol" > ${DESTDIR}/usr/share/distro-info/deepin.csv
	#echo "15.2,Unstable,unstable,2016-06-01" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
	#echo "15.3,Unstable,unstable,2016-09-13" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
	#echo "15.4,Panda,panda,2017-04-19" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
	#echo "15.4.1,Panda,panda,2017-07-11" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
	#echo "15.5,Panda,panda,2017-11-15" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
	#echo "15.6,Panda,panda,2018-06-15" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
	#echo "15.7,Panda,panda,2018-08-15" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
	#echo "15.8,Panda,panda,2018-11-25" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
	#echo "15.9,Panda,panda,2019-01-15" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
clean:
	rm -f files/desktop-version
	rm -f files/lsb-release
