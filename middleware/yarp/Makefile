# robotpkg Makefile for:	middleware/yarp
# Created:			Anthony Mallet on Thu, 22 Jan 2009
#

DISTNAME=		yarp-2.3.1
CATEGORIES=		middleware
MASTER_SITES=		${MASTER_SITE_SOURCEFORGE:=yarp0/}

MAINTAINER=		openrobots@laas.fr
HOMEPAGE=		http://eris.liralab.it/yarpdoc/index.html
COMMENT=		Yet Another Robot Platform
LICENSE=		gnu-lgpl-v2

USE_LANGUAGES+=		c c++

CMAKE_ARGS+=		-DACE_INCLUDE_DIR=${PREFIX.ace}/include
CMAKE_ARGS+=		-DACE_LIBRARY=${PREFIX.ace}/lib/libACE.so
CMAKE_ARGS+=		-DACE_LINK_FLAGS=-L${PREFIX.ace}/lib
CMAKE_ARGS+=		-DCREATE_SHARED_LIBRARY=TRUE
CMAKE_ARGS+=		-DCREATE_YARPSERVER3=TRUE

# XXX needs something more generic
CXXFLAGS+=		-pthread

# gui option
PKG_SUPPORTED_OPTIONS+=	gui
PKG_SUGGESTED_OPTIONS+=	gui
PKG_OPTION_DESCR.doc?=	Install GUI utilities

define PKG_OPTION_SET.gui
  CMAKE_ARGS+=		-DCREATE_GUIS=TRUE

  include ../../mk/sysdep/gtk.mk
  include ../../mk/sysdep/glib2.mk
endef

include ../../middleware/ace/depend.mk
include ../../mk/sysdep/cmake.mk
include ../../mk/robotpkg.mk
