//
//  AppDelegate.swift
//
//  Created by Kaylie Sampson 10/5/20
//  Copyright © 2020 ComputeCycles, LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(named: "accent") ?? UIColor.black]
        UISwitch.appearance().onTintColor = UIColor(named: "accent")
        UITableView.appearance().backgroundColor = UIColor.clear
        registerPushNotification()
        return true
    }
    //PUSH NOTIFICATION
    func registerPushNotification() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (isGranted, err) in
            print("registerPushNotification \(isGranted)")
        }
    }
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }
    
}

