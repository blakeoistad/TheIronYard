//: Playground - noun: a place where people can play

import UIKit

// Dictionaries

var weekdays = ["1" : "Sunday", "2" : "Monday"]     //mutable due to var
print(weekdays.count)
weekdays["3"] = "Tuesday"
print(weekdays.count)
weekdays["2"] = "Money Monday"
print("day = " + weekdays["2"]!)
weekdays["5"] = "Thursday"
print(weekdays.count)

//using tuples, the first in the dictionary item happens to be the number, and the second happens to be the name
for (dayNum, dayName) in weekdays {
    print("Day \(dayNum): \(dayName)")
}




//Optionals

var restaurantName = "Shake Shack"
print(restaurantName)



enum MyError: ErrorType {
    case NameMissing
}

var inputNumber = "123"     //this is a string
Double(inputNumber)
var iNValue = Double(inputNumber)
print(iNValue)

var inputNumber2 = "A"      //also a string
Double(inputNumber2)        //double in this case becomes nil
var iN2Value = Double(inputNumber2)

//unwrap, take this thing that could be optional, unwrap it into goodValue, if it is, print it, otherwise be nil
if let goodValue = iN2Value {
    print(goodValue)
} else {
    print("Nil")
}

print(iN2Value)



////technically a void, no inputs or outputs, were going to make the possibility that the function may not evaluate validly
//func printBusinessName() {
//    var businessName = "The Iron Yard" as String?       //this holds business name "the iron yard" and we say as String? to allow the possibility of nil data
//    
//    print(businessName)
//    print(businessName!) //Don't Do This, disregards option for nil
//    print(businessName)  //this proves that only the ! momentarily unwraps the data, but disregards possibiity of nil data being contained
//    
////    businessName = nil
//    print(businessName)
//    
//    //how to properly unwrap, sort of
//    if let realBusinessName = businessName {
//        print(realBusinessName)
//    } else {
//        print("Business is nil")
//    }
//    
//}
//
//printBusinessName()                         //make sure to run the function

//technically a void, no inputs or outputs, were going to make the possibility that the function may not evaluate validly
func printBusinessName() throws {                       //if using guard method of unwrapping, you must add throws to the end of the function
    var businessName = "The Iron Yard" as String?       //this holds business name "the iron yard" and we say as String? to allow the possibility of nil data
    
    print(businessName)
    print(businessName!) //Unwrapping Method #1             Don't Do This, disregards option for nil
    print(businessName)  //this proves that only the ! momentarily unwraps the data, but disregards possibiity of nil data being contained
//    
//        businessName = nil                                  //DISABLE/REENABLE TO SEE RESULTS OF BELOW CATCH METHODS
    print(businessName)
    
    //Unwrapping Method #2                                  how to properly unwrap, sort of
    if let realBusinessName = businessName {
        print(realBusinessName)
    } else {
        print("Business is nil")
    }
    
    //Unwrapping Method #3                                  best method to unwrap
    guard let unwrappedBusinessName = businessName else {               //if unable to unwrap this, throw an error we call
        throw MyError.NameMissing
    }
    
    print(unwrappedBusinessName)
}

// printBusinessName()                         //make sure to run the function


// Try Catch Method #1                          //must use if using guard method
do {
    try printBusinessName()                     //this try is attached to throws, try to run the method, if you get an error, throw the error message
} catch MyError.NameMissing {
    print("catch name missing")
} catch {
    print("catch some other error")
}

// Try (No Catch) Method #2                     //this is a do catch without the catches, aka no error handling
try! printBusinessName()