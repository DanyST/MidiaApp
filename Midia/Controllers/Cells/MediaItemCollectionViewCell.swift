//
//  MediaItemCollectionViewCell.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 04-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class MediaItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Properties
    static let reuseIdentifier = "mediaItemCell"
    
    // MARK: - Outlets
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
}