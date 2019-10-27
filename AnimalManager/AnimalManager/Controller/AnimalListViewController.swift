//
//  AnimalListViewController.swift
//  AnimalKeeper
//
//  Created by BLU on 23/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class AnimalListViewController: UIViewController, Alertable {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: AnimalListViewModel?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel?.fetchAnimals()
    }
    
    // MARK: - Custom methods
    private func bindViewModel() {
        viewModel?.didUpdate = { [weak self] in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        viewModel?.didSelectAnimal = { [weak self] animal in
            guard let self = self else {
                return
            }
            self.deselectSelectedRow()
            guard let cryingSound = animal.cryingSound else {
                return
            }
            self.showAlert(
                title: animal.name,
                message: cryingSound,
                preferredStyle: .alert,
                completion: nil
            )
        }
        viewModel?.didError = { [weak self] error in
            guard let self = self else {
                return
            }
            self.showAlert(
                title: Constants.Message.error,
                message: error.localizedDescription,
                preferredStyle: .alert,
                completion: nil
            )
        }
    }
    
    func deselectSelectedRow() {
        if let indexPath = self.tableView.indexPathForSelectedRow {
            self.tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navigationController = segue.destination as? UINavigationController,
            let animalRegisterController = navigationController.viewControllers.first as? AnimalRegisterViewController {
            animalRegisterController.viewModel = AnimalRegisterViewModel()
        }
    }
}

// MARK: - Table view data source
extension AnimalListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.numberOfAnimals ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let animal = viewModel?.getAnimal(at: indexPath.row),
            let cell = tableView.dequeueReusableCell(withIdentifier: AnimalTableViewCell.reuseIdentifier) as? AnimalTableViewCell else {
                return UITableViewCell()
        }
        cell.configure(animal)
        
        return cell
    }
}

// MARK: - Table view delegate
extension AnimalListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel?.selectAnimal(at: indexPath.row)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel?.deleteAnimal(at: indexPath.row)
        }
    }
}
