//
//  AnimalRegisterViewController.swift
//  AnimalKeeper
//
//  Created by BLU on 23/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

typealias Field = (title: String, placeholder: String)

enum Input {
    case name
    case type
    
    var text: Field {
        switch self {
        case .name:
            return ("이름", "이름을 입력하세요.")
        case .type:
            return ("종류", "선택")
        }
    }
}

class AnimalRegisterViewController: UIViewController, Alertable {
    
    // MARK: - IBOutlets
    @IBOutlet private weak var tableView: UITableView!
    
    // MARK: - Properties
    var viewModel: AnimalRegisterViewModel?
    
    // MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    // MARK: - IBActions
    @IBAction func cancelButtonDidTapped(_ sender: UIBarButtonItem) {
        viewModel?.cancel()
    }
    
    @IBAction func registerButtonDidTapped(_ sender: UIBarButtonItem) {
        viewModel?.addAnimal()
    }
    
    // MARK: - Custom methods
    private func bindViewModel() {
        viewModel?.didSelectPicker = { [weak self] animalType in
            guard let self = self else {
                return
            }
            let visibleCells = self.tableView.visibleCells
            let textFieldCells = visibleCells.compactMap { $0 as? FieldTableViewCell }
            let animalTypeCell = textFieldCells.filter { $0.style == .readOnly }.first
            animalTypeCell?.textField.text = animalType
        }
        viewModel?.didTapCancel = { [weak self] in
            guard let self = self else {
                return
            }
            self.dismiss(animated: true, completion: nil)
        }
        viewModel?.didAddAnimal = { [weak self] in
            guard let self = self else {
                return
            }
            self.dismiss(animated: true, completion: nil)
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
}

// MARK: - Table view data source
extension AnimalRegisterViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.cellTypes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let type = viewModel?.cellTypes[indexPath.row] else {
            return UITableViewCell()
        }
        switch type {
        case .field(let input):
            if let cell = tableView.dequeueReusableCell(withIdentifier: FieldTableViewCell.reuseIdentifier) as? FieldTableViewCell {
                cell.configure(input.text)
                cell.style = (input == .type) ? .readOnly : .default
                if input == .name {
                    cell.textField.delegate = self
                }
                return cell
            }
        case .picker:
            if let cell = tableView.dequeueReusableCell(withIdentifier: PickerTableViewCell.reuseIdentifier) as? PickerTableViewCell {
                cell.pickerView.delegate = self
                cell.pickerView.dataSource = self
                return cell
            }
        }
        return UITableViewCell()
    }
}

// MARK: - Text field delegate
extension AnimalRegisterViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        viewModel?.animalName = textField.text
        return true
    }
}

// MARK: - Picker view data source
extension AnimalRegisterViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel?.animalNames.count ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel?.animalNames[row]
    }
}

// MARK: - Picker view delegate
extension AnimalRegisterViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel?.selectPicker(at: row)
    }
}
