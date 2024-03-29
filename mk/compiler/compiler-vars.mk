#
# Copyright (c) 2006-2012 LAAS/CNRS
# All rights reserved.
#
# This project includes software developed by the NetBSD Foundation, Inc.
# and its contributors. It is derived from the 'pkgsrc' project
# (http://www.pkgsrc.org).
#
# Redistribution and use  in source  and binary  forms,  with or without
# modification, are permitted provided that the following conditions are
# met:
#
#   1. Redistributions of  source  code must retain the  above copyright
#      notice, this list of conditions and the following disclaimer.
#   2. Redistributions in binary form must reproduce the above copyright
#      notice,  this list of  conditions and the following disclaimer in
#      the  documentation  and/or  other   materials provided  with  the
#      distribution.
#
# THIS  SOFTWARE IS PROVIDED BY  THE  COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND  ANY  EXPRESS OR IMPLIED  WARRANTIES,  INCLUDING,  BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES  OF MERCHANTABILITY AND FITNESS FOR
# A PARTICULAR  PURPOSE ARE DISCLAIMED. IN  NO EVENT SHALL THE COPYRIGHT
# HOLDERS OR      CONTRIBUTORS  BE LIABLE FOR   ANY    DIRECT, INDIRECT,
# INCIDENTAL,  SPECIAL,  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF  SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
# ON ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR
# TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE
# USE   OF THIS SOFTWARE, EVEN   IF ADVISED OF   THE POSSIBILITY OF SUCH
# DAMAGE.
#
# From $NetBSD: compiler.mk,v 1.58 2006/12/03 08:34:45 seb Exp $
#
#                                      Anthony Mallet on Wed Dec  6 2006
#

# This Makefile fragment implements handling for supported C/C++/Fortran
# compilers.
#
# The following variables may be set by the robotpkg user in robotpkg.conf:
#
# ROBOTPKG_COMPILER
#	A list of values specifying the chain of compilers to be used by
#	robotpkg to build packages.
#
#	Valid values are:
#		ccache		compiler cache (chainable)
#		gcc		GNU
#
#	The default is "gcc".  You can use ccache with an appropriate
#	ROBOTPKG_COMPILER setting, e.g. "ccache gcc".  The chain should always
#	end in a real compiler. This should only be set in robotpkg.conf.
#
#
# The following variables may be set by a package:
#
# USE_LANGUAGES
#	Lists the languages used in the source code of the package,
#	and is used to determine the correct compilers to install.
#	Valid values are: c, c99, c++, fortran, java.  The
#       default is "c".
#

ifndef ROBOTPKG_COMPILER_MK
ROBOTPKG_COMPILER_MK=	defined

# Add C support if c99 is set
ifneq (,$(filter c99,${USE_LANGUAGES}))
USE_LANGUAGES+=	c
endif

# Add C++ support if c++0x is set
ifneq (,$(filter c++0x,${USE_LANGUAGES}))
USE_LANGUAGES+=	c++
endif


# List of supported compilers and pseudo compilers that can be chained
_COMPILERS=		gcc
_PSEUDO_COMPILERS=	ccache

# Compute the list of compilers for the current package
ifdef NOT_FOR_COMPILER
  _ACCEPTABLE_COMPILERS=$(filter-out ${NOT_FOR_COMPILER},${_COMPILERS})
else ifdef ONLY_FOR_COMPILER
  _ACCEPTABLE_COMPILERS=$(filter ${ONLY_FOR_COMPILER},${_COMPILERS})
else
  _ACCEPTABLE_COMPILERS=${_COMPILERS}
endif

# Select the compiler according to the user choice
ifneq (,${_ACCEPTABLE_COMPILERS})
  _COMPILER=$(firstword $(filter ${_ACCEPTABLE_COMPILERS},${ROBOTPKG_COMPILER}))
endif
ifeq (,${_COMPILER})
  PKG_FAIL_REASON+=\
	"$${bf}No acceptable compiler found for ${PKGNAME}.$${rm}"
  PKG_FAIL_REASON+= ""
  PKG_FAIL_REASON+=\
	"Please add one of the following compilers to your ROBOTPKG_COMPILER"
  PKG_FAIL_REASON+= "variable in robotpkg.conf:"
  PKG_FAIL_REASON+= ""
  PKG_FAIL_REASON+= "	${_ACCEPTABLE_COMPILERS}"
endif

# Prepend pseudo-compilers
_PSEUDO=$(filter ${_PSEUDO_COMPILERS},${ROBOTPKG_COMPILER})
_COMPILER:=${_PSEUDO} ${_COMPILER}


# Include compilers definitions
ROBOTPKG_CPP=
ROBOTPKG_CXXCPP=
ROBOTPKG_CC=
ROBOTPKG_CXX=
ROBOTPKG_FC=
$(call require,$(patsubst %,${ROBOTPKG_DIR}/mk/compiler/%.mk,${_COMPILER}))

ifneq (,$(filter python,${USE_LANGUAGES}))
  PKG_FAIL_REASON+="USE_LANGUAGES+= python is deprecated"
endif

# Remaining empty variables are explicitely set to 'false' so that missing
# languages in USE_LANGUAGES are detected
#
ifeq (,${ROBOTPKG_CPP})
  override CPP=	${FALSE}
