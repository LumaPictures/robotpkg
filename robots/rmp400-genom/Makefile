# robotpkg Makefile for:	robots/rmp400-genom
# Created:			Matthieu Herrb on Thu, 29 Apr 2010
#


DISTNAME=		rmp400-genom-${VERSION}
PKGREVISION=	1
VERSION=		0.5
CATEGORIES=		robots
MASTER_SITES=		${MASTER_SITE_OPENROBOTS:=rmp400/}
MASTER_REPOSITORY=	${MASTER_REPOSITORY_OPENROBOTS}rmp400-genom

MAINTAINER=		openrobots@laas.fr
COMMENT=		GenoM interface module for the Segway RMP400

LICENSE=		isc

GENOM_MODULE=		rmp400

PKG_OPTIONS_OPTIONAL_GROUPS=	gyro
PKG_OPTIONS_GROUP.gyro=			gyro-client gyroKVH1000 gyroKVH5000

PKG_OPTION_DESCR.gyro-client=	Enable gyro support using gyro GeNoM module
define PKG_OPTION_SET.gyro-client
  include ../../localization/gyro-genom/depend.mk
  GENOM_ARGS += -DGYRO=gyro-client
endef

PKG_OPTION_DESCR.gyroKVH1000=	Enable gyro support using directly gyroKVH1000
define PKG_OPTION_SET.gyroKVH1000
  include ../../hardware/gyroKVH1000/depend.mk
  GENOM_ARGS += -DGYRO=gyroKVH1000Task
endef

PKG_OPTION_DESCR.gyroKVH5000=	Enable gyro support using directly gyroKVH5000
define PKG_OPTION_SET.gyroKVH5000
  include ../../hardware/gyroKVH5000/depend.mk
  GENOM_ARGS += -DGYRO=gyroKVH5000
endef

PKG_SUPPORTED_OPTIONS+= mana-emergency
PKG_OPTION_DESCR.mana-emergency= Enable support for Mana emergency stop device
define PKG_OPTION_SET.mana-emergency
  include ../../robots/mana-emergency/depend.mk
  GENOM_ARGS += -DWITH_FELIB
endef

define PKG_OPTION_UNSET.api
	include ../../robots/rmp-libs/depend.mk
	include ../../motion/contlaw/depend.mk
endef

include ../../architecture/genom/depend.mk
include ../../interfaces/genBasic-genom/depend.mk
include ../../interfaces/genPos-genom/depend.mk
include ../../localization/pom-genom/depend.mk
include ../../mk/robotpkg.mk
