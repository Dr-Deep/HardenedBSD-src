.PATH: ${SRCTOP}/sys/netpfil/ipfw/pmod

KMOD=   ipfw_pmod
SRCS=   ip_fw_pmod.c tcpmod.c opt_inet.h opt_inet6.h

TRIVIAL_VAR_AUTO_INIT_ZERO_SAFE=	yes

.include <bsd.kmod.mk>
