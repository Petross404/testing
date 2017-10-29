# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit eutils distutils-r1

DESCRIPTION="PyQt5 converter for audio, video, image and document files"
HOMEPAGE="https://sites.google.com/site/ffmulticonverter/"
SRC_URI="https://sourceforge.net/projects/ffmulticonv/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	app-office/unoconv
	dev-python/PyQt5
	media-gfx/imagemagick
	media-video/ffmpeg"

DEPEND="${RDEPEND}"

pkg_postinst() {
	if ! ( has_version "app-office/unoconv" ) ; then
		ewarn "The program does NOT require unoconv to run,"
		ewarn "but you won't be able to convert between LO files."
	fi

	if ! ( has_version "media-gfx/imagemagick" ) ; then
		ewarn "The program does NOT require ImageMagick to run,"
		ewarn "but you won't be able to convert image files."
	fi

	if ! ( has_version "media-video/ffmpeg" ) ; then
		ewarn "The program does NOT require ffmpeg to run,"
		ewarn "but you won't be able to convert media files."
	fi
}
