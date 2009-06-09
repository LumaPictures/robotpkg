#
#
# Copyright (c) 2009 LAAS/CNRS
# All rights reserved.
#
# Redistribution  and  use in source   and binary forms,  with or without
# modification, are permitted provided that  the following conditions are
# met:
#
#   1. Redistributions  of  source code must  retain  the above copyright
#      notice and this list of conditions.
#   2. Redistributions in binary form must  reproduce the above copyright
#      notice  and this list of  conditions in the documentation   and/or
#      other materials provided with the distribution.
#
#                                       Florent Lamiraux 04/28/2009
#

DISTNAME=	roboptim-trajectory-${VERSION}
PKGNAME=	roboptim-trajectory-${VERSION}
VERSION=	0.2.1

CATEGORIES=	optimization
MASTER_SITES=	${MASTER_SITE_OPENROBOTS:=roboptim/}
MASTER_REPOSITORY=	${MASTER_REPOSITORY_JRL}roboptim/trajectory

MAINTAINER=	roboptim-user@lists.sourceforge.net
HOMEPAGE=	http://sourceforge.net/projects/roboptim/
COMMENT=	Optimization for robotics: trajectory optimization

DOXYGEN_PLIST_DIR+=	share/doc/roboptim-trajectory

GNU_CONFIGURE=	yes

# --------------------------------------------------------------------

include ../../pkgtools/pkg-config/depend.mk
include ../../optimization/roboptim-core/depend.mk
include ../../mk/sysdep/doxygen.mk
include ../../mk/sysdep/latex.mk
include ../../mk/robotpkg.mk