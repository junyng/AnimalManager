//
//  AnimalRegisterViewModel.swift
//  AnimalKeeper
//
//  Created by BLU on 24/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

class AnimalRegisterViewModel {
    
    // MARK: - Properties
    private let storageService: StorageService
    
    private(set) var cellTypes: [CellType] = [
        .field(.name),
        .field(.type),
        .picker
    ]
    private(set) var animalTypes = AnimalType.allCases
    var animalNames: [String] {
        return animalTypes.map { String(describing: $0) }
    }
    var selectedAnimalType: AnimalType?
    var animalName: String?
    
    // Closures
    var didTapCancel: (() -> Void)?
    var didAddAnimal: (() -> Void)?
    var didSelectPicker: ((String) -> Void)?
    var didError: ((Error) -> Void)?
    
    init(storageService: StorageService = AnimalStore.shared) {
        self.storageService = storageService
    }
    
    // MARK: - Custom methods
    func addAnimal() {
        guard let name = animalName, !name.isEmpty,
            let type = selectedAnimalType else {
                return
        }
        let animal = Animal(name: name, type: type)
        storageService.save(animal) { [weak self] (result) in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                self.didAddAnimal?()
            case .failure(let error):
                self.didError?(error)
            }
        }
    }
    
    func cancel() {
        didTapCancel?()
    }
    
    func selectPicker(at index: Int) {
        selectedAnimalType = animalTypes[index]
        didSelectPicker?(animalNames[index])
    }
}

// Constants
extension AnimalRegisterViewModel {
    enum CellType {
        case field(Input)
        case picker
    }
}
