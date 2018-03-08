# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils xdg qmake-utils

DESCRIPTION="Cross-platform source explorer for C/C++ and Java"
HOMEPAGE="https://www.sourcetrail.com"
IUSE=""

SRC_URI="
	x86?	( "https://www.sourcetrail.com/downloads/${PV}/linux/32bit" -> "${P}"_x86.tar.gz )
	amd64?	( "https://www.sourcetrail.com/downloads/${PV}/linux/64bit" -> "${P}"_x64.tar.gz )
"

KEYWORDS="~amd64 ~x86"
LICENSE="Sourcetrail-EULA"
SLOT=0

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/Sourcetrail"
RESTRICT="strip"
QA_PREBUILT="*"

src_prepare () {
	default

	cd setup/share/applications/
	sed -i \
		-e 's/\/usr\/bin\/sourcetrail/\/usr\/bin\/sourcetrail-bin/g' \
		-e 's/;IDE;Utilities;//' \
		sourcetrail.desktop || die

	eapply_user
}

src_install () {
	exeinto /opt/${PN}
	doexe	Sourcetrail sourcetrail_indexer Sourcetrail.sh || die

	exeinto /opt/${PN}/lib
	for i in $( ls lib/ | grep lib ); do
		doexe lib/$i || die
	done

	insinto /opt/${PN}
	doins -r data plugin user

	insinto /opt/${PN}/lib
	doins -r lib/platforms || die

	insinto /usr/share/applications
	doins	setup/share/applications/sourcetrail.desktop

	insinto /usr/share/icons
	doins -r setup/share/icons/
	newins	data/gui/icon/logo_1024_1024.png	sourcetrail.png
	newins	data/gui/icon/project_256_256.png	project-sourcetrail.png

	insinto /usr/mime/packages
	doins setup/share/mime/packages/sourcetrail-mime.xml

	make_wrapper ${PN} ./Sourcetrail.sh /opt/${PN}
}

pkg_postinst() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_mimeinfo_database_update
	xdg_desktop_database_update
}
