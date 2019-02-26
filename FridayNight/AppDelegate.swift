//
//  AppDelegate.swift
//  FridayNight
//
//  Created by jason harrison on 2019-02-09.
//  Copyright © 2019 jason harrison. All rights reserved.
//

import UIKit
import Firebase
//#import <FBSDKCoreKit/FBSDKCoreKit.h>
import FacebookCore

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    
    
    /*
 
     //  AppDelegate.m
     #import <FBSDKCoreKit/FBSDKCoreKit.h>
     
     - (BOOL)application:(UIApplication *)application
     didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
     
     [[FBSDKApplicationDelegate sharedInstance] application:application
     didFinishLaunchingWithOptions:launchOptions];
     // Add any custom logic here.
     return YES;
     }
     
     - (BOOL)application:(UIApplication *)application
     openURL:(NSURL *)url
     options:(NSDictionary<UIApplicationOpenURLOptionsKey,id> *)options {
     
     BOOL handled = [[FBSDKApplicationDelegate sharedInstance] application:application
     openURL:url
     sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]
     annotation:options[UIApplicationOpenURLOptionsAnnotationKey]
     ];
     // Add any custom logic here.
     return handled;
     }
     
     */
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
       
        
        SDKApplicationDelegate.shared.application(application, didFinishLaunchingWithOptions: launchOptions)
        
        /*
         To complete setup, add this OAuth redirect URI to your Facebook app configuration. Learn more
         https://fridaynight-62633.firebaseapp.com/__/auth/handler
         (from firebase)
         
         from fb developer:
         appid: 1080498758811393
         app secret: 0e40acc54dd0b6cf9b093c41eb0b0f0b
        */
        return true
    }
    
 
    
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        return SDKApplicationDelegate.shared.application(application,
                                                         open: url,
                                                         sourceApplication: sourceApplication,
                                                         annotation: annotation)
        
         }
    
    @available(iOS 9.0, *)
    func application(_ application: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any]) -> Bool {
        return SDKApplicationDelegate.shared.application(application, open: url, options: options)
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

