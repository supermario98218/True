//
//  Hall.swift
//  True
//
//  Created by Mario Garcia on 3/24/17.
//  Copyright © 2017 Mario Garcia. All rights reserved.
//

import Foundation
import Firebase
import FirebaseDatabase

//basic structure of hall and what we recieve from firebase
struct Hall{
    
    var name: String!
    var address: String!
    var latitude: Double!
    var longitude: Double!
    var capacity: Int!
    var hours: String
    var totalInToday: Int!
    var time: Int!
    var seatsAvailable: Int!
    var key: String!
    init(snapshot: FIRDataSnapshot) {
        
        name = (snapshot.value as! NSDictionary)["name"] as! String
        address = (snapshot.value! as! NSDictionary)["address"] as! String
        latitude = (snapshot.value! as! NSDictionary)["latitude"] as! Double
        longitude = (snapshot.value! as! NSDictionary)["longitude"] as! Double
        capacity = (snapshot.value! as! NSDictionary)["capacity"] as! Int
        hours = (snapshot.value! as! NSDictionary)["hours"] as! String
        totalInToday = (snapshot.value as! NSDictionary)["totalInToday"] as! Int
        time = (snapshot.value as! NSDictionary)["time"] as! Int
        seatsAvailable = (snapshot.value as! NSDictionary)["seatsAvailable"] as! Int
        
    }
//
//    init(snapshot: FIRDataSnapshot){
//        
//        key = snapshot.key
//        //name = "Boltonnnn"//hardcodes
//        let snapshotValue = snapshot.value as! [String: AnyObject]
//        name = snapshotValue["name"] as? String
//        print(name)
//        address = snapshotValue["address"] as? String
//        latitude = snapshotValue["latitude"] as? Double
//        longitude = snapshotValue["longitude"] as? Double
//        capacity = snapshotValue["capactiy"] as? Int
//        hours = (snapshotValue["hours"] as? String)!
//        totalInToday = snapshotValue["totalInToday"] as? Int
//        time = snapshotValue["time"] as? Int
//        seatsAvailable = snapshotValue["seatsAvailable"] as? Int
//        
//    
//    }
    
    
    init(name: String, address: String, latitude: Double, longitude: Double, max: Int, hour: String, tiempo: Int, totalToday: Int, seatsAv: Int) {
        self.name = name
        self.address = address
        self.latitude = latitude
        self.longitude = longitude
        self.capacity = max
        self.hours = hour
        self.time = tiempo
        self.totalInToday = totalToday
        self.seatsAvailable = seatsAv
    }
    
}

