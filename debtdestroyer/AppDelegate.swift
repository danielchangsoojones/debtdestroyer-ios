//
//  AppDelegate.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 8/3/22.
//

import Sentry
import UIKit
import Parse
import AVFoundation
import UXCam
import UserNotifications

@main
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        SentrySDK.start { options in
            options.dsn = "https://ae23f1afc59d4b0dab26c5f12b947034@o4504962377777152.ingest.sentry.io/4504962811625472"
            options.debug = true
            options.enablePreWarmedAppStartTracing = true
            options.attachScreenshot = true
            options.attachViewHierarchy = true
            options.enableMetricKit = true
        }
        // Override point for customization after application launch.
        IAPManager.shared.startObserving()
        setupServer()
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0.0
        }
        
        let center  = UNUserNotificationCenter.current()
        center.delegate = self
        application.registerForRemoteNotifications()
        
        setUXCam()
        
        // MARK: Code snippet is for Question screen >> audio work in silent mode too.
        var categoryError :NSError?
        var success: Bool
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .moviePlayback, options: .duckOthers)
            success = true
        } catch let error as NSError {
            categoryError = error
            success = false
        }
        
        if !success {
            print("AppDelegate Debug - Error setting AVAudioSession category.  Because of this, there may be no sound. \(categoryError!)")
        }
        //
        return true
    }
    
    private func setUXCam() {
        let configuration = UXCamConfiguration(appKey: "6q4yxoixlvoyww8")
        UXCam.optIntoSchematicRecordings()
        UXCam.start(with: configuration)
    }
    
    private func setupServer() {
        let configuration = ParseClientConfiguration {
            $0.applicationId = Configuration.environment.appID
            $0.server = Configuration.environment.serverURL
        }
        
        Parse.initialize(with: configuration)
        User.registerSubclass()
        TransactionParse.registerSubclass()
        DebtAccountsParse.registerSubclass()
        WinnerParse.registerSubclass()
        QuizDataParse.registerSubclass()
        QuizTopicParse.registerSubclass()
        CryptoAddressParse.registerSubclass()
        QuizScoreParse.registerSubclass()
        ConfigurationParse.registerSubclass()
    }

    // Lock the orientation to Portrait mode
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask(rawValue: UIInterfaceOrientationMask.portrait.rawValue)
    }
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        IAPManager.shared.stopObserving()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let installation = PFInstallation.current()
        installation?.setDeviceTokenFrom(deviceToken)
        installation?.saveInBackground(block: { (succ, error) in
            if error == nil {
                print("DEVICE TOKEN REGISTERED!")
            } else {
                print("\(error!.localizedDescription)")
            }
        })
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        print("\(userInfo)")
    }
    
    // This method will be called when app received push notifications in foreground
    //otherwise when inside the app, you never get push notifications
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }
}

