VERSION := 15.4
RELEASE := 

all: build

build:
	sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/desktop-version.in > files/desktop-version
	sed -e "s|@@VERSION@@|$(VERSION)|g" -e "s|@@RELEASE@@|$(RELEASE)|g" files/lsb-release.in > files/lsb-release

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
	install -Dm644 files/desktop.jpg     ${DESTDIR}/usr/share/backgrounds/deepin/desktop.jpg
	install -Dm644 files/13ada65a5cf7674cb0a68dd1db9cb37c.jpg ${DESTDIR}/var/cache/image-blur/13ada65a5cf7674cb0a68dd1db9cb37c.jpg
	[ -e files/systemd.conf ] && install -Dm644 files/systemd.conf ${DESTDIR}/etc/systemd/system.conf.d/deepin-base.conf
	install -Dm644 files/Deepin.info     ${DESTDIR}/usr/share/python-apt/templates/Deepin.info
	install -Dm644 files/Deepin.mirrors     ${DESTDIR}/usr/share/python-apt/templates/Deepin.mirrors
	#ln -sf /usr/share/distro-info/debian.csv ${DESTDIR}/usr/share/distro-info/deepin.csv
	echo "version,codename,series,created,release,eol" > ${DESTDIR}/usr/share/distro-info/deepin.csv
	echo "15.2,Unstable,unstable,2016-06-01" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
	echo "15.3,Unstable,unstable,2016-09-12" >> ${DESTDIR}/usr/share/distro-info/deepin.csv
clean:
	rm -f files/desktop-version
	rm -f files/lsb-release
