//
//  TodoListViewController.swift
//  MVVM-C-Architecture
//
//  Created by Marcos Albuquerque on 05/11/25.
//

import UIKit

final class ToDoListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let viewModel: ToDoListViewModel
    weak var coordinator: ToDoListCoordinator?
    private let tableView = UITableView()
    private let addButton = UIButton(type: .system)
    
    init(viewModel: ToDoListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        bindViewModel()
    }

    private func setupUI() {
        title = "To-Do List"
        view.backgroundColor = .systemBackground

        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")

        addButton.setTitle("Add Task", for: .normal)
        addButton.addTarget(self, action: #selector(addTaskTapped), for: .touchUpInside)

        view.addSubview(tableView)
        view.addSubview(addButton)

        tableView.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: addButton.topAnchor, constant: -20)
        ])
    }

    private func bindViewModel() {
        viewModel.onTasksUpdated = { [weak self] _ in
            self?.tableView.reloadData()
        }
    }

    @objc private func addTaskTapped() {
        // o Coordinator vai lidar com a navegação
        coordinator?.showAddTask()
        print("Tapped")
    }

    // MARK: - TableView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.tasks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let task = viewModel.tasks[indexPath.row]
        cell.textLabel?.text = task.name + (task.isCompleted ? " ✅" : "")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.toggleTask(at: indexPath.row)
    }
}
