package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	reader := bufio.NewReader(os.Stdin)
	n := lastInt(reader)
	fmt.Println(n)
}

//==================================================================
// HELPERS
//==================================================================

func lastFloat(reader *bufio.Reader) float64 {
	num, err := strconv.ParseFloat(nextLine(reader), 64)
	if err != nil {
		log.Fatal(err)
	}
	return num
}

func lastInt(reader *bufio.Reader) int {
	num, err := strconv.Atoi(nextLine(reader))
	if err != nil {
		log.Fatal(err)
	}
	return num
}

func next(reader *bufio.Reader) string {
	token, err := reader.ReadString(' ')
	if err != nil {
		log.Fatal(err)
	}
	return token[:len(token)-1]
}

func nextFloat(reader *bufio.Reader) float64 {
	num, err := strconv.ParseFloat(next(reader), 64)
	if err != nil {
		log.Fatal(err)
	}
	return num
}

func nextInt(reader *bufio.Reader) int {
	num, err := strconv.Atoi(next(reader))
	if err != nil {
		log.Fatal(err)
	}
	return num
}

func nextLine(reader *bufio.Reader) string {
	line, err := reader.ReadString('\n')
	if err != nil {
		log.Fatal(err)
	}
	return line[:len(line)-1]
}

func nextList(reader *bufio.Reader, arr []int, n int) {
	for i := 0; i < n - 1; i++ {
		arr[i] = nextInt(reader)
	}
	arr[n - 1] = lastInt(reader)
}

type Tuple struct {
	Left int
	Right int
}

func nextTuple(reader *bufio.Reader) Tuple {
	return Tuple{ nextInt(reader), lastInt(reader) }
}
