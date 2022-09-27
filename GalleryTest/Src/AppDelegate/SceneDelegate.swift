//
//  SceneDelegate.swift
//  GalleryTest
//
//  Created by Александр Головин on 24.08.2022.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        
//        ProfileSettings().clearUserData()
        
        if ProfileSettings().token != nil {
            (UIApplication.shared.delegate as? AppDelegate)?.openMainScreen(window: self.window)
        } else {
            (UIApplication.shared.delegate as? AppDelegate)?.openStartScreen(window: self.window)
        }
    
        if #available(iOS 13.0, *) {
            window?.overrideUserInterfaceStyle = .light
        }
        
        
        
    }
    
    
    
    
    
    func sceneDidDisconnect(_ scene: UIScene) {
       
     
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        
    }

    func sceneWillResignActive(_ scene: UIScene) {
   
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
  
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        
    }

}

