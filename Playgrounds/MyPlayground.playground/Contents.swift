//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"

str = "Goodbye"


//explicitly define the var type using :String
var name:String = "test"

name = "test2"


var int = 4

3*int

var a:Int = 5
var b = a * 3

var c:Float = 5 / 2

var d:Double = 5/2

//convert int to float type before multiplying
c * Float(int)

var long = name + " " + "continued"

//for converting other types to strings
var long2 = "A \(a)"

var array = [1, 2, 3, 4, 5]


array[2]

array.append(6)

array.removeLast()
println(array)
array.removeRange(2...3)
println(array)

var newArray = [ 1, 3.3, "tom"]

// only ints in this array
var emptyArray:[Int]

var dict = ["name": "Rob", "age":34, "gender": "male"]

// use ! to override possibility there might not be a name
println(dict["name"]!)

// this is allowed type changes ok
dict["age"] = "old"

dict["haircolor"] = "black"

// two ways
var m = dict["name"]!
var myString = "my name is \(m)"

var arr = [2,4,6,8]
arr.removeAtIndex(0)
arr.append(10)


/////////////////////////////if statements

var my = "bob"
var time = 9
if my == "bob" && time < 10{
    println("hello")
}
else if time > 5 {
    println("yaef")
}
else {
    println("who are you")
}

//same for || 

var t = 10%2

//for random vars
//rand number is either 0 or 1
var random = arc4random_uniform(2)

////////////////loops

for var i = 0 ; i < 10 ; i += 2{
    println("hello")
}

var array1 = [6 ,3, 8, 1]

for x in array1 {
    println(x)
}

for (index , x) in enumerate(array1) {
    println(index)
    array1[index] = 2
}

println(array1)

var i = 1
while i < 15 {
    println(i)
    i++
}
//while has no shortcut like for loop for dealing with arrays
// so must deal with like in java or c

println(array1.count)


























