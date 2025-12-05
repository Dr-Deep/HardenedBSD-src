.PATH: ${ZFSTOP}/module/avl

PACKAGE=	zfs
LIB_PACKAGE=

LIB=	avl
LIBADD=	spl
SRCS=	avl.c
WARNS?=	3
CFLAGS+= -DIN_BASE
CFLAGS+= -I${ZFSTOP}/include
CFLAGS+= -I${ZFSTOP}/lib/libspl/include/
CFLAGS+= -I${ZFSTOP}/lib/libspl/include/os/freebsd
CFLAGS+= -I${SRCTOP}/sys
CFLAGS+= -include ${ZFSTOP}/include/os/freebsd/spl/sys/ccompile.h

CFI_OVERRIDE=	-fno-sanitize=cfi-icall

.include <bsd.lib.mk>
