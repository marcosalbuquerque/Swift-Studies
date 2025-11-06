//
//  AddTaskViewModel.swift
//  MVVM-C-Architecture
//
//  Created by Marcos Albuquerque on 05/11/25.
//

import Foundation

final class AddTaskViewModel {
    private let parentViewModel: ToDoListViewModel
    
    init(parentViewModel: ToDoListViewModel) {
        self.parentViewModel = parentViewModel
    }
    
    func saveTask(name: String) {
        parentViewModel.addTask(name: name)
    }
}
