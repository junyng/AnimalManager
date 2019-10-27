//
//  AnimalListViewModel.swift
//  AnimalKeeper
//
//  Created by BLU on 23/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

class AnimalListViewModel {
    
    // MARK: - Properties
    private let storageService: StorageService
    
    private var animals: [Animal] = [] {
        didSet {
            didUpdate?()
        }
    }
    
    var numberOfAnimals: Int {
        return animals.count
    }
    
    // Closures
    var didUpdate: (() -> Void)?
    var didSelectAnimal: ((_ animal: Animal) -> Void)?
    var didError: ((Error) -> Void)?
    
    init(storageService: StorageService = AnimalStore.shared) {
        self.storageService = storageService
    }
    
    // MARK: - Custom methods
    func getAnimal(at index: Int) -> Animal {
        return animals[index]
    }
    
    func deleteAnimal(at index: Int) {
        guard animals.indices.contains(index) else {
            return
        }
        storageService.delete(index) { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success:
                self.fetchAnimals()
            case .failure(let error):
                self.didError?(error)
            }
        }
    }
    
    func selectAnimal(at index: Int) {
        let animal = animals[index]
        self.didSelectAnimal?(animal)
    }
    
    func fetchAnimals() {
        storageService.load(completion: { [weak self] result in
            guard let self = self else {
                return
            }
            switch result {
            case .success(let animals):
                self.animals = animals
            case .failure(let error):
                self.didError?(error)
            }
        })
    }
}
