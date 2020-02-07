# ELVISH-TODO: Run faster.
#
# 3.go:     2.0ms
# 3.elv:    5.0s
# Slowdown: 2500

use math

fn get-segs [s]{
  x y = 0 0
  vsegs hsegs = [] []
  splits , $s | each [t]{
    dir len = $t[0 1:]
    if (eq $dir L) {
      @hsegs = $@hsegs [&y=$y &x1=(- $x $len) &x2=$x]
      x = (- $x $len)
    } elif (eq $dir R) {
      @hsegs = $@hsegs [&y=$y &x1=$x &x2=(+ $x $len)]
      x = (+ $x $len)
    } elif (eq $dir U) {
      @vsegs = $@vsegs [&x=$x &y1=(- $y $len) &y2=$y]
      y = (- $y $len)
    } elif (eq $dir D) {
      @vsegs = $@vsegs [&x=$x &y1=$y &y2=(+ $y $len)]
      y = (+ $y $len)
    }
  }
  put $vsegs $hsegs
}

fn intersect [v h]{
  if (and (<= $h[x1] $v[x] $h[x2]) (<= $v[y1] $h[y] $v[y2])) {
    put [&x=$v[x] &y=$h[y]]
  }
}

fn manhattan [p]{
  + (math:abs $p[x]) (math:abs $p[y])
}

# ELVISH-TODO: This should be built-in.
fn min [a b]{
  if (< $a $b) {
    put $a
  } else {
    put $b
  }
}

line1 line2 = (take 2)
vsegs1 hsegs1 = (get-segs $line1)
vsegs2 hsegs2 = (get-segs $line2)
res = +Inf
{
  for v $vsegs1 { for h $hsegs2 { intersect $v $h } }
  for v $vsegs2 { for h $hsegs1 { intersect $v $h } }
} | each [p]{
  res = (min $res (manhattan $p))
}
echo $res
