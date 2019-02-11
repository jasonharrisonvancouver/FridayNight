//
//  User.swift
//  
//
//  Created by jason harrison on 2019-02-10.
//

import Foundation

class ActivityUser{
//    var uid: String?
    var firstName: String
    var email: String
//    var phone: String?
//    var ratings: [String]?
//    var photoURL: String
//
    // https://firebase.google.com/docs/auth/ios/manage-users#get_the_currently_signed-in_user
    
    init(firstName: String, email: String){//, photoURL: String){
        self.firstName = firstName
        self.email = email
//        self.photoURL = photoURL
//        //self.uid =
    }
    
    
    func toAnyObject() -> Any {
        return [
            "firstname": firstName,
            "email":email
            /*"addedByUser": addedByUser,
            "completed": completed*/
        ]
    }
}
