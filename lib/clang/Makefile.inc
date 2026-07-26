.include <src.opts.mk>

<<<<<<< HEAD
PACKAGE=	clang
=======
PACKAGE?=	clang
MK_PIE:=	no	# Explicit libXXX.a references
>>>>>>> rad/freebsd/15-stable/main

.if ${MK_LLVM_FULL_DEBUGINFO} == "no"
.if ${COMPILER_TYPE} == "clang"
DEBUG_FILES_CFLAGS= -gline-tables-only
.else
DEBUG_FILES_CFLAGS= -g1
.endif
.endif

WARNS?=		0
