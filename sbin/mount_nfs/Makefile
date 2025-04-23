PACKAGE=nfs
PROG=	mount_nfs
SRCS=	mount_nfs.c mounttab.c
MAN=	mount_nfs.8
LIBADD=	util

UMNTALL= ${SRCTOP}/usr.sbin/rpc.umntall
CFLAGS+= -DNFS -I${UMNTALL}

<<<<<<< HEAD
CFI_OVERRIDE=	-fno-sanitize=cfi-icall

.PATH: ${MOUNT} ${UMNTALL}
=======
.PATH: ${UMNTALL}
>>>>>>> internal/freebsd/current/main

.include <bsd.prog.mk>
