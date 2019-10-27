//
//  AnimalTableViewCell.swift
//  AnimalKeeper
//
//  Created by BLU on 23/10/2019.
//  Copyright © 2019 BLU. All rights reserved.
//

import UIKit

class AnimalTableViewCell: UITableViewCell, ConfigurableCell {

    // MARK: - IBOutlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    // MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }
    
    // MARK: - Custom methods
    func configure(_ item: Animal) {
        nameLabel.text = item.name
        typeLabel.text = String(describing: item.type)
        profileImageView.image = item.image
    }
    
    private func setupUI() {
        profileImageView.layer.cornerRadius = 10
    }
}
