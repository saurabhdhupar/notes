package main

import (
	"reflect"
	"fmt"
	"time"
)

var globalIntList []int

func listFlatten(inputList []interface{}) {
	fmt.Printf("[inputList %+v, intList %v]\n", inputList, globalIntList)
	for _, value := range inputList {
		fmt.Printf("[inputList %+v, value %+v intList %v]\n", inputList, value, globalIntList)
		if reflect.TypeOf(value).Kind() == reflect.Int {
			value, _ := value.(int)
			globalIntList = append(globalIntList, value)
		} else {
			if value2, ok := value.([]interface{}); ok {
				listFlatten(value2)
			} else if value2, ok := value.([]int); ok {
				globalIntList = append(globalIntList, value2...)
			}
		}
	}
}

func main() {
	//inputList := []interface{}{2, 1, []interface{}{3, []int{4, 5}, 6}, 7, []int{8}}
	//listFlatten(inputList)
	//fmt.Printf("last intList is %v\n", globalIntList)

	c := time.NewTimer(15 * time.Second)



	fmt.Printf("%+v\n", c)
	fmt.Printf("%+v\n", c)
}
