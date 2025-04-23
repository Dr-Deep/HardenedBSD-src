CONFGROUPS=	CONFTTYS
PACKAGE=runtime
PROG=	init
MAN=	init.8
PRECIOUSPROG=
INSTALLFLAGS=-b -B.bak
CFLAGS+=-DDEBUGSHELL -DSECURE -DLOGIN_CAP -DCOMPAT_SYSV_INIT
LIBADD=	util crypt

CONFTTYSNAME=	ttys
CONFTTYS+=	ttys

<<<<<<< HEAD
NOCFI=	yes

# Needed for getmntopts.c
MOUNT=	${SRCTOP}/sbin/mount
CFLAGS+=-I${MOUNT}
.PATH:	${MOUNT}

=======
>>>>>>> internal/freebsd/current/main
NO_SHARED?=	YES

.include <bsd.prog.mk>
