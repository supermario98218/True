//
//  Authentication.swift
//  True
//
//  Created by Mario Garcia on 3/23/17.
//  Copyright © 2017 Mario Garcia. All rights reserved.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

struct Authentication {
    // connection to firebase database and storage base
    var dataBaseRef: FIRDatabaseReference! {
        return FIRDatabase.database().reference()
    }
    
    var storageRef: FIRStorageReference! {
        return FIRStorage.storage().reference()
    }
    
    
    //signs user up
    func signUp (firstAndLastName: String, userName: String, email: String, phoneNumber: String, password: String, pictureData: NSData!) {
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                self.setUserInfo(firstAndLastName:firstAndLastName, user: user, userName: userName, phoneNumber: phoneNumber, password: password, pictureData: pictureData)
            }
            else {
                print(error!.localizedDescription)
                let alertView = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
            }
        })
    }
    
    // saves user photo to a refrence link and starts creating the user
    private func setUserInfo(firstAndLastName: String, user: FIRUser!, userName: String, phoneNumber: String, password: String, pictureData: NSData!){
        let imagePath = "profileImage\(user.uid)/userPic.jpg"
        
        let imageRef = storageRef.child(imagePath)
        
        let metaData = FIRStorageMetadata()
        metaData.contentType = "image/jpeg"
        
        imageRef.put(pictureData as Data, metadata: metaData) { (newMetaData, error) in
            
            if error == nil {
                
                let changeRequest = user.profileChangeRequest()
                changeRequest.displayName = userName
                
                if let photoURL = newMetaData!.downloadURL() {
                    changeRequest.photoURL = photoURL
                }
                
                changeRequest.commitChanges(completion: { (error) in
                    if error == nil {
                        
                        self.saveUserInfo(firstAndLastName:firstAndLastName, user: user, userName: userName, phoneNumber: phoneNumber, password: password)
                    }
                    else{
                        print(error!.localizedDescription)
                    }
                })
                
            }
            else {
                print(error!.localizedDescription)
            }
        }
    }
    
    //  saves user info into a database into the json file names as "users"
    private func saveUserInfo(firstAndLastName: String, user: FIRUser!, userName: String, phoneNumber: String, password: String){
        let userInfo = ["firstAndLastName": firstAndLastName, "email": user.email!, "userName": userName, "phoneNumber": phoneNumber,"uid": user.uid, "photoURL": String(describing: user.photoURL!)]
        
        let userRef = dataBaseRef.child("users").child(user.uid)
        
        userRef.setValue(userInfo) { (error, ref) in
            if error == nil {
                print("User info saved successfully")
                self.logIn(email: user.email!, password: password)
            }else {
                print(error!.localizedDescription)
                
            }
        }
        
    }
    
    // logs in users to the firebase server  or else throws error
    func logIn(email: String, password: String){
        
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            if error == nil {
                if let user = user {
                    
                    print("\(user.displayName!) has logged in successfully")
                    
                    let appDel : AppDelegate = UIApplication.shared.delegate as! AppDelegate
                    appDel.logUser()
                }
            }
            else {
                print(error!.localizedDescription)
                let alertView = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                alertView.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                UIApplication.shared.keyWindow?.rootViewController?.present(alertView, animated: true, completion: nil)
            }
        })
        
    }
    private func presentViewController(alert: UIAlertController, animated flag: Bool, completion: (() -> Void)?) -> Void {
        UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: flag, completion: completion)
    }
}
