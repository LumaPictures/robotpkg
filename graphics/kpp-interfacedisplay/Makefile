# robotpkg Makefile for:	graphics/kpp-interfacedisplay
# Created:			florent on Fri, 3 Apr 2009
#

DISTNAME=	kppinterfacedisplay-${VERSION}
PKGNAME=	kpp-interfacedisplay-${VERSION}
VERSION=	1.0.2

CATEGORIES=	graphics
MASTER_SITES=	${MASTER_SITE_OPENROBOTS:=kpp-interfacedisplay/}

MAINTAINER=	hpp@laas.fr

COMMENT=	Graphical user interface for robotics components based on Kineo
LICENSE=	cnrs-hpp-closed-source

GNU_CONFIGURE=	yes
DOXYGEN_PLIST_DIR+=share/doc/kppInterfaceDisplay

# options
PKG_OPTIONS_OPTIONAL_GROUPS+=	verbose
PKG_OPTIONS_GROUP.verbose=	verbose1 verbose2

PKG_OPTION_DESCR.verbose1=	Set the level of verbosity to 1
PKG_OPTION_SET.verbose1:=	CXXFLAGS+=-DDEBUG=1

PKG_OPTION_DESCR.verbose2=	Set the level of verbosity to 2
PKG_OPTION_SET.verbose2:=	CXXFLAGS+=-DDEBUG=2

include ../../mk/sysdep/doxygen.mk
include ../../graphics/kpp-interfacewalk/depend.mk
include ../../architecture/genom/depend.mk
include ../../pkgtools/libtool/depend.mk
include ../../pkgtools/pkg-config/depend.mk
include ../../mk/robotpkg.mk
