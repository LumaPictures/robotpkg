# robotpkg Makefile for:	manipulation/coldman-libs
# Created:			Anthony Mallet on Fri, 15 Oct 2010
#

PKGVERSION=		1.4
DISTNAME=		coldman-libs-${PKGVERSION_NOREV}
CATEGORIES=		manipulation
MASTER_SITES=		${MASTER_SITE_OPENROBOTS:=coldman-libs/}
MASTER_REPOSITORY=	git ssh://trac.laas.fr/git/robots/coldman-libs

MAINTAINER=		xavier.broquere@laas.fr

COMMENT=		COLision Detection for MANipulation
LICENSE=		gnu-lgpl-v3

USE_LANGUAGES+=		c c++

# option for display using glut
PKG_SUPPORTED_OPTIONS+=	display
PKG_SUGGESTED_OPTIONS+=	display

PKG_OPTION_DESCR.display=	Enable embedded display facility.
define PKG_OPTION_SET.display
  CMAKE_ARGS+=-DENABLE_DISPLAY=ON
  CMAKE_ARGS+=-DGLUT_INCLUDE_DIR=${PREFIX.freeglut}/include
  CMAKE_ARGS+=-DGLUT_glut_LIBRARY=$(filter %.so,${SYSTEM_FILES.freeglut})
  CMAKE_ARGS+=-DGLU_INC=${PREFIX.glu}/include
  CMAKE_ARGS+=-DGLU_LIB=${PREFIX.glu}/lib
  include ../../mk/sysdep/freeglut.mk
  include ../../mk/sysdep/glu.mk
  include ../../mk/sysdep/libXmu.mk
endef
PKG_OPTION_UNSET.display:=	CMAKE_ARGS+=-DENABLE_DISPLAY=OFF

include ../../graphics/pqp/depend.mk
include ../../mk/sysdep/cmake.mk
include ../../mk/robotpkg.mk
