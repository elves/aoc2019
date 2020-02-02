# ELVISH-TODO: Run faster.

fn run [program a b]{
  program[1] = $a
  program[2] = $b
  pc = 0
  while (< $pc (count $program)) {
    op src1 src2 dst = $program[(range $pc (+ 4 $pc))]
    if (== $op 1) {
      program[$dst] = (+ $program[$src1] $program[$src2])
    } elif (== $op 2) {
      program[$dst] = (* $program[$src1] $program[$src2])
    } else {
      break
    }
    pc = (+ $pc 4)
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
