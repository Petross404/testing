# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="C++14 GPIO library for embedded systems on Linux"
HOMEPAGE="https://github.com/JoachimSchurig/CppGPIO"

if [[ ${PV} == 9999 ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/JoachimSchurig/CppGPIO.git"
	KEYWORDS=""
else
	SRC_URI="https://github.com/JoachimSchurig/CppGPIO/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"
	S="${WORKDIR}/${PN}-v${PV}"
	KEYWORDS="~amd64"
fi

LICENSE=""
SLOT="0"
IUSE="static-libs"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

src_prepare() {
	eapply_user

	if use !static-libs ; then
		sed -i -e '/libnamea/d' Makefile || die "Sed failed!"
	fi

	sed -i -e 's/$(CHEADERINST)/$D$(CHEADERINST)/' Makefile || die "Sed failed!"
	sed -i -e 's/$(HEADERINST)/$D$(HEADERINST)/' Makefile || die "Sed failed!"
    sed -i -e 's/$($(LIBINST))/$D$($(LIBINST))/' Makefile || die "Sed failed!"
	sed -i -e "s/(PREFIX)\/lib/(PREFIX)\/$(get_libdir)/" Makefile || die "Sed failed!"
	sed -i -e 's/$(LIBINST)/$D$(LIBINST)/' Makefile || die "Sed failed!"
	sed -i -e 's/root:root/portage:portage/' Makefile || die "Sed failed!"
}
