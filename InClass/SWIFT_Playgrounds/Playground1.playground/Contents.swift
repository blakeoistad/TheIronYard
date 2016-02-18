//: Playground - noun: a place where people can play

import UIKit

// Let vs. Var

var myInt1 : Int = 1 as Int
var myInt2 = 2 as Int
var myInt3 = 3
// all the same, but where swift infers data type, you may in some cases want to specify "as Int" or whatever it may be

var myInt = 4
myInt += 5

let myIntX = 4
//following line wont work because let is constant where as var is mutable/variable
//myIntX += 5

var myInt4 = 4, myInt5 = 5, myInt6 = 6              //commas tell it the data type is the same for each variable
var myTest1 = "Testing"; var myTest2 = "Testing Again"  //strings separated by ; and include the var declaration

// Variable Types

let intMax = Int.max
let inMin = Int.min
let int8Max = Int8.max
let int16Max = Int16.max
let int32Max = Int32.max
let int64Max = Int64.max
// unassigned ints dont have negative number, so on updated xcode, this evaluates to double int65 max
let uintMax = UInt.max

let myInteger = 6 as Int8

let myDouble = 5.15151515151515151515151515

var myFloat = -6.23232323232323232 as Float

var absMyFloat = Float.abs(myFloat)
var absMyDouble = Double.abs(myDouble)

// Logging

print(absMyFloat)
print(absMyFloat, terminator: "")      //removes the line break that print automatically adds in there (/n)

print("1", "2", "3", "4", separator:", ", terminator: "")
print("We are \(myTest1)")
print(String(format: "%.5f", myDouble))             //to the fifth place to right of decimal of myDouble

// More Variable Types

let myPi = 3 + 0.14                     //this is a double
let myPaddedDouble = 0000123.123
let oneMillionDollars = 1_000_000
let areWeDoneYet = false

var myString = "Hello World"
//myString = 6.24

let three = 3
let pointOneFourOneFiveNine = 0.14159
// let pi = three + pointOneFourOneFiveNine             //because it infers 3 is an int, you cant add an int to a double
let pi = Double(three) + pointOneFourOneFiveNine

let threeX = 3 as Double
let piX = threeX + pointOneFourOneFiveNine

let intPi = Int(pi)

// Comments
// This is a comment lol
/* This is a 
multiline comment */
/* Though now you /* Can nest multiline comments */ */

// Tuples               sort of dictionaries, special for swift

let httpCode404 = (404, "Not Found")

print(httpCode404.0)
print(httpCode404.1)

let (statusCode, statusMessage) = httpCode404
print(statusCode)

let threeple = (404, "Not Found", "This is a question")

let httpCode200 = (code: 200, description:"Success")
print(httpCode200.description)
print(httpCode200.0)

let (x, y) = (1, 2)
var myRating = (10, "Awesome")
myRating = (1, "Horrible")

// Operators

var a = 5
var b = a + 3
var c = b - a
var d = c * 5
var e = Double(d) / 3.2         //d was predefined as an int where as were dividing by double, hence the declaration of double

var myMod = 9 % 4               //gives us the remainder of the division
var myDoubleMod = 8 % 2.5

var x1 = 1
x1++
print(x1)
++x1

x1 += 5
x1 -= 2
x1 /= 3
x1 *= 4
x1 %= 3

// Strings

let helloWorld = "Hello " + "World"
let helloRatedWorld = "Hello " + myRating.1 + " World"
let helloRatedWorld2 = "Hello \(myRating.1) World!"
print("Letters: \(helloRatedWorld2.characters.count)", terminator: "")
var helloName = "Hello "
helloName += "Tom!"

for character in helloName.characters {
    print(character)
}

let starting5Chars = helloRatedWorld2.substringToIndex(helloRatedWorld2.startIndex.advancedBy(5))
let ending6Chars = helloRatedWorld2.substringFromIndex(helloRatedWorld2.endIndex.advancedBy(-6))
let middle8Chars = helloRatedWorld2.substringWithRange(Range<String.Index>(start: helloRatedWorld2.startIndex.advancedBy(6), end: helloRatedWorld2.startIndex.advancedBy(14)))

let range = helloRatedWorld2.rangeOfString("Horrible")
var index: Int = helloRatedWorld2.startIndex.distanceTo(range!.startIndex)

