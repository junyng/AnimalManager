//
//  StorageService.swift
//  AnimalKeeper
//
//  Created by BLU on 26/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

protocol StorageService {
    func load(completion: @escaping (Result<[Animal], StorageError>) -> Void)
    func save(_ animal: Animal, completion: @escaping (Result<Void?, StorageError>) -> Void)
    func delete(_ index: Int, completion: @escaping (Result<Void?, StorageError>) -> Void)
}
