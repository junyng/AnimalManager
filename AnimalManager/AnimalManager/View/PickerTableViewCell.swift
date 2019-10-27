//
//  PickerTableViewCell.swift
//  AnimalKeeper
//
//  Created by BLU on 23/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell, ReusableCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var pickerView: UIPickerView!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
