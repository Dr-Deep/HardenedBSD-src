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

NO_SHARED?=	YES

=======
>>>>>>> upstream/stable/15
.include <bsd.prog.mk>
