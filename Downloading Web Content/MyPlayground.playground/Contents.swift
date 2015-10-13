//: Playground - noun: a place where people can play

import UIKit

var str = "Hello"

//combining two strings

var nstring = str + " Rob"

for characters in nstring{
    println(characters)
}

var newTypeString = NSString(string: nstring)


newTypeString.substringToIndex(5)

newTypeString.substringFromIndex(6)

newTypeString.substringWithRange(NSRange(location: 5, length: 3))

if newTypeString.containsString("Rob")
{
    println("yes")
}

newTypeString.componentsSeparatedByString(" ")

newTypeString.uppercaseString

newTypeString.lowercaseString
