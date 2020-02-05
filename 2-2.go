package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

func main() {
	r := bufio.NewReader(os.Stdin)
	line, err := r.ReadString('\n')
	if err != nil {
		panic(err)
	}
	codes := strings.Split(strings.TrimRight(line, "\n"), ",")
	program := make([]int, len(codes))
	for i, code := range codes {
		program[i], err = strconv.Atoi(code)
		if err != nil {
			panic(err)
		}
	}
	fmt.Println(solve(program))
}

func solve(program []int) int {
	for a := 0; a < 100; a++ {
		for b := 0; b < 100; b++ {
			p := make([]int, len(program))
			copy(p, program)
			if run(p, a, b) == 19690720 {
				return a*100 + b
			}
		}
	}
	return -1
}

func run(program []int, a, b int) int {
	program[1] = a
	program[2] = b
	pc := 0
	for pc < len(program) {
		op := program[pc]
		src1 := program[pc+1]
		src2 := program[pc+2]
		dst := program[pc+3]
		pc += 4
		switch op {
		case 1:
			program[dst] = program[src1] + program[src2]
		case 2:
			program[dst] = program[src1] * program[src2]
		default:
			return program[0]
		}
	}
	return program[0]
}
