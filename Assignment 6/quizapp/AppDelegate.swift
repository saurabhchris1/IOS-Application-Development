//
//  AppDelegate.swift
//  quizapp
//
//  Created by Saurabh Jaiswal on 2/18/19.
//  Copyright © 2019 Saurabh Jaiswal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //Default setings
        if(UserDefaults.standard.object(forKey: "userName") == nil){
            UserDefaults.standard.set("", forKey: "userName")
        }
        
        if(UserDefaults.standard.object(forKey: "shuffleItems") == nil){
            UserDefaults.standard.set(true, forKey: "shuffleItems")
        }
        
        if(UserDefaults.standard.object(forKey: "timeLimit") == nil){
            let timeLimit: Int = 5
            UserDefaults.standard.set(timeLimit, forKey: "timeLimit")
        }
        
        if(UserDefaults.standard.object(forKey: "autodownload") == nil){
            UserDefaults.standard.set(true, forKey: "autodownload")
        }
        
        if(UserDefaults.standard.object(forKey: "category") == nil){
            UserDefaults.standard.set("All", forKey: "category")
        }
        
       
        return true
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
        
        let navController = self.window?.rootViewController as! UINavigationController
        
        let settingsTVC = navController.topViewController as! SettingsTableViewController
        
    settingsTVC.resetSettingsView()
      
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
   


}

