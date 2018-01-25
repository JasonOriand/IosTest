//
//  AppDelegate.swift
//  IosTest
//
//  Created by Chiang Chih-Yi on 2018/1/26.
//  Copyright © 2018年 Test. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, StorageDelegate {

    var window: UIWindow?

    //store
    struct StoreConstants{
        static let STORE_KEY_DAILY_WORD = "STORE_KEY_DAILY_WORD"
        static let STORE_KEY_WORD_DEFAULT = "每日一字"
        static let STORE_KEY_WEEK_WEATHER = "STORE_KEY_WEEK_WEATHER"
    }
    let storeUserDefaults = UserDefaults.standard

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        initLoader()
        
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
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    
    // init loader
    func initLoader() {
        //WordLoader.getInstance().setStorageInterface(this)
        //WeatherLoader.getInstance().setStorageInterface(this)
    }
    
    
    // StorageDelegate functions
    func refreshWord(word: String?) {
        if word != nil {
            storeUserDefaults.set(word, forKey: StoreConstants.STORE_KEY_DAILY_WORD)
            storeUserDefaults.synchronize()
        }
    }
    
    func getWord() -> String? {
        let word: String? = storeUserDefaults.string(forKey: StoreConstants.STORE_KEY_DAILY_WORD)
        
        if word != nil {
            return word
        }
            
        return StoreConstants.STORE_KEY_WORD_DEFAULT
    }
    
    func refreshWeather(weathers: [String]?) {
        if weathers != nil {
            storeUserDefaults.set(weathers, forKey: StoreConstants.STORE_KEY_WEEK_WEATHER)
            storeUserDefaults.synchronize()
        }
    }
    
    func getWeather() -> [String]? {
        return storeUserDefaults.object(forKey: StoreConstants.STORE_KEY_WEEK_WEATHER) as? [String]
    }
    
}

