# robotpkg Makefile for:	hardware/jr3-kmod
# Created:			Matthieu Herrb on Mon, 22 Dec 2008
#

DISTNAME=	jr3-kmod-1.0
PKGREVISION=	1
CATEGORIES=	hardware
MASTER_SITES=	${MASTER_SITE_OPENROBOTS:=linux/}

MAINTAINER=	openrobots@laas.fr
COMMENT=	Kernel driver for the JR3 force sensor PCI acquisition card

ONLY_FOR_PLATFORM=	Linux-%

KMOD_DIR=	lib/modules/${OS_KERNEL_VERSION}/kernel/drivers/char
KMOD=		jr3.ko
INSTALLATION_DIRS+=${KMOD_DIR}

MESSAGE_SUBST+=	CP=${CP}
MESSAGE_SUBST+=	KMOD_DIR=${KMOD_DIR}
MESSAGE_SUBST+=	KMOD=${KMOD}

include ../../mk/sysdep/kernel.mk
include ../../mk/sysdep/sudo.mk
include ../../mk/robotpkg.mk
