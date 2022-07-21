//
//  AppCoordinator.swift
//  Navigation
//
//  Created by Александр Востриков on 19.06.2022.
//

import Foundation
import UIKit

protocol MainCoordinator {
    func startApp() -> UITabBarController
}

final class AppCoordinator: MainCoordinator {
    
    func startApp() -> UITabBarController {
        return TabBarController()
    }
}
