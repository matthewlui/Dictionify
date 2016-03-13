
import Foundation

public class Dictionify : NSObject {
    
    static var DictionifyClassNameKey = "DictionifyClass"
    
    public func toDictionary(withClassName flag:Bool) -> NSDictionary{
        var count :UInt32 = 0
        let list = class_copyPropertyList(object_getClass(self), &count)
        let dic = NSMutableDictionary()
        for i in 0..<Int(count){
            let propertyT = list.advancedBy(i).memory
            let name = getPropertyNameString(propertyT)
            if let v = valueForKey(name) as? Dictionify {
                dic[name] = v.toDictionary(withClassName: flag)
            }else if let array = valueForKey(name) as? NSArray{
                let childDic = NSMutableDictionary()
                array.enumerate().forEach({ (i,obj) -> () in
                    if let obj = obj as? Dictionify {
                        childDic[String(i)] = obj.toDictionary(withClassName: flag)
                    }else{
                        childDic[String(i)] = obj
                    }
                })
                dic[name] = childDic
            }else{
                dic[name] = valueForKey(name)
            }
        }
        if flag {
            dic[Dictionify.DictionifyClassNameKey] = getStringFromPointer(object_getClassName(self))
        }
        return dic
    }
    
    public override init() {
        super.init()
    }
    
    public init(dictionary:NSDictionary){
        super.init()
        for (k,v) in dictionary{
            if k as! String == Dictionify.DictionifyClassNameKey {
                continue
            }
            if let v = v as? NSDictionary{
                if arrayDictionaryRepresent(v){
                    var array = Array<AnyObject>()
                    v.allValues.forEach({ (obj) -> () in
                        if let obj = obj as? NSDictionary {
                            array.append(instanceFromDictionary(obj))
                        }else{
                            array.append(obj)
                        }
                    })
                }else{
                    setValue(v, forKey: k as! String)
                }
                continue
            }
            setValue(v, forKey: k as! String)
        }
    }
}

public func instanceFromDictionary(dictionary:NSDictionary) -> AnyObject{
    if let className = dictionary[Dictionify.DictionifyClassNameKey] as? String,
        aClass = objc_getClass(className) as? AnyClass{
            let o = NSObject()
            object_setClass(o, aClass)
            let obj = o.self.dynamicType.init()
            object_setClass(o, NSObject.self)
            for (cK,cV) in dictionary {
                guard let cK = cK as? String else {
                    continue
                }
                if cK  == Dictionify.DictionifyClassNameKey {
                    continue
                }
                obj.setValue(cV, forKey: cK)
            }
            return obj
    }
    return dictionary
}

func arrayDictionaryRepresent(dictionary:NSDictionary) -> Bool {
    for k in dictionary.allKeys {
        if let k = k as? String {
            let index = Int(k)
            if index == nil {
                return false
            }
        }
    }
    return true
}

func getPropertyNameString(property:objc_property_t) -> String {
    let proName = property_getName(property)
    return getStringFromPointer(proName)
}

func getStringFromPointer(startPointer:UnsafePointer<Int8>) -> String {
    var i = 0
    var s = ""
    if let str = String.fromCString(startPointer) {
        return str
    }
    repeat {
        let n = startPointer.advancedBy(i).memory
        let s1 = String(UnicodeScalar(UInt8(n)))
        if s1 == "@" || s1 == " " || s1 == "" || s1 == "\n" || s1 == "\0" {
            return s[s.startIndex...s.endIndex.advancedBy(-1)]
        }else{
            s += s1
            i++
        }
    }while true
}
