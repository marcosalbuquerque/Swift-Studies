//
//  ToDoListCoordinator.swift
//  MVVM-C-Architecture
//
//  Created by Marcos Albuquerque on 05/11/25.
//

import UIKit

final class ToDoListCoordinator {
    private let navigationController: UINavigationController
    private let viewModel = ToDoListViewModel()
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ToDoListViewController(viewModel: viewModel)
        vc.navigationItem.largeTitleDisplayMode = .always
        vc.coordinator = self
        navigationController.pushViewController(vc, animated: false)
        print("start to do list coordinator")
    }

    func showAddTask() {
        print("show add task")
        let addCoordinator = AddTaskCoordinator(navigationController: navigationController, parentViewModel: viewModel)
        addCoordinator.start()
    }
}