// Conditionals

let quote = "To Be, or Not To Be"
let sameQuote = "To Be, or Not To Be"

if quote == sameQuote {
    print("2B is 2B")
}

let chap1 = "Chapter 1 The Beginning of All"
let chap2 = "Chapter 2 The Continuation of All"
let prefix = chap1.hasPrefix("Chapter") ? "Chap Prefix" : "No Prefix"
let suffix = chap2.hasSuffix("of All") ? "Has Suffix" : "No Suffix"

if a == 5 {
    print("Got 5")
} else {
    print("No 5")
}

a == 5 ? "Got 5" : "No 5"       //this is the same as above, awesome
a != 6 ? "Not 6" : "Is 6"
a > 5 ? "Greater than 5" : "Not Greater than 5"
a >= 5 ? "Greater than or equal to 5" : "Not Greater than or equal to 5"

if a == 5 && !areWeDoneYet {
    print("Moving on...")
}

if a > 5 || !areWeDoneYet {
    print("Still moving on")
}

switch a {
case 1:
    print("got 1")
case 2:
    print("got 2")
case 3, 4, 5:
    print("got 3, 4, 5", terminator: "")
case 6...10:
    print("got 6...10")
default:
    print("default")
}

let furniture = "Chair"
switch furniture {
case "Table":
    print("Got table")
case "Chair", "Stool", "Bench":
    print("Got something to sit on")
default:
    print("Got something else")
}

let tickTacToeSquare = (1,1)
switch tickTacToeSquare {
case (0,0):
    print("Upper Left")
case (0,1):
    print("Upper Middle")
case (0,2):
    print("Upper Right")
case (1, _):                                // _ in this case means anything, almost like id, doestn matter what it is
    print("Middle Row")
case (1,1):                                 // because the above case was true, the switch stops there and doesnt continue to this next true statement
    print("Middle Cell")
default:
    print("Other")
}

// Arrays

let colorArray : [String] = ["Red", "Yello", "Green"] as [String]               //tells it this will be an array of string values, if you remove the string declaration, you can add in ints or other data types, saying "as string" here is being redundant by the way
var nameArray = ["Tom", "Mary", "Su", "Dana"]
nameArray.append("James")

var spiceArray = ["Salt", "Cayenne"]
spiceArray.append("Oregano")

var groceryArray = [String]()                               // we have alloc inited an empty array
groceryArray.append("Bread")
groceryArray += ["Milk"]                                    // these two are the same (above)
print(groceryArray[1])
groceryArray[1] = "Butter"                                  // replaced an item in the array
print(groceryArray)
groceryArray += ["Flour", "Sugar", "Baking Powder"]
groceryArray += spiceArray
print(groceryArray.count)
print(groceryArray.count + spiceArray.count)
groceryArray[2...4] = ["Eggs", "Chocolate", "Pretzels"]
print(groceryArray)
groceryArray.insert("Tortillas", atIndex: 3)
groceryArray.removeAtIndex(1)
groceryArray.first
groceryArray.last
print(groceryArray.joinWithSeparator(", "), terminator: "")

// Loops

for var index = 0; index < 3; ++index {
    print("Index is \(index)")
}

for myIndex in 0...5 {
    print("Index is \(myIndex)")
}

for myIndex in 0..<5 {
    print("Index is \(myIndex)")
}

for myIndex in 0..<groceryArray.count {
    print("Index is \(myIndex): \(groceryArray[myIndex])")
}

for groceryItem in groceryArray {
    print("Name: \(groceryItem)")
}

// Functions & Methods

func printSomething() {            //create
    print("Something")
}
printSomething()                    //run

func printHelloTo(name: String) {
    print("Hello \(name)")
}
printHelloTo("Blake")

func printTwoHellosTo(name1: String, name2: String) {
    print("Hello \(name1) and \(name2)")
}
printTwoHellosTo("Mom", name2: "Dad")

func createHelloMessageTo(name: String) -> String {                 // -> syntax for "return"
    return "Hello \(name)"
}

let helloMessage2 = createHelloMessageTo("Blake")

func squareAndCube(value: Int) -> (square: Int, cube: Int) {
    let squared = value * value
    let cubed = value * value * value
    return (squared, cubed)
}
let results = squareAndCube(3)
let (square, cubed) = squareAndCube(4)
print(square)

