//
//  AddTaskViewController.swift
//  MVVM-C-Architecture
//
//  Created by Marcos Albuquerque on 05/11/25.
//

import UIKit

final class AddTaskCoordinator {
    private let navigationController: UINavigationController
    private let parentViewModel: ToDoListViewModel
    
    init(navigationController: UINavigationController, parentViewModel: ToDoListViewModel) {
        self.navigationController = navigationController
        self.parentViewModel = parentViewModel
    }
    
    func start() {
        print("start add task coordinator")
        let vm = AddTaskViewModel(parentViewModel: parentViewModel)
        let vc = AddTaskViewController(viewModel: vm)
        navigationController.present(UINavigationController(rootViewController: vc), animated: true)
    }
}
