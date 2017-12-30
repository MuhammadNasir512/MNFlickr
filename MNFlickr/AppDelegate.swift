//
//  AppDelegate.swift
//  MNFlickr
//
//  Created by Muhammad Nasir on 24/12/2017.
//  Copyright © 2017 Muhammad Nasir. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var module: Module?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        let mainStoryboardIpad = UIStoryboard(name: "Main", bundle: nil)
        if let rootViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "view_controller") as? ViewController {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            setupWindow(withRootViewController: rootViewController)
            setupHomeScreenModule(withViewController: rootViewController)
        }
        
        return true
    }

    private func setupHomeScreenModule(withViewController viewController: ViewController) {
        let presenter = ViewControllerWithTagsPresenter(withDelegate: viewController)
        let interactor = ViewControllerWithTagsInteractor(withDelegate: presenter)
        let module = Module(withViewController: viewController)
        module.presenter = presenter
        module.interactor = interactor
        module.setupModule()
        self.module = module
    }
    
    private func findNavigationController() -> UINavigationController? {
        let mainStoryboardIpad = UIStoryboard(name: "Main", bundle: nil)
        if let navigationController = mainStoryboardIpad.instantiateViewController(withIdentifier: "navigation_controller") as? UINavigationController {
            return navigationController
        }
        return nil
    }
    
    private func setupWindow(withRootViewController viewController: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let navigationController = findNavigationController() {
            navigationController.setViewControllers([viewController], animated: true)
            self.window?.rootViewController = navigationController
        }
        else {
            self.window?.rootViewController = viewController
        }
        self.window?.makeKeyAndVisible()
    }
}

