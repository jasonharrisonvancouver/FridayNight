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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let lb = LoginButton(readPermissions: [ .email, .publicProfile ])
        lb.center = view.center
        lb.delegate = self
        view.addSubview(lb)
    }

    
    
    /**
     Called when the button was used to logout.
     
     - parameter loginButton: Button that was used to logout.
     */
    public func loginButtonDidLogOut(_ loginButton: LoginButton) {
        
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
                
            print(authResult?.user.displayName! as Any)
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
