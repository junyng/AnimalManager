//
//  ConfigurableCell.swift
//  AnimalKeeper
//
//  Created by BLU on 23/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import Foundation

protocol ConfigurableCell: ReusableCell {
    associatedtype T
    
    func configure(_ item: T)
}
