#!/usr/bin/env -S awk -f
# ./dlearn.d -o yo.trace -c 'look azyme'
# awk -f parselearn.awk < yo.trace >dotty.dot
# dot dotty.dot -Tpng > yo.png

BEGIN {
    collapse_libc=0;
}

/insert pid/ {
    point++;
    # if the process forks the layout changes, TODO
    # figure out how to get dtrace to give us something
    # consistent here:
    if ($12 ~ /[0-9]/) {
	used_mask = $12;
    } else {
	used_mask = $9;
    }
    # inherit parent's least privileges, in the end used_temporal[-1]
    # should be the starting requirements for the process:
    used_temporal[point] = used_mask;
    funcidx[point] =0;
    next
}

/^CPU/ { next }
/YYY/ { next }
/:END/ { next }

/`/ {
    points[point, funcidx[point]] = $1;
    used[$1] = or(used_mask, used[$1]);
    previous_func = points[point, funcidx[point]-1]
    used_trans[previous_func, $1] = or(used_mask, used_trans[previous_func, $1])
    funcidx[point]++;
    next
}
    // or($12, used[$1])

{ next }
END {
    initial_learned_mask = 0;
    for (p = point; p ; p--) {
	min_hereafter[p] = or(min_hereafter[p+1], used_temporal[p]);
	printf("# %d: ", p); print(min_hereafter[p]);
    }
    print "digraph G {\n";
    print "node [shape=box];"
    for(p = 1; p <= point ; p++) {
	initial_learned_mask = or(initial_learned_mask, used_temporal[p]);
	first_in_chain = 1;
	for(; funcidx[p]-- ;) {
	    if (collapse_libc && points[p, funcidx[p]] ~ /^libc\.so/) {
		name = "libc";
	    } else {
		name = points[p, funcidx[p]];
	    }
	    if (points[p,funcidx[p]+1]) {
		printf " -> \"%s\"", name
		last = or(used[points[p,funcidx[p]+1]], min_hereafter[p]);
		this = or(used[points[p,funcidx[p]]], min_hereafter[p+1]);
		if (first_in_chain && used[funcidx[p+1]] <= min_hereafter[p+1]) {
		    printf " [label=\"%s\\n%d/%d pledge(%d->%d)\"]", name, used_temporal[p], p, min_hereafter[p+1], min_hereafter[p];
		    first_in_chain = 0;
		} else {
		    printf " [label=\"%d//%d/%d:%d==%d,%d\"]", or(used_temporal[p], used[points[p,funcidx[p]]], min_hereafter[p]), or(used_trans[points[p,funcidx[p]-1],points[p,funcidx[p]]], min_hereafter[p], used[points[p,funcidx[p]]]), p, funcidx[p], last, this
		}
	    } else {
		printf "\"%s\"", name;
	    }
	    if ((! funcidx[p]-1) && (min_hereafter[p] < min_hereafter[p-1])) {
		printf "; \"%s\"", name
		printf " [fillcolor=\"yellow\",style=filled]"
	    }
	    if (name == "libc") { break; }
	    printf "; \"%s\"", name
	}
	printf ";\n"
    }
    print "}\n";
    printf("# initial mask needed: "); print(initial_learned_mask);
}
# sysno == 1 && used = 0 -> we're calling exit(), silly to pledge() after that.
#
