# robotpkg Makefile for:	supervision/transgen
# Created:			Matthieu Herrb on Thu, 12 Mar 2009
#
DISTNAME=	transgen-1.0b4
CATEGORIES=	supervision
MASTER_SITES=	${MASTER_SITE_OPENROBOTS:=openprs/}
MASTER_REPOSITORY= git ssh://trac.laas.fr/git/robots/transgen

MAINTAINER=		felix@laas.fr
HOMEPAGE=		https://softs.laas.fr/openrobots/wiki/openprs
LICENSE=		2-clause-bsd
COMMENT=		Glue between Genom modules and OpenPRS.

GNU_CONFIGURE=	yes
CONFIGURE_ARGS+=--with-oprs-data-dir=${PREFIX.openprs}/share/openprs/data
CONFIGURE_ARGS+=--with-modules-data-dir=${PREFIX.openprs}/share/modules/openprs

include ../../supervision/openprs/depend.mk
include ../../middleware/pocolibs/depend.mk
include ../../devel/mkdep/depend.mk
include ../../pkgtools/pkg-config/depend.mk
include ../../pkgtools/libtool/depend.mk
include ../../mk/robotpkg.mk
