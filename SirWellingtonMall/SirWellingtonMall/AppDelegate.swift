//
//  AppDelegate.swift
//  SirWellingtonMall
//
//  Created by Juan Wellington Moreno on 5/14/16.
//  Copyright © 2016 Sir Wellington. All rights reserved.
//

import AromaSwiftClient
import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    private let AROMA_TOKEN = "2b48275b-2ad2-47dd-96be-97b1a8c7cd26"
    

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        AromaClient.TOKEN_ID = AROMA_TOKEN
        AromaClient.maxConcurrency = 1
        
        AromaClient.sendLowPriorityMessage(withTitle: "App Launched")
        
        NSSetUncaughtExceptionHandler() { ex in
            
            AromaClient.beginWithTitle("App Crashed")
                .withPriority(.HIGH)
                .addBody("\(ex)")
                .send()
        }
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        AromaClient.sendLowPriorityMessage(withTitle: "App Terminated")
    }


}

