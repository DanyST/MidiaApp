//
//  FavoriteTableViewCell.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 22-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit
import SDWebImage

class FavoriteTableViewCell: UITableViewCell {
    
    // MARK: - Constants
    static let reuseIdentifier = "favoriteMediaItemCell"
    
    // MARK: - Outlets
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var creatorsLabel: UILabel!
    @IBOutlet weak var createdOnLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    // MARK: - Properties
    var mediaItem: MediaItemDetailedProvidable! {
        didSet {
            if let url = mediaItem.imageURL {
                coverImageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholder.png"))
            }
            
            titleLabel.text = mediaItem.title
            
            // Opcionales, queremos ocultarlos cuando están vacíos
            if let creators = mediaItem.creatorName {
                creatorsLabel.text = creators
            } else {
                creatorsLabel.isHidden = true
            }
                        
            if let creationDate = mediaItem.creationDate {
                createdOnLabel.text = DateFormatter.booksAPIDateFormatter.string(from: creationDate)
            } else {
                createdOnLabel.isHidden = true
            }
            
            if let price = mediaItem.price {
                priceLabel.text = "price: \(price)$"
            } else {
                priceLabel.isHidden = true
            }
        }
    }
    
    // MARK: - Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
        coverImageView.sd_cancelCurrentImageLoad()
        
        [creatorsLabel, createdOnLabel, priceLabel].forEach { $0?.isHidden = false }
    }
    
}
