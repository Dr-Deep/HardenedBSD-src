dtrace -n 'pledge_check_bitmap:entry { self->begin=timestamp} pledge_check_bitmap:return { @mit = quantize(timestamp - self->begin); self->begin = 0}'
