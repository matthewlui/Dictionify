import UIKit
import XCTest
import Dictionify

class People : Dictionify {
    dynamic var name : String = "Hello staff"
}

class Stuff : Dictionify{
    
    dynamic var name : String? = "Matthew's toy"
    dynamic var nilV : AnyObject? = nil
    dynamic var owner : String = "Matthew"
    dynamic var borrowers : [People] = [People(),People(),{ let p = People() ; p.name = "heke"; return p}()]
    
}

class Tests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        XCTAssert(true, "Pass")
    }
    
    func testObjectDictionaryConvertion(){
        let obj = Stuff()
        obj.name = "Hello"
        obj.owner = "Yo"
        let dic = obj.toDictionary(withClassName: true)
        assert(dic["name"] as! String == "Hello", "wrong")
        assert(dic["owner"] as! String == "Yo", "wrong")
        print(dic["borrowers"])
        
        let objB = Stuff(dictionary: dic)
        print(objB.borrowers.map{$0.name})
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock() {
            // Put the code you want to measure the time of here.
        }
    }
    
}
