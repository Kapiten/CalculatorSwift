//
//  UserDefaults.swift
//  CalculatorSwift
//
//  Created by Admin on 2024/03/01.
//

import Foundation

class UserDefault: UserDefaults {
    
    func saveExpression(_ value:String) {
        var arr = getExpressions()
        arr?.append(value)
        setValue(arr, forKey: Constants.PREF_EXPRESSION)
    }
    
    func saveAll(_ value:Array<String>) {
//        if(!k.isEmpty && k.elementsEqual(Constants.PREF_EXPRESSION)) {
            setValue(value, forKey: Constants.PREF_EXPRESSION)
            
//        }
    }
    
    func getExpression(_ index:Int) -> String? {
        return stringArray(forKey: Constants.PREF_EXPRESSION)?[index]
    }
    
    func getExpressions() -> Array<String>? {
        let arr = stringArray(forKey: Constants.PREF_EXPRESSION)
        if(arr==nil){setValue(Array<String>(), forKey: Constants.PREF_EXPRESSION); return Array<String>();}
        return stringArray(forKey: Constants.PREF_EXPRESSION)
    }
    
    func removeDuplicates() {
        var arr = Array<String>()
        self.getExpressions()?.forEach({ (s) in
            if !arr.contains(s) {arr.append(s)}
        })
        self.saveAll(arr)
    }
}
