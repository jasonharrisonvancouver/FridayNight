//
//  ViewController.swift
//  FridayNight
//
//  Created by jason harrison on 2019-02-09.
//  Copyright © 2019 jason harrison. All rights reserved.
//

import UIKit
import FacebookLogin
import Firebase
import FBSDKCoreKit



class ViewController: UIViewController, LoginButtonDelegate {

    var ref: DatabaseReference!

    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var firebaseUsernameText: UITextField!
    @IBOutlet weak var usernameButton: UIButton!
    
    
    
    
    @IBAction func updateUsernameButtonPressed(_ sender: UIButton) {
       /* let saveAction = UIAlertAction(title: "Save",
                                       style: .default) { _ in
                                        // 1
                                        guard let textField = alert.textFields?.first,
                                            let text = textField.text else { return }
                                        
                                        // 2
                                        let groceryItem = GroceryItem(name: text,
                                                                      addedByUser: self.user.email,
                                                                      completed: false)
                                        // 3
                                        let groceryItemRef = self.ref.child(text.lowercased())
                                        
                                        // 4
                                        groceryItemRef.setValue(groceryItem.toAnyObject())
        }*/
        
        
        
        let activityUsersRef = self.ref//.child('activityusers');
        // imagesRef now points to 'images'
        
        // Child references can also take paths delimited by '/'
        let activityUserFirstName = usernameText!.text!
        let activityUserRef = activityUsersRef!.child("activityusers/\(String(describing: activityUserFirstName))")
        let activityUser = ActivityUser(firstName: usernameText.text!)

        activityUserRef.setValue(activityUser.toAnyObject())
        /*
        let activityUser = ActivityUser(firstName: usernameText.text!)
        let userDbRef = self.ref.child(usernameText.text!)
        userDbRef.setValue(activityUser.toAnyObject())
        */
        
        
        
        print("uid is ");
        print(Auth.auth().currentUser?.uid as Any)
        
        Database.database().reference().child("activityUser").observe(.childChanged) { (snapshot, key) in
            self.firebaseUsernameText.text = key
           // print(key)
            //"-L7EFPICxdWQcrLOEUkM"
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let lb = LoginButton(readPermissions: [ .email, .publicProfile ])
        lb.center = view.center
        lb.delegate = self
        view.addSubview(lb)
        
        
        ref = Database.database().reference()
        //let ref = Database.database().reference(withPath: "grocery-items")

    }

    
    
    /**
     Called when the button was used to logout.
     
     - parameter loginButton: Button that was used to logout.
     */
    public func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("user wants to log out from ")
        print(Auth.auth().currentUser?.email as Any)
    }
    
    /**
     Called when the button was used to login and the process finished.
     
     - parameter loginButton: Button that was used to login.
     - parameter result:      The result of the login.
     */
    public func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        switch result {
        case .failed(let error):
            print("Error \(error)")
            break
        case .success(let grantedPermissions, let declinedPermissions, let accessToken):
            loginFireBase()
            break
        default: break
            
        }
        
    }
    
    /**
     Login to Firebase after FB Login is successful
     */
    func loginFireBase() {
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
      //  Auth.auth().signIn(with: credential) { (user, error) in
            // ...
            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
            if let error = error {
                print(error)
                return
            }
                
                print("logged in via facebook as: ");
            print(authResult?.user.displayName! as Any)
                // https://firebase.google.com/docs/auth/ios/manage-users#get_the_currently_signed-in_user
        }
    }
}

//    Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//    if let error = error {
//    // ...
//    return
//    }
//    // User is signed in
//    // ...
//}
