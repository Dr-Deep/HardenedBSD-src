#!/usr/bin/env -S /usr/sbin/dtrace -C -s
/*
 * dtrace -s ./dlearn.d -c ncal
 * TODO consider -q to produce parseable output
 */

/* we want temporal ordering of trace in order to determine
 * temporal ordering of pledge flags: */
#pragma D option temporal

/*

// /pid == $target || progenyof($target)/

// https://wiki.freebsd.org/DTrace/One-Liners
// only trace from jail:
// # pragma D option zone=dhcpd

// dwatch -R ...   // show parents of execs
// see 'pproc' in dwatch script
// basically curthread->td_proc->p_pptr

// http://dtrace.org/blogs/dap/2013/11/20/understanding-dtrace-ustack-helpers/

// dwatch -j myjail ....

// stack(stackdepth)
*/

BEGIN
{
	calls = 0ULL;
}

/*
 * pledge:kern:kern_pledge:masks
 *   pid, 0, 0, possessed, new mask
 */
pledge:kern:kern_pledge:masks
/ pid == $target || progenyof($target) /
{
	printf("%s pid:%i pos:%#lx new:%l#x", probefunc,
		   arg0, arg3, arg4
	);
	trace("aaa");
	ustack(50);
	trace("ccc");
}

/* trace pledge() application */
/****************** consider -Z to enable tracing when target is not
***** built with libpledge
pid$target::pledge_string:entry
{
  self->pledge_str = arg0;
}

pid$target::pledge_string:return
{
  printf("pledge_string(\"%s\") == %ull;", copyinstr(self->pledge_str), arg0);
  self->pledge_str = 0;
  ustack(50);
}

pid$target::pledge:entry
{
  printf("pledge(%#lx);", arg1);
  ustack(50);
}
******************/



/* pledge:learning:insert:masks
 *   pid, fsid, inode, syscall no, possessed, violated, used
 */
pledge:learning:insert:masks
/ 1==0 && pid == $target || progenyof($target) /
{
	printf("%s pid:%i fsid:%#lx ino:%i sysno:%d cur:%#lx vio:%#lx used: %#lx progenyof:%d", probefunc,
	       arg0, arg1, arg2, arg3,
	       arg4, arg5, arg6, progenyof(pid));
	/* Userland backtrace for context: */
	ustack(50);
}

/*
END
{
	printf("calls %ull\n", calls);
}
*/

/* dtrace at boot: http://dtrace.org/guide/chp-anon.html#chp-anon */
