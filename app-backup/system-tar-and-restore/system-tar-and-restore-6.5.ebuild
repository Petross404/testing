# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="Scripts (star.sh & star-gui.sh) in order to tar and restore your system."
HOMEPAGE="https://github.com/tritonas00/system-tar-and-restore"
LICENSE="GPL-2"
IUSE="gui parallel-xz parallel-bzip2"
SLOT="0"
SRC_URI="https://github.com/tritonas00/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	gui? ( x11-misc/gtkdialog )
	app-shells/bash:0
	"
DEPEND="${RDEPEND}"

src_install(){
	dobin star.sh
	
	if use gui; then
		dobin star-gui.sh
	fi

	newconfd backup.conf "${PN}"-Backup.conf

	insinto /usr/share/"${PN}"/
	newins backup.conf backup.example.conf
}

pkg_postinst(){
	elog "If you need the Parallel LZMA compressor, make sure you have installed app-arch/pxz"
	elog "If you need the Parallel bzip2 (de)compressor, make sure you have installed app-arch/pbzip2"
}
