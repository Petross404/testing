# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python{3_4,3_5,3_6} )

inherit eutils distutils-r1

DESCRIPTION="FF Multi Converter is a GUI application that converts multiple media formats"
HOMEPAGE="https://sites.google.com/site/ffmulticonverter/"
SRC_URI="https://sourceforge.net/projects/ffmulticonv/files/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/PyQt5
	app-office/unoconv
	media-gfx/imagemagick
	media-video/ffmpeg"

DEPEND="${RDEPEND}"
