//
//  ToDoList.swift
//  MVVM-C-Architecture
//
//  Created by Marcos Albuquerque on 05/11/25.
//
import Foundation

protocol ToDoListViewModelProtocol: AnyObject {
    var tasks: [Task] { get }
    var onTasksUpdated: (([Task]) -> Void)? { get set }
    func addTask(name: String)
    func toggleTask(at index: Int)

}

final class ToDoListViewModel: ToDoListViewModelProtocol {
    
    private(set) var tasks: [Task] = [] {
        didSet {
            onTasksUpdated?(tasks)
        }
    }
    
    var onTasksUpdated: (([Task]) -> Void)?
    
    func addTask(name: String) {
        let newTask = Task(name: name, isCompleted: false)
        tasks.append(newTask)
    }
    
    func toggleTask(at index: Int) {
        guard tasks.indices.contains(index) else { return }
        tasks[index].isCompleted.toggle()
    }
}
