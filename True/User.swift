//
//  User.swift
//  True
//
//  Created by Mario Garcia on 3/23/17.
//  Copyright © 2017 Mario Garcia. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

//structure of a user
struct User {
    var userName: String!
    var email: String!
    var phoneNumber: String!
    var photoURL: String!
    var uid: String!
    var ref: FIRDatabaseReference?
    var key: String?
    var firstAndLastName: String!
    
    //an object declaration for user
    init(snapshot: FIRDataSnapshot){
        userName = (snapshot.value! as! NSDictionary)["userName"] as! String
        email = (snapshot.value! as! NSDictionary)["email"] as! String
        phoneNumber = (snapshot.value! as! NSDictionary)["phoneNumber"] as! String
        uid = (snapshot.value! as! NSDictionary)["uid"] as! String
        photoURL = (snapshot.value! as! NSDictionary)["photoURL"] as! String
        firstAndLastName = (snapshot.value! as! NSDictionary)["firstAndLastName"] as! String
        
    }
    
}
