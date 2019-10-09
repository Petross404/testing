# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit autotools check-reqs desktop flag-o-matic toolchain-funcs git-r3 llvm xdg-utils
# https://devmanual.gentoo.org/eclass-reference/ebuild/index.html
# https://devmanual.gentoo.org/eclass-reference/autotools.eclass/index.html
# https://devmanual.gentoo.org/eclass-reference/cmake-utils.eclass/index.html
# https://devmanual.gentoo.org/eclass-reference/desktop.eclass/index.html
# https://devmanual.gentoo.org/eclass-reference/git-r3.eclass/index.html
# https://devmanual.gentoo.org/eclass-reference/llvm.eclass/index.html
# https://devmanual.gentoo.org/eclass-reference/toolchain-funcs.eclass/index.html
# https://devmanual.gentoo.org/eclass-reference/flag-o-matic.eclass/index.html

DESCRIPTION="A multi-physics modeling and simulation environment"
HOMEPAGE="https://www.openmodelica.org/"
OMLIBFILENAME="openmodelicalibraries_20181220-190606"
SRC_URI="https://build.openmodelica.org/libraries/${OMLIBFILENAME}.tar.xz"
EGIT_REPO_URI="https://github.com/OpenModelica/OpenModelica"
#EGIT_REPO_URI="/home/vince/src/openmodelica/OpenModelica-repo"
EGIT_TAG="v1.13.2"

IUSE="clang doc cppruntime hdf5 hwloc om_all om_optim om_shellterminal sundials test"

# from OpenModelica/Readme.md :
# clang -> compile with clang/clang++  . HIGHLY RECCOMMENDED
# cppruntime -> use dev-libs/boost 
# hdf5 -> use HDF5 data library. Doesn't do much...
# hwloc -> queries the number of hardware CPU cores instead of logical CPU cores
# om_all -> build all libraries instead of only core ones (configure --with-omlibrary=core,all,no )
# om_optim -> build OMOptim tool. pull in Java JDK instead of JRE. configure for  CORBA_TARGETS="OMOptim-omoptim"
# om_shellterminal -> build the shell for use inside a terminal
# sundials -> adds more numerical solvers to the simulation runtime
# dev-lang/perl[ithreads] -> used for test

# from OpenModelica/configure :
#Optional Packages:
#  --with-PACKAGE[=ARG]    use PACKAGE [ARG=yes]
#  --without-PACKAGE       do not use PACKAGE (same as --with-PACKAGE=no)
#  --with-ombuilddir=build       (where build files are generated; OPENMODELICAHOME)
#  --with-openmodelicahome=OPENMODELICAHOME|PREFIX    (Find OPENMODELICAHOME - the directory where all OpenModelica dependencies are installed.)
#  --with-cppruntime       (build the optional cppruntime simulation libraries)
#  --with-omlibrary=core,all,no       (which libraries to build; default is core; the libraries used by the testsuite)
#  --with-MICO=DIR                  use mico corba installed in DIR (or use mico-config)
#  --with-omniORB=DIR               use omniORB installed in DIR (recommended CORBA implementation)

#./configure --with-omniORB=/path/to/omniORB (if you want omc to use omniORB corba)
#./configure --with-CORBA=/path/to/mico (if you want omc to use mico corba)
#./configure --without-CORBA            (if you want omc to use sockets)


LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"

RDEPEND="test? ( dev-lang/perl[ithreads] )"
DEPEND="${RDEPEND}
    sys-libs/glibc
    dev-vcs/git
    dev-libs/expat
    dev-util/cmake
    dev-games/openscenegraph
    dev-qt/qtcore
    dev-qt/qtgui
    dev-qt/qtwebkit
    dev-qt/qtopengl
    sci-libs/lapack-reference
    sci-libs/blas-reference
    sci-mathematics/lpsolve
    clang? ( sys-devel/clang )
    cppruntime? ( dev-libs/boost )
    hdf5? ( sci-libs/hdf5 )
    hwloc? ( sys-apps/hwloc )
    om_optim? ( dev-java/oracle-jdk-bin net-misc/omniORB )
    !om_optim? ( dev-java/oracle-jre-bin )
    om_shellterminal? ( sys-libs/ncurses sys-libs/readline )"
    # sundials? ( sci-libs/sundials )
    # please note that unfortunately, OpenModelica builds against older versions of sundials, shipped
    # with its sources. See https://trac.openmodelica.org/OpenModelica/ticket/3933
   
