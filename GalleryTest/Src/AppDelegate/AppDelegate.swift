//
//  AppDelegate.swift
//  GalleryTest
//
//  Created by Александр Головин on 24.08.2022.
//

import UIKit
import DBDebugToolkit
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
    #if DEBUG
        DBDebugToolkit.setup(with: [DBShakeTrigger()])
    #endif
        DI.initDependencies(self)
        return true
        
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
      
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
       
    }

}



extension AppDelegate {
    
    func openStartScreen(window: UIWindow?) {
       
        if let window = window {
            self.window = window
        }
        
        guard let window = self.window else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            return openStartScreen(window: nil)
        }
        
        DispatchQueue.main.async {
            let rootView = R.storyboard.welcomeStoryboard().instantiateInitialViewController()
            window.makeKeyAndVisible()
            window.rootViewController = rootView
        }

        
        
        
        }
    
    
    func openMainScreen(window: UIWindow?) {
      
        if let window = window {
            self.window = window
        }
        DispatchQueue.main.async {
        guard let window = self.window else {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            return self.openMainScreen(window: nil)
        }
            let rootView = R.storyboard.mainGalleryScreen().instantiateInitialViewController()
            window.makeKeyAndVisible()
            window.rootViewController = rootView
        }
        }

    
}

extension AppDelegate: AuthResponseHandlerDelegate {
    func doLogout() {
        ProfileSettings().clearUserData()
        guard let navController = self.window?.rootViewController as? UINavigationController,
              navController.viewControllers.last as? AuthorizationSceneViewController != nil else {
            DispatchQueue.main.async { [weak self] in
                self?.openStartScreen(window: self?.window)
            }
            return
        }
    }
    
    
}
