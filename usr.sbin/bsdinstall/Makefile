OSNAME?=	HardenedBSD

SUBDIR=	distextract distfetch include partedit runconsoles scripts
SUBDIR_PARALLEL=
SUBDIR_DEPEND_distextract = include
SUBDIR_DEPEND_distfetch = include
SUBDIR_DEPEND_partedit = include
SCRIPTS= bsdinstall
MAN= bsdinstall.8
PACKAGE=	bsdinstall

SCRIPTS+=	startbsdinstall
SCRIPTSDIR_startbsdinstall=	${LIBEXECDIR}/bsdinstall

UPDATE_DEPENDFILE= no

FILESDIR=	${SHAREDIR}/bsdinstall
FILES=		HardenedBSD-base.conf

_BRANCH!=	${MAKE} -C ${SRCTOP}/release -V BRANCH
BRANCH?=	${_BRANCH:C/-p[0-9]+$//}
_REVISION!=	${MAKE} -C ${SRCTOP}/release -V REVISION
REVISION?=	${_REVISION}

.if ${BRANCH} == CURRENT || ${BRANCH} == STABLE
SUBURL=		latest
.endif

HardenedBSD-base.conf: HardenedBSD-base.conf.in
	sed "s|%%PKGHOST%%|${PKGHOST}|;s|%%SUBURL%%|${SUBURL}|;s|%%KEYSDIR%%|${KEYSDIR}|" < ${.ALLSRC} > ${.TARGET}

.include <bsd.prog.mk>
