# $NetBSD: install.mk,v 1.8 2006/07/07 21:24:28 jlam Exp $

# --- install-check-conflicts (PRIVATE, mk/install/install.mk) -------
#
# install-check-conflicts checks for conflicts between the package
# and and installed packages.
#
.PHONY: pkg-install-check-conflicts
pkg-install-check-conflicts: #error-check
	${_PKG_SILENT}${_PKG_DEBUG}${RM} -f ${WRKDIR}/.CONFLICTS
	${_PKG_SILENT}${_PKG_DEBUG}					\
${foreach _conflict_,${CONFLICTS},					\
	found="`${_PKG_BEST_EXISTS} ${_conflict_} || ${TRUE}`";		\
	case "$$found" in						\
	"")	;;							\
	*)	${ECHO} "$$found" >> ${WRKDIR}/.CONFLICTS ;;		\
	esac;								\
}
	${_PKG_SILENT}${_PKG_DEBUG}					\
	${TEST} -f ${WRKDIR}/.CONFLICTS || exit 0;			\
	exec 1>${ERROR_DIR}/$@;						\
	${ECHO} "${PKGNAME} conflicts with installed package(s):";	\
	${CAT} ${WRKDIR}/.CONFLICTS | ${SED} -e "s|^|    |";		\
	${ECHO} "They install the same files into the same place.";	\
	${ECHO} "Please remove conflicts first with pkg_delete(1).";	\
	${RM} -f ${WRKDIR}/.CONFLICTS


# --- install-check-installed (PRIVATE, mk/install/install.mk) -------
#
# install-check-installed checks if the package (perhaps an older
# version) is already installed on the system.
#
.PHONY: pkg-install-check-installed
pkg-install-check-installed: #error-check
	${_PKG_SILENT}${_PKG_DEBUG}					\
	found="`${_PKG_BEST_EXISTS} ${PKGWILDCARD} || ${TRUE}`";	\
	${TEST} -n "$$found" || exit 0;					\
	exec 1>${ERROR_DIR}/$@;						\
	${ECHO} "$$found is already installed - perhaps an older version?"; \
	${ECHO} "If so, you may use either of:";			\
	${ECHO} "    - \"pkg_delete $$found\" and \"${MAKE} reinstall\""; \
	${ECHO} "      to upgrade properly";				\
	${ECHO} "    - \"${MAKE} update\" to rebuild the package and all"; \
	${ECHO} "      of its dependencies";				\
	${ECHO} "    - \"${MAKE} replace\" to replace only the package without"; \
	${ECHO} "      re-linking dependencies, risking various problems."


# --- pkg-register (PRIVATE, mk/install/install.mk) ------------------

# pkg-register populates the package database with the appropriate
# entries to register the package as being installed on the system.
#
define _REGISTER_DEPENDENCIES
	${SETENV} PKG_DBDIR=${_PKG_DBDIR}				\
		AWK=${TOOLS_AWK}					\
		PKG_ADMIN=${PKG_ADMIN_CMD}				\
	${SH} ${PKGSRCDIR}/mk/pkg/register-dependencies
endef

.PHONY: pkg-register
pkg-register: generate-metadata ${_COOKIE.depends}
	@${STEP_MSG} "Registering installation for ${PKGNAME}"
	${_PKG_SILENT}${_PKG_DEBUG}${RM} -fr ${_PKG_DBDIR}/${PKGNAME}
	${_PKG_SILENT}${_PKG_DEBUG}${MKDIR} ${_PKG_DBDIR}/${PKGNAME}
	${_PKG_SILENT}${_PKG_DEBUG}${CP} ${PKG_DB_TMPDIR}/* ${_PKG_DBDIR}/${PKGNAME}
	${_PKG_SILENT}${_PKG_DEBUG}${PKG_ADMIN} add ${PKGNAME}
	${_PKG_SILENT}${_PKG_DEBUG}					\
	case ${_AUTOMATIC}"" in						\
	[yY][eE][sS])	${PKG_ADMIN} set automatic=yes ${PKGNAME} ;;	\
	esac
	${_PKG_SILENT}${_PKG_DEBUG}${_DEPENDS_PATTERNS_CMD} |		\
		${SORT} -u | ${_REGISTER_DEPENDENCIES} ${PKGNAME}
