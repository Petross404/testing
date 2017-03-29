# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils git-r3

DESCRIPTION="Scripts (star.sh & star-gui.sh) in order to tar and restore your system."
HOMEPAGE="https://github.com/tritonas00/system-tar-and-restore"
EGIT_REPO_URI="https://github.com/tritonas00/system-tar-and-restore.git"
KEYWORDS="**"

LICENSE="GPL-2"
IUSE="gui parallel-xz parallel-bzip2"
SLOT="0"

RDEPEND="
	gui? ( x11-misc/gtkdialog )
	parallel-xz? ( app-arch/pxz )
	parallel-bzip2? ( app-arch/pbzip2 )
	app-shells/bash:0
	"

DEPEND="${RDEPEND}"

src_prepare(){
	eapply "${FILESDIR}"/fix_path.patch
	eapply_user
}

src_install(){
	dobin star.sh
	dobin star-gui.sh

	newconfd backup.conf "${PN}"-Backup.conf

	insinto /usr/share/"${PN}"/
	newins backup.conf backup.example.conf

	cd pms
	insinto /usr/share/polkit-1/actions/
	doins org.freedesktop.star-gui.policy

	insinto /usr/share/applications/
	doins system-tar-and-restore.desktop
}
