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
    @IBOutlet private weak var imageView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    var mediaItem: MediaItemProvidable! {
        didSet {
            titleLabel.text = mediaItem.title
            // TODO: add image
        }
    }
    
}
