# ELVISH-TODO: Run faster.
#
# 2-2.go:   10.2ms
# 2-2.elv:  38.7s
# Slowdown: 3794x

fn run [program a b]{
  program[1] = $a
  program[2] = $b
  pc = 0
  while (has-key $program $pc) {
    op src1 src2 dst = $program[(range $pc (+ 4 $pc))]
    pc = (+ $pc 4)
    if (== $op 1) {
      program[$dst] = (+ $program[$src1] $program[$src2])
    } elif (== $op 2) {
      program[$dst] = (* $program[$src1] $program[$src2])
    } else {
      break
    }
  }
  put $program[0]
}

# ELVISH-TODO: Support breaking from nested loops.
fn solve [program]{
  for a [(range 100)] {
    for b [(range 100)] {
      if (== (run $program $a $b) 19690720) {
        put (+ (* 100 $a) $b)
        return
      }
    }
  }
}

@program = (splits , (one))
solve $program
