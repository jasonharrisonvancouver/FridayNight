//
//  User.swift
//  
//
//  Created by jason harrison on 2019-02-10.
//

import Foundation

class ActivityUser{
    var firstName: String
    
    init(firstName: String){
        self.firstName = firstName
    }
    
    
    func toAnyObject() -> Any {
        return [
            "firstname": firstName//,
            /*"addedByUser": addedByUser,
            "completed": completed*/
        ]
    }
}
