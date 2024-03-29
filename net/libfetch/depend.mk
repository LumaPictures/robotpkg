# robotpkg depend.mk for:	net/libfetch
# Created:			Anthony Mallet on Sat, 19 Apr 2008
#

DEPEND_DEPTH:=		${DEPEND_DEPTH}+
LIBFETCH_DEPEND_MK:=	${LIBFETCH_DEPEND_MK}+

ifeq (+,$(LIBFETCH_DEPEND_MK))
PREFER.libfetch?=	robotpkg

SYSTEM_SEARCH.libfetch=	\
	include/fetch.h	\
	lib/libfetch.a

DEPEND_ABI.libfetch?=	libfetch>=2.33.1
DEPEND_DIR.libfetch?=	../../net/libfetch

  # pull-in the user preferences for libfetch now
  include ../../mk/robotpkg.prefs.mk

  ifeq (inplace+robotpkg,$(strip $(LIBFETCH_STYLE)+$(PREFER.libfetch)))
  # This is the "inplace" version of libfetch package, for bootstrap process
  #
LIBFETCH_FILESDIR=	${ROBOTPKG_DIR}/net/libfetch/dist
LIBFETCH_SRCDIR=	${WRKDIR}/libfetch

CPPFLAGS+=	-I${LIBFETCH_SRCDIR}
LDFLAGS+=	-L${LIBFETCH_SRCDIR}
LIBS+=		-lfetch

ifeq (MacOSX,${OPSYS})
  # Make sure that the linker uses our static library instead of the
  # (outdated) dynamic library "/usr/lib/libfetch.dylib".
  LDFLAGS+=	-Wl,-search_paths_first
endif

post-extract: libfetch-extract
libfetch-extract:
	@${STEP_MSG} "Extracting libfetch in place"
	${CP} -Rp ${LIBFETCH_FILESDIR} ${LIBFETCH_SRCDIR}

pre-configure: libfetch-build
libfetch-build:
	@${STEP_MSG} "Building libfetch in place"
	${RUN}								\
	cd ${LIBFETCH_SRCDIR} &&					\
	${CONFIGURE_LOGFILTER} ${CONFIG_SHELL} ./configure -C &&	\
	${CONFIGURE_LOGFILTER} ${SETENV}				\
		AWK="${AWK}" CC="${CC}" CFLAGS="${CFLAGS}"		\
		CPPFLAGS="${CPPFLAGS}" ${MAKE_PROGRAM} depend all
  else
  # This is the regular version of libfetch package, for normal install
  #
DEPEND_USE+=		libfetch
  endif
endif

ifeq (+,$(DEPEND_DEPTH))
DEPEND_PKG+=		$(filter libfetch,${DEPEND_USE})
endif

DEPEND_DEPTH:=		${DEPEND_DEPTH:+=}
