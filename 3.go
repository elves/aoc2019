package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
)

type Point struct{ x, y int }
type VSeg struct{ x, y1, y2 int }
type HSeg struct{ y, x1, x2 int }

func main() {
	r := bufio.NewReader(os.Stdin)
	getLine := func() string {
		line, err := r.ReadString('\n')
		if err != nil {
			panic(err)
		}
		return strings.TrimRight(line, "\n")
	}
	res := -1
	vsegs1, hsegs1 := getSegs(getLine())
	vsegs2, hsegs2 := getSegs(getLine())
	for _, v := range vsegs1 {
		for _, h := range hsegs2 {
			p, ok := intersect(v, h)
			if ok {
				fmt.Println(p)
			}
			if ok && (res == -1 || res > manhattan(p)) {
				res = manhattan(p)
				fmt.Println("  ", res)
			}
		}
	}
	for _, v := range vsegs2 {
		for _, h := range hsegs1 {
			p, ok := intersect(v, h)
			if ok {
				fmt.Println(p)
			}
			if ok && (res == -1 || res > manhattan(p)) {
				res = manhattan(p)
				fmt.Println("  ", res)
			}
		}
	}
	fmt.Println(res)
}

func getSegs(s string) ([]VSeg, []HSeg) {
	x, y := 0, 0
	vsegs := []VSeg{}
	hsegs := []HSeg{}
	for _, t := range strings.Split(s, ",") {
		dir := t[0]
		length, err := strconv.Atoi(t[1:])
		if err != nil {
			panic(err)
		}
		switch dir {
		case 'L':
			hsegs = append(hsegs, HSeg{y, x - length, x})
			x -= length
		case 'R':
			hsegs = append(hsegs, HSeg{y, x, x + length})
			x += length
		case 'U':
			vsegs = append(vsegs, VSeg{x, y - length, y})
			y -= length
		case 'D':
			vsegs = append(vsegs, VSeg{x, y, y + length})
			y += length
		}
	}
	return vsegs, hsegs
}

func intersect(v VSeg, h HSeg) (Point, bool) {
	return Point{v.x, h.y}, h.x1 <= v.x && v.x <= h.x2 && v.y1 <= h.y && h.y <= v.y2
}

func manhattan(p Point) int {
	return abs(p.x) + abs(p.y)
}

func abs(i int) int {
	if i < 0 {
		return -i
	}
	return i
}
