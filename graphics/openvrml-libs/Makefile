# robotpkg Makefile for:	devel/openvrml-libs
# Created:			Thomas Moulard on Wed, 8 Sep 2010
#

PKGVERSION=		0.18.6
DISTNAME=		openvrml-${PKGVERSION_NOREV}
PKGNAME=		openvrml-libs-${PKGVERSION}
CATEGORIES=		devel
MASTER_SITES=		${MASTER_SITE_SOURCEFORGE:=openvrml/}

MAINTAINER=		tmoulard@laas.fr
HOMEPAGE=		http://www.openvrml.org
COMMENT=		A free VRML/X3D runtime
LICENSE=		gnu-lgpl-v3

# Triggers a g++-4.1.2 internal error
NOT_FOR_PLATFORM+=	NetBSD-5.1-%

USE_LANGUAGES+=		c c++
GNU_CONFIGURE=		yes
DOXYGEN_PLIST_DIR=	share/doc/${DISTNAME}

# build libraries only.
CONFIGURE_ARGS+=--disable-gecko-rpath
CONFIGURE_ARGS+=--disable-script-node-javascript
CONFIGURE_ARGS+=--disable-script-node-java
CONFIGURE_ARGS+=--disable-xembed
CONFIGURE_ARGS+=--disable-player
CONFIGURE_ARGS+=--disable-mozilla-plugin
CONFIGURE_ARGS+=--disable-examples

CONFIGURE_ARGS+=--enable-gl-renderer

# get the right boost libraries suffix.
CONFIGURE_ARGS+=BOOST_LIB_SUFFIX=${BOOST_LIB_SUFFIX}

# required for boost>=1.46
CPPFLAGS+=	-DBOOST_FILESYSTEM_VERSION=2

# fix detection of ltdl and boost. configure script searches in /usr only.
CPPFLAGS+=$(addsuffix /include,$(addprefix -I,	\
		$(sort ${PREFIX.libtool-ltdl} ${PREFIX.boost-headers})))
LDFLAGS+=$(addsuffix /lib,$(addprefix -L,	\
		$(sort ${PREFIX.libtool-ltdl} ${PREFIX.boost-libs})))

include ../../devel/boost-headers/depend.mk
include ../../devel/boost-libs/depend.mk
include ../../mk/sysdep/libxml2.mk
include ../../mk/sysdep/mesa.mk
include ../../mk/sysdep/glu.mk
include ../../mk/sysdep/libpng.mk
include ../../mk/sysdep/libjpeg.mk
include ../../mk/sysdep/doxygen.mk
include ../../mk/sysdep/libtool-ltdl.mk
include ../../mk/robotpkg.mk