pkg_pretend()
{
# Final size of build directory: 5813108 KiB (5.5 GiB)
# Final size of installed tree:  1998612 KiB (1.9 GiB)
    CHECKREQS_DISK_BUILD="6G"
    check-reqs_pkg_setup
}
    
src_unpack() {
		EGIT_CHECKOUT_DIR=${WORKDIR}/${P}
		einfo "Cloning from github..."
		#git-r3_fetch
		git clone "${EGIT_REPO_URI}" "${EGIT_CHECKOUT_DIR}"
		einfo "Checking out from github..."
		#git-r3_checkout
		cd "${EGIT_CHECKOUT_DIR}"
		git checkout "${EGIT_TAG}"
		einfo "Fixing repo URIs..."
		sed -i 's,../,https://github.com/OpenModelica/,g' .gitmodules
		
		# avoid unnecessary sources:
		if ! use doc ; then
             [[ `git config --get submodule.doc.active` = "true" ]] && git config --replace submodule.doc.active false
        fi    
		if ! use test ; then
             [[ `git config --get submodule.testsuite.active` = "true" ]] && git config --replace submodule.testsuite.active false
        fi    
		if ! use om_optim ; then
            [[ `git config --get submodule.OMOptim.active` = "true" ]] && git config --replace submodule.OMOptim.active false
        fi
		
		# cloning repos of libraries often raises fatal errors "Could not resolve github.com"
		# this probably occurs due to proxy settings. In order to avoid the problem,
		# we just skip the clone and download the souces via tarball...
        [[ `git config --get submodule.libraries.active` = "true" ]] && git config --replace submodule.libraries.active false
		
		# sync submodules:
		git submodule sync --recursive
		git submodule update --init --recursive
		einfo "Checkout completed."
        GITVER=`git describe --long --tags | sed 's/^v//;s/\([^-]*-g\)/r\1/;s/-/./g'`
        elog "Working with ${PN}-${GITVER}..."

        unpack ${A}
}

src_prepare() {
    # https://trac.openmodelica.org/OpenModelica/ticket/5409
	eapply --binary "${FILESDIR}/paradiseo-cmake.patch"
	# https://trac.openmodelica.org/OpenModelica/ticket/3933
	eapply --binary "${FILESDIR}/sundials-cmake.patch"
	eapply_user
}

src_configure() {
    local myconf

    if use clang && ! tc-is-clang ; then
		# Force clang
		einfo "Enforcing the use of clang due to USE=clang ..."
		CC=${CHOST}-clang
		CXX=${CHOST}-clang++
		strip-unsupported-flags
	elif ! use clang && ! tc-is-gcc ; then
		# Force gcc
		einfo "Enforcing the use of gcc due to USE=-clang ..."
		CC=${CHOST}-gcc
		CXX=${CHOST}-g++
		strip-unsupported-flags
	fi

    # pass a variable to OMCompiler configure script. configure expects omc binary in PATH,
    # but tipically omc is not installed yet.
    myconf="--with-omc=${WORKDIR}/${PF}/build/bin"
    
    # pass a variable to OMPlot configure script:
    myconf="${myconf} --with-ombuilddir=${WORKDIR}/${PF}/build"
    
    # The following code can be uncommented when fetching libraries via GIT:
    # configure to build all libraries or core only:
    #if use om_all ; then
    #    myconf="${myconf} --with-omlibrary=all"
    #else
    #    myconf="${myconf} --with-omlibrary=core"
    #fi
    myconf="${myconf} --without-omlibrary" # libraries will be installed from tarball
    
    if use cppruntime ; then
        myconf="${myconf} --with-cppruntime --with-cppruntime-args=BUILDTYPE=Release,PARALLEL_OUTPUT,RUNTIME_PROFILING,FMU_SUNDIALS"
    fi
    
   	llvm_pkg_setup
    eautoconf

	if [[ -x ${ECONF_SOURCE:-.}/configure ]] ; then
		econf \
                $(use_with om_optim omniORB) \
                ${myconf}
	fi
}

