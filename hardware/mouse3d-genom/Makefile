# robotpkg Makefile for:	hardware/mouse3d-genom
# Created:			Xavier Broquere on Fri, 20 Mar 2009
#

DISTNAME=		mouse3d-genom-1.2
CATEGORIES=		hardware
MASTER_SITES=		${MASTER_SITE_OPENROBOTS:=mouse3d/}
MASTER_REPOSITORY=	${MASTER_REPOSITORY_OPENROBOTS}mouse3d-genom

MAINTAINER=		mallet@laas.fr
COMMENT=		GenoM module that exports 3DConnexion mouse data
LICENSE=		2-clause-bsd

# Uses linux/input.h hid
ONLY_FOR_PLATFORM=	Linux-%

GENOM_MODULE=		mouse3d

include ../../architecture/genom/depend.mk
include ../../math/gbM/depend.mk
include ../../manipulation/genManip-genom/depend.mk
include ../../interfaces/genBasic-genom/depend.mk
include ../../mk/robotpkg.mk
