//
//  AnimalStore.swift
//  AnimalKeeper
//
//  Created by BLU on 25/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

enum StorageError: Error {
    case saveFailed
    case loadFailed
    
    var localizedDescription: String {
        switch self {
        case .saveFailed:
            return "저장에 실패하였습니다."
        case .loadFailed:
            return "불러오기에 실패하였습니다."
        }
    }
}

final class AnimalStore: StorageService {
    private(set) var animals = [Animal]()
    
    private let fileURL: URL = {
        let documentsDirectories =
            FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return documentsDirectories[0].appendingPathComponent(Constants.Storage.folder)
    }()
    
    static let shared = AnimalStore()
    private init() { }
    
    func load(completion: @escaping (Result<[Animal], StorageError>) -> Void) {
        do {
            try loadAll()
            completion(.success(animals))
        } catch {
            completion(.failure(StorageError.loadFailed))
        }
    }
    
    func save(_ animal: Animal, completion: @escaping (Result<Void?, StorageError>) -> Void) {
        animals.append(animal)
        do {
            try saveAll()
            completion(.success(nil))
        } catch {
            completion(.failure(StorageError.saveFailed))
        }
    }
    
    func delete(_ index: Int, completion: @escaping (Result<Void?, StorageError>) -> Void) {
        animals.remove(at: index)
        do {
            try saveAll()
            completion(.success(nil))
        } catch {
            completion(.failure(StorageError.saveFailed))
        }
    }
    
    private func saveAll() throws {
        let data = try JSONEncoder().encode(animals)
        let archivedData = try NSKeyedArchiver.archivedData(withRootObject: data, requiringSecureCoding: false)
        try archivedData.write(to: fileURL)
    }
    
    private func loadAll() throws {
        let data = try Data(contentsOf: fileURL)
        if let object = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Data {
            let animals = try JSONDecoder().decode([Animal].self, from: object)
            self.animals = animals
        }
    }
}
