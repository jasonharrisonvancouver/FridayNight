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
import CoreLocation



class FacebookLoginViewController: UIViewController, LoginButtonDelegate, CLLocationManagerDelegate{
    
    var ref: DatabaseReference!
    var locationManager = CLLocationManager()
    
    
    @IBOutlet weak var usernameText: UITextField!
    @IBOutlet weak var firebaseUsernameText: UITextField!
    @IBOutlet weak var usernameButton: UIButton!
    
    @IBOutlet weak var emailText: UITextField!
    
    
    
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
        
        
        // emails have dots, but dots aren't allowed as firebase keys; swap with commas:
        let cleanEmail = (emailText.text)!.sha256()
        
        // Child references can also take paths delimited by '/'
       // let activityUserFirstName = usernameText!.text!
        let activityUserRef = activityUsersRef!.child("activityusers/\(String(describing: cleanEmail))")
        let activityUser = ActivityUser(firstName: usernameText.text!, email: emailText.text!)
        
       // let activityUser = ActivityUser(firstName: usernameText.text, email: Auth(), photoURL: <#T##String#>)
        
        /*
 Edit: a Firebase query for email in ObjC:
 
 //references all of the users ordered by email
 FQuery *allUsers = [myUsersRef queryOrderedByChild:@"email"];
 
 //ref the user with this email
 FQuery *thisSpecificUser = [allUsers queryEqualToValue:@“john@somecompany.com”];
 
 //load the user with this email
 [thisSpecificUser observeEventType:FEventTypeChildAdded withBlock:^(FDataSnapshot *snapshot) {
 //do something with this user
 }];*/
        
        
        activityUserRef.setValue(activityUser.toAnyObject())
        /*
         let activityUser = ActivityUser(firstName: usernameText.text!)
         let userDbRef = self.ref.child(usernameText.text!)
         userDbRef.setValue(activityUser.toAnyObject())
         */
        
        self.ref.child("activityusers").observe(.childChanged, with: { (snapshot) in
            //Determine if coordinate has changed
            print("CHANGED")
            print(snapshot.key)
            print("clean email is \(cleanEmail)")
            if(snapshot.key == cleanEmail){
                let v = snapshot.value as! [String: String]
                print(v["firstname"] as Any)
                
                
                
                self.firebaseUsernameText.text = v["firstname"] as? String
                
                
                
                
                
                print("the new data changed")
                print(snapshot.value as Any)
                if let emailAddress = snapshot.value as? String {
                    print(emailAddress)
                }
            }
        })
        
        
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
        
        // https://firebase.google.com/docs/database/security/quickstart?authuser=0
        
        ref = Database.database().reference()
        //let ref = Database.database().reference(withPath: "grocery-items")
        print("son logged in as ")
        print(Auth.auth().currentUser?.email!)
        
        if(Auth.auth().currentUser == nil){
            print("NIL nil nillll")
        }else{
            self.emailText.text = Auth.auth().currentUser?.email
            self.usernameText.text = Auth.auth().currentUser?.displayName
            
            performSegue(withIdentifier: "loggedInSoBrowse", sender: self)

        }
        
        // get user's current location
        if CLLocationManager.locationServicesEnabled() == true {
            
            if CLLocationManager.authorizationStatus() == .restricted || CLLocationManager.authorizationStatus() == .denied ||  CLLocationManager.authorizationStatus() == .notDetermined {
                locationManager.requestWhenInUseAuthorization()
            }
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        } else {
            print("PLease turn on location services or GPS")
        }
    }
    
    
    
    //MARK:- CLLocationManager Delegates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.locationManager.stopUpdatingLocation()
        
        print("found you")
        print("lat:")
        print(locations[0].coordinate.latitude)
        print("long:")
        print(locations[0].coordinate.longitude)
       // let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: locations[0].coordinate.latitude, longitude: locations[0].coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.002, longitudeDelta: 0.002))
      //  self.mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Unable to access your current location")
    }
    
    /**
     Called when the button was used to logout.
     
     - parameter loginButton: Button that was used to logout.
     */
    public func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("user wants to log out from ")
        print(Auth.auth().currentUser?.email as Any)
        
        
        guard Auth.auth().currentUser != nil else {
            return
        }
        
        do {
            try Auth.auth().signOut()
            FBSDKAccessToken.setCurrent(nil)
//            loggedIn = false
//            storedValuesData.setValue(nil, forKey: "savedLoginEmail")
//            storedValuesData.setValue(nil, forKey: "savedLoginPassword")
//            jumpToVC1()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
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
            print("time to browse dates....")
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
            print(authResult?.user.email as Any)
            // https://firebase.google.com/docs/auth/ios/manage-users#get_the_currently_signed-in_user
            // login via twitter, email, phone, google etc:
            // https://firebase.google.com/docs/auth/ios/firebaseui
            print("the time has come to browse dates")
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


/*
 0
 
 Here's a swift version. Your user structure ("table") is like
 
 --users:
 -------abc,d@email,com:
 ---------------email:abc.d@email.com
 ---------------name: userName
 etc.
 After you pass the auth FIRAuth.auth()?.createUser you can set the users in database as below:
 
 let ref = FIRDatabase.database().reference()
 let rootChild = ref.child("users")
 let changedEmailChild = u.email?.lowercased().replacingOccurrences(of: ".", with: ",", options: .literal, range: nil) // Email doesn't support "," firebase doesn't support "."
 let userChild = rootChild.child(changedEmailChild!)
 userChild.child("email").setValue(u.email)
 userChild.child("name").setValue(signup.name)
 */
