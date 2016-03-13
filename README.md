# Dictionify

[![CI Status](http://img.shields.io/travis/matthewlui/Dictionify.svg?style=flat)](https://travis-ci.org/matthewlui/Dictionify)
[![Version](https://img.shields.io/cocoapods/v/Dictionify.svg?style=flat)](http://cocoapods.org/pods/Dictionify)
[![License](https://img.shields.io/cocoapods/l/Dictionify.svg?style=flat)](http://cocoapods.org/pods/Dictionify)
[![Platform](https://img.shields.io/cocoapods/p/Dictionify.svg?style=flat)](http://cocoapods.org/pods/Dictionify)

Dictionify want to solve the needs of convert objects to dictionary with simple step.
By using Dictionify, you don't have to write boring code for each class like

    dictionary["myPropertyA"] = self.myPropertyA
    dictionary["myPropertyB"] = self.myPropertyB
    . . .
(or by overriding decode/encode(withCoder))

When you subclass Dictionify, and tag your property with "dynamic", you gain the power of calling toDictionary() to get your dictionary that contain all properties in your class.
Also, we allow you to init a object with dictionary. Even more, Dictionify can recorgnize properties in dictionary those are also Dictionify subclass(Included in an Array),instantiate them and put right back in. For example:
```swift
    class Person :Dictionify {
        dynamic var name :String
        dynamic var likedBook :[Book]
        init(name:String){
            self.name = name
            likedBook = []
        }
    }
    class Book :Dictionify{
        dynamic var name :String
        dynamic var content :String
    }
    var ben = Person(name:Ben)
    var book = Book("I love",content:"Bla Bla Bla...")
    ben.likedBook = [book]
    var benDict = ben.toDictionary()
    var anotherBen = Person(benDict)
    var anotherBook = anotherBen.likedBook.first
```
## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements
iOS 9.0

## Installation

Dictionify is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "Dictionify"
```

## Author

matthewlui, matthewluihk@gmail.com

## License

Dictionify is available under the MIT license. See the LICENSE file for more info.
