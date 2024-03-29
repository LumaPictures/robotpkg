# robotpkg Makefile for:	image/visp
# Created:			Anthony Mallet on Tue, 9 Feb 2010
#
DISTNAME=		visp-${PKGVERSION_NOREV}
PKGVERSION=		2.4.4

CATEGORIES=		image devel
MASTER_SITES=		https://gforge.inria.fr/frs/download.php/25154/

MAINTAINER=		openrobots@laas.fr
HOMEPAGE=		http://www.irisa.fr/lagadic/visp/
COMMENT=		The Visual Servoing Platform
LICENSE=		qpl

WRKSRC=			${WRKDIR}/ViSP-code

USE_LANGUAGES+=		c c++
EG_DIR=			share/examples/visp
INSTALLATION_DIRS+=	${EG_DIR}

# Configuration flags.
# See http://www.irisa.fr/lagadic/visp/librarieslist.html for details.
#

# Build shared libraries, enforce backward compatibility, don't build code
# coverage tests and enforce examples building
CMAKE_ARGS+=		-DBUILD_SHARED_LIBS=ON
CMAKE_ARGS+=		-DBUILD_DEPRECATED=ON
CMAKE_ARGS+=		-DBUILD_TESTING=OFF
CMAKE_ARGS+=		-DBUILD_EXAMPLES=ON

# Never use deprecated libdc1394-1
CMAKE_ARGS+=		-DUSE_DC1394_1=OFF

# Compilation with ffmpeg fails
CMAKE_ARGS+=		-DUSE_FFMPEG=OFF


# User configurable options.
#
PKG_SUPPORTED_OPTIONS+=	coin gsl gtk dc1394 jpeg opencv plotutils png v4l xml
PKG_SUGGESTED_OPTIONS+= jpeg png xml plotutils

PKG_OPTION_DESCR.dc1394?=	Enable image acquisition via libdc1394
PKG_OPTION_UNSET.dc1394:=	CMAKE_ARGS+=-DUSE_DC1394_2=OFF
define PKG_OPTION_SET.dc1394
  CMAKE_ARGS+=-DUSE_DC1394_2=ON
  include ../../image/libdc1394/depend.mk
endef

PKG_OPTION_DESCR.v4l?=		Enable image acquisition via Video For Linux 2
PKG_OPTION_UNSET.v4l:=		CMAKE_ARGS+=-DUSE_V4L2=OFF
define PKG_OPTION_SET.v4l
  CMAKE_ARGS+=-DUSE_V4L2=ON
endef

PKG_OPTION_DESCR.opencv?=	Enable the OpenCV interface
PKG_OPTION_UNSET.opencv:=	CMAKE_ARGS+=-DUSE_OPENCV=OFF
define PKG_OPTION_SET.opencv
  CMAKE_ARGS+=-DUSE_OPENCV=ON
  CMAKE_ARGS+=-DOpenCV_ROOT_DIR=${PREFIX.opencv}
  include ../../image/opencv/depend.mk
endef

PKG_OPTION_DESCR.coin?=		Enable use of the Coin simulator
PKG_OPTION_UNSET.coin:=		CMAKE_ARGS+=-DUSE_COIN_SIMULATOR=OFF
define PKG_OPTION_SET.coin
  CMAKE_ARGS+=-DUSE_COIN_SIMULATOR=ON
  include ../../mk/sysdep/coin2.mk
  include ../../mk/sysdep/libsoqt.mk
endef

PKG_OPTION_DESCR.gsl?=		Use gsl library for SVD and LU decomposition
PKG_OPTION_UNSET.gsl:=		CMAKE_ARGS+=-DUSE_GSL=OFF
define PKG_OPTION_SET.gsl
  CMAKE_ARGS+=-DUSE_GSL=ON
  include ../../mk/sysdep/gsl.mk
endef

PKG_OPTION_DESCR.xml?=		Enable XML-based camera calibration file format
PKG_OPTION_UNSET.xml:=		CMAKE_ARGS+=-DUSE_XML2=OFF
define PKG_OPTION_SET.xml
  CMAKE_ARGS+=-DUSE_XML2=ON
  include ../../mk/sysdep/libxml2.mk
endef

PKG_OPTION_DESCR.gtk?=		Enable gtk-based display
PKG_OPTION_UNSET.gtk:=		CMAKE_ARGS+=-DUSE_GTK2=OFF
define PKG_OPTION_SET.gtk
  CMAKE_ARGS+=-DUSE_GTK2=ON
  include ../../mk/sysdep/gtk.mk
endef

PKG_OPTION_DESCR.jpeg?=		Enable jpeg image format
PKG_OPTION_UNSET.jpeg:=		CMAKE_ARGS+=-DUSE_LIBJPEG=OFF
define PKG_OPTION_SET.jpeg
  CMAKE_ARGS+=-DUSE_LIBJPEG=ON
  include ../../mk/sysdep/libjpeg.mk
endef

PKG_OPTION_DESCR.png?=		Enable png image format
PKG_OPTION_UNSET.png:=		CMAKE_ARGS+=-DUSE_LIBPNG=OFF
define PKG_OPTION_SET.png
  CMAKE_ARGS+=-DUSE_LIBPNG=ON
  include ../../mk/sysdep/libpng.mk
endef

# libplotter is provided by plotutils package.
PKG_OPTION_DESCR.plotutils?=	Enable plotting via plotutils
PKG_OPTION_UNSET.plotutils:=	CMAKE_ARGS+=-DUSE_LIBPLOTTER=OFF
define PKG_OPTION_SET.plotutils
  CMAKE_ARGS+=-DUSE_LIBPLOTTER=ON
  include ../../mk/sysdep/plotutils.mk
endef



include ../../archivers/zlib/depend.mk
include ../../pkgtools/pax/depend.mk
include ../../mk/sysdep/cmake.mk
include ../../mk/robotpkg.mk

# Install examples
#
post-install: visp-install-examples

.PHONY: visp-install-examples
visp-install-examples:
	@${STEP_MSG} "Installing example files"
	${RUN}cd ${WRKSRC} && cd example &&				\
	${FIND} . -name "*cpp" | while read f; do			\
		${TEST} -x $${f%.cpp} && ${ECHO} $${f%.cpp};		\
		${ECHO} $$f;						\
	done | ${PAX} -rw -pm ${PREFIX}/${EG_DIR}
