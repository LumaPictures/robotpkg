# robotpkg Makefile for:	simulation/morse-yarp
# Created:			Anthony Mallet on Tue, 12 Apr 2011
#

PKGNAME=		morse-yarp-${MORSE_VERSION}
PKGREVISION=	1

include ../../simulation/morse/Makefile.common

COMMENT+=		(YARP bindings)

CMAKE_ARGS+=		-DBUILD_CORE_SUPPORT=OFF
CMAKE_ARGS+=		-DBUILD_DOC_SUPPORT=OFF

CMAKE_ARGS+=		-DBUILD_POCOLIBS_SUPPORT=OFF
CMAKE_ARGS+=		-DBUILD_ROS_SUPPORT=OFF
CMAKE_ARGS+=		-DBUILD_YARP2_SUPPORT=ON
CMAKE_ARGS+=		-DBUILD_MOOS_SUPPORT=OFF
CMAKE_ARGS+=		-DBUILD_HLA_SUPPORT=OFF

include ../../middleware/py-yarp/depend.mk
include ../../simulation/morse/depend.mk
include ../../mk/robotpkg.mk
