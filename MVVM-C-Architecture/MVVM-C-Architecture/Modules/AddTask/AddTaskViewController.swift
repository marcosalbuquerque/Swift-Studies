//
//  AddTaskViewController.swift
//  MVVM-C-Architecture
//
//  Created by Marcos Albuquerque on 05/11/25.
//

import UIKit

final class AddTaskViewController: UIViewController {

    private let viewModel: AddTaskViewModel
    private let textField = UITextField()
    private let saveButton = UIButton(type: .system)
    
    init(viewModel: AddTaskViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) { fatalError("init(coder:) not implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        title = "Add Task"
        view.backgroundColor = .systemBackground
        
        textField.placeholder = "Task title"
        textField.borderStyle = .roundedRect
        
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveTapped), for: .touchUpInside)
        
        view.addSubview(textField)
        view.addSubview(saveButton)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        saveButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textField.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textField.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            textField.widthAnchor.constraint(equalToConstant: 200),
            
            saveButton.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            saveButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc private func saveTapped() {
        guard let name = textField.text, !name.isEmpty else { return }
        viewModel.saveTask(name: name)
        dismiss(animated: true)
    }
}

