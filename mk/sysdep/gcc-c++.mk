# $LAAS: gcc-c++.mk 2008/11/02 02:26:31 tho $
#
# Copyright (c) 2008 LAAS/CNRS
# All rights reserved.
#
# Redistribution and use  in source  and binary  forms,  with or without
# modification, are permitted provided that the following conditions are
# met:
#
#   1. Redistributions of  source  code must retain the  above copyright
#      notice and this list of conditions.
#   2. Redistributions in binary form must reproduce the above copyright
#      notice and  this list of  conditions in the  documentation and/or
#      other materials provided with the distribution.
#
#                                      Anthony Mallet on Thu Oct 23 2008
#

ifndef ROBOTPKG_COMPILER_MK

# If we are included directly, simply register the compiler requirements
USE_LANGUAGES+=	c++

else

# If we are included from compiler-vars.mk, register the proper dependencies.

DEPEND_DEPTH:=		${DEPEND_DEPTH}+
GCC_C++_DEPEND_MK:=	${GCC_C++_DEPEND_MK}+

# g++>=4.0<4.3 can be provided by lang/gcc42-c++
ifneq (,$(shell ${PKG_ADMIN} pmatch 'gcc>=4.0<4.3' 'gcc-${_GCC_REQD}' && echo y))
  _GCC_C++_PKG:=	gcc42-c++
  _GCC_C++_DIR:=	../../lang/gcc42-c++
else
  _GCC_C++_PKG:=	gcc-c++
  _GCC_C++_DIR:=# empty
endif

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=		${_GCC_C++_PKG}
endif

ifeq (+,$(GCC_C++_DEPEND_MK)) # -------------------------------------------

PREFER.${_GCC_C++_PKG}?=	system

DEPEND_USE+=			${_GCC_C++_PKG}

DEPEND_ABI.${_GCC_C++_PKG}?=	${_GCC_C++_PKG}>=${_GCC_REQD}
DEPEND_DIR.${_GCC_C++_PKG}?=	${_GCC_C++_DIR}

SYSTEM_SEARCH.${_GCC_C++_PKG} = 'bin/g++::% -dumpversion'

include ../../mk/robotpkg.prefs.mk
ifeq (robotpkg,${PREFER.${_GCC_C++_PKG}})
  override CXX=${PREFIX.${_GCC_C++_PKG}}/bin/g++
else
  override CXX=$(word 1,${SYSTEM_FILES.${_GCC_C++_PKG}})
endif

endif # GCC_C++_DEPEND_MK -------------------------------------------------

DEPEND_DEPTH:=		${DEPEND_DEPTH:+=}

endif # ROBOTPKG_COMPILER_MK