else
  override CPP=	$(strip ${ROBOTPKG_CPP})
endif
ifeq (,${ROBOTPKG_CXXCPP})
  override CXXCPP=${FALSE}
else
  override CXXCPP=${ROBOTPKG_CXXCPP}
endif
ifeq (,${ROBOTPKG_CC})
  override CC=	${FALSE}
else
  override CC=	$(strip ${ROBOTPKG_CC})
endif
ifeq (,${ROBOTPKG_CXX})
  override CXX=	${FALSE}
else
  override CXX=	$(strip ${ROBOTPKG_CXX})
endif
ifeq (,${ROBOTPKG_FC})
  override FC=	${FALSE}
else
  override FC=	$(strip ${ROBOTPKG_FC})
endif
override F77=	${FC}

export CPP CXXCPP CC CXX FC F77

# INCLUDE_DIRS.<pkg> is a list of subdirectories of PREFIX.<pkg> (or absolute
# directories) that should be added to the compiler search paths. We add
# INCLUDE_DIRS to CPPFLAGS, CFLAGS and CXXFLAGS since much software ignores the
# value of CPPFLAGS that we set in the environment.
#
INCLUDE_DIRS=$(addprefix -I,						\
	$(call lappend, $(filter-out /usr/include,			\
	  $(foreach _pkg_,${DEPEND_USE}, $(realpath			\
	    $(addprefix ${PREFIX.${_pkg_}}/,${INCLUDE_DIRS.${_pkg_}})	\
	    ${INCLUDE_DIRS.${_pkg_}})))))
CPPFLAGS+=	${INCLUDE_DIRS}
CFLAGS+=	${INCLUDE_DIRS}
CXXFLAGS+=	${INCLUDE_DIRS}

# LIBRARY_DIRS.<pkg> is a list of subdirectories of PREFIX.<pkg> (or absolute
# directories) that should be added to the linker search paths.
#
_LIBRARY_DIRS=$(addprefix -L,						\
	$(call lappend,							\
	  $(filter-out $(addprefix /usr/,${SYSLIBDIR} lib),		\
	  $(addprefix ${PREFIX}/,					\
	    $(patsubst ${PREFIX}/%,%,${LIBRARY_DIRS}))			\
	  $(foreach _pkg_,${DEPEND_USE}, $(realpath			\
	    $(addprefix ${PREFIX.${_pkg_}}/,${LIBRARY_DIRS.${_pkg_}})	\
	    ${LIBRARY_DIRS.${_pkg_}})))))
LDFLAGS+=	${_LIBRARY_DIRS}

# RPATH_DIRS.<pkg> is a list of subdirectories of PREFIX.<pkg> (or absolute
# directories) that should be added to the linker run-time search paths.
#
_RPATH_DIRS=$(addprefix ${COMPILER_RPATH_FLAG},				\
	$(call lappend,							\
	  $(filter-out $(addprefix /usr/,${SYSLIBDIR} lib),		\
	  $(addprefix ${PREFIX}/,					\
	    $(patsubst ${PREFIX}/%,%,${RPATH_DIRS}))			\
	  $(foreach _pkg_,${DEPEND_USE}, $(realpath			\
	    $(addprefix ${PREFIX.${_pkg_}}/,${RPATH_DIRS.${_pkg_}})	\
	    ${RPATH_DIRS.${_pkg_}})))))
ifeq (yes,$(call isyes,${_USE_RPATH}))
  LDFLAGS+=	${_RPATH_DIRS}
endif

# Check user specific compile flags, with pattern option settings in the
# absence of an explicit setting.
#
override define _cflags_patternopt
  ifndef $1.${PKG_OPTIONS_SUFFIX}
    $1.${PKG_OPTIONS_SUFFIX}:=$$(strip					\
      $$(foreach _,$$(filter $1.%,$${.VARIABLES}),$$(strip		\
        $$(if $$(filter $$_,$1.${PKG_OPTIONS_SUFFIX}),$$(value $$_)))))
  endif
endef
$(foreach _,CPPFLAGS CFLAGS CXXFLAGS LDFLAGS,				\
  $(eval $(call _cflags_patternopt,$_)))

# Append {CPP,C,CXX,LD}FLAGS.<pkg> to the corresponding variable.
CPPFLAGS+=$(call lappend,						\
  $(foreach _,${DEPEND_USE} ${PKG_OPTIONS_SUFFIX},${CPPFLAGS.$_}))
CFLAGS+=$(call lappend,							\
  $(foreach _,${DEPEND_USE} ${PKG_OPTIONS_SUFFIX},${CFLAGS.$_}))
CXXFLAGS+=$(call lappend,						\
  $(foreach _,${DEPEND_USE} ${PKG_OPTIONS_SUFFIX},${CXXFLAGS.$_}))
LDFLAGS+=$(call lappend,						\
  $(foreach _,${DEPEND_USE} ${PKG_OPTIONS_SUFFIX},${LDFLAGS.$_}))

export CPPFLAGS
export CFLAGS
export LDFLAGS
ifneq (,$(filter c++,${USE_LANGUAGES}))
  export CXXFLAGS
endif

endif	# ROBOTPKG_COMPILER_MK
