# robotpkg Makefile for:	image/viman-genom
# Created:			Severin Lemaignan on Tue, 31 Aug 2010
#

DISTNAME=		viman-genom-1.0
CATEGORIES=		image
MASTER_SITES=		${MASTER_SITE_OPENROBOTS:=viman-genom/}
MASTER_REPOSITORY=	git ssh://trac/git/robots/viman-genom

MAINTAINER=		xavier.broquere@laas.fr
#HOMEPAGE=
COMMENT=		VIsion for MANipulation module

#Viman license is GPL because it links with ARToolKit which is GPL
LICENSE=		gnu-gpl-v2

USE_LANGUAGES+=		c c++

GENOM_MODULE=		viman

include ../../architecture/genom/depend.mk
include ../../image/artoolkitplus/depend.mk

include ../../mk/robotpkg.mk