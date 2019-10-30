//
//  FieldTableViewCell.swift
//  AnimalKeeper
//
//  Created by BLU on 23/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class FieldTableViewCell: UITableViewCell, ConfigurableCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    // MARK: - Properties
    var style: Style = .default {
        didSet {
            if style == .readOnly {
                textField.isUserInteractionEnabled = false
            }
        }
    }
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    // MARK: - Custom methods
    func configure(_ item: Field) {
        titleLabel.text = item.title
        textField.placeholder = item.placeholder
    }
}

// MARK: - Constants
extension FieldTableViewCell {
    enum Style {
        case `default`
        case readOnly
    }
}
