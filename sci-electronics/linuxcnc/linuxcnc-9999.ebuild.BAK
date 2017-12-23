# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="tk(+)"

inherit eutils python-single-r1 autotools

DESCRIPTION="LinuxCNC controls CNC machines."
HOMEPAGE="http://linuxcnc.org/"
EGIT_REPO_URI="https://github.com/LinuxCNC/linuxcnc"

LICENSE="GPL-2"
SLOT="0"
IUSE="+uspace +X +gtk gnome gstreamer +license -modbus usb"

if [[ "${PV}" == "9999" ]] ; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/LinuxCNC/linuxcnc.git"
	KEYWORDS="**"
else
	SRC_URI="https://codeload.github.com/LinuxCNC/"${PN}"/tar.gz/v"${PVR}" -> "${PF}".tar.gz"
	KEYWORDS="~amd64"
fi

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	virtual/libudev
	sys-libs/ncurses
	sys-libs/readline
	sys-devel/gettext
	dev-lang/tcl
	dev-lang/tk
	dev-tcltk/tclx
	dev-tcltk/tclreadline
	dev-tcltk/blt
	dev-tcltk/bwidget
	${PYTHON_DEPS}
	dev-python/pillow
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/configobj[${PYTHON_USEDEP}]
	dev-libs/boost[python,${PYTHON_USEDEP}]
	modbus? (
		dev-libs/libmodbus
	)
	usb? (
		virtual/libusb
	)
	media-libs/mesa
	x11-apps/mesa-progs
	X? (
		x11-libs/libXaw
		dev-python/python-xlib[${PYTHON_USEDEP}]
	)
	gtk? (
		x11-libs/gtk+:2
		dev-python/pygtkglext[${PYTHON_USEDEP}]
		dev-python/pygtksourceview[${PYTHON_USEDEP}]
		x11-libs/vte[python,${PYTHON_USEDEP}]
	)
	gnome? (
		dev-python/gnome-python-base
		dev-util/glade[python]
		gnome-base/libgnomeprintui
	)
	gstreamer? (
		dev-python/gst-python:0.10
		media-libs/gst-plugins-base:0.10
	)
	|| (
		net-analyzer/netcat
		net-analyzer/netcat6
	)
	sys-process/procps
	sys-process/psmisc
	net-firewall/iptables
	media-gfx/graphviz
"

DEPEND="${RDEPEND}"

S="${S}"/src

src_prepare() {
	find . -iname fixpaths.py -o -iname checkglade -o -iname update_ini|xargs perl -p -i -e "s/python/python2/"
	#linuxcnc tried to run ldconfig during install throwing sandbox violation
	sed -i '/ldconfig/d' "${S}"/Makefile || die "sed fix failed. Uh-oh..."
	eautoreconf
	eapply_user
}

src_configure() {
	econf \
		'--prefix=/usr' \
		'--with-python=/usr/bin/python2.7' \
		'--with-boost-python=boost_python-2.7' \
		'--enable-non-distributable='$(usex license yes no) \
		$(use_with X x) \
		$(use_enable gtk) \
		$(use_with modbus libmodbus) \
		$(use_with usb libusb-1.0) \
		'--with-realtime='$(usex uspace uspace RTAI)
}

src_install(){
	insinto /usr/share/${PN} 
	dodir share/applications/ || die
	#cp -PR ../share/* /usr/share/${PN} || die
	emake DESTDIR="${D}" install
}