src_compile() {
    einfo "Copying libraries..."
    mkdir -p ${WORKDIR}/${PF}/build/lib/omlibrary
    cp -ar  ${OMLIBFILENAME}/libraries/* ${WORKDIR}/${PF}/build/lib/omlibrary/
    einfo "Compile phase started."
	if [ -f Makefile ] || [ -f makefile ]; then
		emake
	fi
}

src_test() {
		if use test ; then
            cd testsuite/partest && ./runtests.pl
        fi
}

src_install() {
	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then
		emake DESTDIR="${D}" install
	fi
	einstalldocs
	
	doicon "OMEdit/OMEdit/OMEditGUI/Resources/icons/omedit.ico" "OMNotebook/OMNotebook/OMNotebookGUI/Resources/OMNotebook_icon.ico" "OMOptim/OMOptim/GUI/Resources/omoptim.ico" "OMShell/OMShell/OMShellGUI/Resources/omshell.ico" "OMPlot/OMPlot/OMPlotGUI/Resources/icons/omplot.ico"
	doicon -s scalable "OMEdit/OMEdit/OMEditGUI/Resources/icons/omedit.png" "OMNotebook/OMNotebook/OMNotebookGUI/Resources/OMNotebook_icon.svg" "OMShell/OMShell/OMShellGUI/Resources/omshell-large.svg" "OMPlot/OMPlot/OMPlotGUI/Resources/icons/omplot.png"
	#make_desktop_entry OMEdit "OpenModelica Connection Editor" "/usr/share/icons/scalable/apps/omedit.png" "Science"
	#make_desktop_entry OMNotebook "OpenModelica Notebook" "/usr/share/icons/scalable/apps/OMNotebook_icon.svg" "Science"
	#make_desktop_entry OMShell "OpenModelica Shell" "/usr/share/icons/scalable/apps/omshell-large.svg" "Science"
	make_desktop_entry OMEdit "OpenModelica Connection Editor" "omedit" "Science"
	make_desktop_entry OMNotebook "OpenModelica Notebook" "OMNotebook_icon" "Science"
	make_desktop_entry OMShell "OpenModelica Shell" "omshell-large" "Science"
}

pkg_preinst()
{
    return
}

pkg_postinst() {
	#echo "/usr/lib64/x86_64-linux-gnu/omc" > /etc/ld.so.conf.d/openmodelica.conf
	#echo "/usr/lib/x86_64-linux-gnu/omc" >> /etc/ld.so.conf.d/openmodelica.conf
	if use sundials ; then
        # sundials libraries should be simbolically linked:
        for S_LIB in "${ROOT}/usr/lib64/${CHOST}/omc/libsundials_cvode.so.1" \
                             "${ROOT}/usr/lib64/${CHOST}/omc/libsundials_ida.so.2" \
                             "${ROOT}/usr/lib64/${CHOST}/omc/libsundials_kinsol.so.1" \
                             "${ROOT}/usr/lib64/${CHOST}/omc/libsundials_cvodes.so.2" \
                             "${ROOT}/usr/lib64/${CHOST}/omc/libsundials_idas.so.0" \
                             "${ROOT}/usr/lib64/${CHOST}/omc/libsundials_arkode.so.1" \
                             "${ROOT}/usr/lib64/${CHOST}/omc/libsundials_nvecserial.so.0"
        do
            if [[ -f $S_LIB ]] ; then
                rm $S_LIB
                ln -s "$S_LIB.0.0" "$S_LIB"
            fi
        done
	fi
	ldconfig
	
	xdg_desktop_database_update
	xdg_icon_cache_update	
}

pkg_postrm() {
	xdg_desktop_database_update
	xdg_icon_cache_update
}

pkg_info() {
	OMCver=`"${ROOT}"/usr/bin/omc --version`
	echo "Compiler: ${OMCver}"
}

