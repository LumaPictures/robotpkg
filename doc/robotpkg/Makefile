# robotpkg Makefile for:	doc/robotpkg-guide
# Created:			Anthony Mallet on Tue, 13 Jan 2009
#

DISTNAME=               robotpkg-guide-${VERSION}
CATEGORIES=             doc
MASTER_SITES=#		empty
DISTFILES=#		empty

MAINTAINER=             openrobots@laas.fr
HOMEPAGE=               http://www.laas.fr/~mallet/robotpkg
COMMENT=                A guide to robotpkg
LICENSE=		2-clause-bsd

DIST_SUBDIR=            ${PKGBASE}
USE_LANGUAGES=#		empty

OUTPUTS?=#		empty
NO_CHECKSUM=		yes
BUILD_TARGET=		$(sort ${OUTPUTS})
INSTALL_TARGET=		$(patsubst %,install-%,$(sort ${OUTPUTS}))

include ../../mk/robotpkg.prefs.mk # DATE
VERSION:=		$(shell ${DATE} '+%Y%m%d')

# option for pdf output generation
#
PKG_SUGGESTED_OPTIONS+= pdf
PKG_OPTION_DESCR.pdf=	Generate PDF output
define PKG_OPTION_SET.pdf
  OUTPUTS+=	pdf
  USE_TEX_PKGS+=lmodern.sty
  include ../../mk/sysdep/tex-pkg.mk
  include ../../mk/sysdep/pdflatex.mk
endef

# option for html output generation
#
PKG_OPTION_DESCR.html=	Generate HTML output
define PKG_OPTION_SET.html
  OUTPUTS+=	html
  USE_TEX_PKGS+=lmodern.sty
  include ../../mk/sysdep/tex-pkg.mk
  include ../../mk/sysdep/pdflatex.mk
  include ../../sysutils/tth/depend.mk
endef

# option for text output generation
#
PKG_OPTION_DESCR.txt=	Generate ASCII text output
define PKG_OPTION_SET.txt
  OUTPUTS+=	txt
  USE_TEX_PKGS+=lmodern.sty
  include ../../mk/sysdep/tex-pkg.mk
  include ../../mk/sysdep/pdflatex.mk
  include ../../sysutils/tth/depend.mk
  include ../../mk/sysdep/w3m.mk
endef

PKG_OPTIONS_NONEMPTY_SETS=	output
PKG_OPTIONS_SET.output=		html pdf txt

include ../../pkgtools/install-sh/depend.mk
include ../../mk/robotpkg.mk

# The source files are only symlinked into the WRKSRC, so that they can
# be easily modified, should the build phase fail.
#
pre-extract:
	${MKDIR} ${WRKSRC}
	${LN} -s ${FILESDIR}/* ${WRKSRC}


# install the HTML and ASCII output into the robotpkg directory, for
# distribution with robotpkg.
#
# note that this uses ${CP} and not ${INSTALL_DATA} because the files
# stay in the development directories and have nothing to do with
# the permissions or ownership of installed files.
#
regen:
	${MAKE} PKG_OPTIONS.${PKGBASE}="html txt"
	${CP} ${WRKSRC}/robotpkg.html ${ROBOTPKG_DIR}/README.html
	${CP} ${WRKSRC}/robotpkg.txt ${ROBOTPKG_DIR}/README.txt
