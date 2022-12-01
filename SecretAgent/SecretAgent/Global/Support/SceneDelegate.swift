//
//  SceneDelegate.swift
//  SecretAgent
//
//  Created by DaeSeong on 2022/11/17.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }

        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        window?.overrideUserInterfaceStyle = .light
        
        UserDefaults.standard.setValue("", forKey: "agentName")
        
        if UserDefaults.standard.string(forKey: "agentName") ?? "" == "" {
            window?.rootViewController = UINavigationController(rootViewController: OnBoardingViewController())
        } else {
            window?.rootViewController = MainTabViewController()
        }
        window?.makeKeyAndVisible()    }

    func sceneDidDisconnect(_ scene: UIScene) {}

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        guard let start = UserDefaults.standard.object(forKey: "sceneDidEnterBackground") as? Date else { return }
        let interval = Double(Date().timeIntervalSince(start))
        NotificationCenter.default.post(name: NSNotification.Name("sceneWillEnterForeground"), object: nil, userInfo: ["time": interval])
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        UserDefaults.standard.setValue(Date(), forKey: "sceneDidEnterBackground")
    }
}
