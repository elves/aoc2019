use math
fn fuel [x]{
  while $true {
    x = (- (math:floor (/ $x 3)) 2)
    if (> $x 0) {
      put $x
    } else {
      break
    }
  }
}
each $fuel~ | + (all)
