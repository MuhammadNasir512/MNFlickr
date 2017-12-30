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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let mainStoryboardIpad = UIStoryboard(name: "Main", bundle: nil)
        if let rootViewController = mainStoryboardIpad.instantiateViewController(withIdentifier: "view_controller") as? ViewController {
            self.window = UIWindow(frame: UIScreen.main.bounds)
            self.window?.rootViewController = rootViewController
            self.window?.makeKeyAndVisible()
            setupHomeScreenModule(withViewController: rootViewController)
        }
        return true
    }

    private func setupHomeScreenModule(withViewController viewController: ViewController) {
        let presenter = ViewControllerPresenter(withDelegate: viewController)
        let interactor = ViewControllerInteractor(withDelegate: presenter)
        let module = Module(withViewController: viewController)
        module.presenter = presenter
        module.interactor = interactor
        module.setupModule()
    }
}

