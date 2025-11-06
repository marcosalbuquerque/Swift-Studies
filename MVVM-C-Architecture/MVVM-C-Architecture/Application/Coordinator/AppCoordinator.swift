//
//  AppCoordinator.swift
//  MVVM-C-Architecture
//
//  Created by Marcos Albuquerque on 05/11/25.
//

import UIKit

final class AppCoordinator {
    private let window: UIWindow
    private let navigationController = UINavigationController()
    
    private var todoCoordinator: ToDoListCoordinator?
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        let todoCoordinator = ToDoListCoordinator(navigationController: navigationController)
        todoCoordinator.start()
        
        self.todoCoordinator = todoCoordinator
        
        print("start app coordinator")
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
}
