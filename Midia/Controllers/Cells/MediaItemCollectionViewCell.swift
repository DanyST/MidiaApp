//
//  MediaItemCollectionViewCell.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 04-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit
import SDWebImage

class MediaItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Properties
       static let reuseIdentifier = "mediaItemCell"
    
    // Por si necesitamos dejar mediaItem a nil, lo dejamos opcional explicito
    var mediaItem: MediaItemProvidable! {
        didSet {
            titleLabel.text = mediaItem.title
            
            if let url = mediaItem.imageURL {
                imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder"))
            }
        }
    }
    
    // MARK: - Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        // cancelamos descargas de imagenes en celdas que ya no seran vistas en pantalla, para ser reutilizadas con otras mediaItems
        imageView.sd_cancelCurrentImageLoad()
    }
    
}
