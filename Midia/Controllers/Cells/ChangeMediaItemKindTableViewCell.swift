//
//  ChangeMediaItemKindTableViewCell.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 03-12-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

protocol ChangeMediaItemKindTableViewCellDelegate: class {
    func changeMediaItemKindTableViewCell(_ vc: ChangeMediaItemKindTableViewCell, didChangeMediaItemKind mediaItemKind: MediaItemKind)
}

class ChangeMediaItemKindTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "selectMediaItemCell"
    
    // MARK: - Properties
    weak var delegate: ChangeMediaItemKindTableViewCellDelegate?
    
    var mediaItemKind: MediaItemKind! {
        didSet {
            mediaItemSegmentedControl.removeAllSegments()
            
            MediaItemKind.allCases.forEach { (mediaItemKind) in
                mediaItemSegmentedControl.insertSegment(withTitle: mediaItemKind.description, at: mediaItemKind.rawValue, animated: true)
            }
            
            mediaItemSegmentedControl.selectedSegmentIndex = mediaItemKind.rawValue
            mediaItemIconImageView.image = mediaItemKind.imageIcon
        }
    }

    // MARK: - Outlets
    @IBOutlet weak var mediaItemSegmentedControl: UISegmentedControl!
    @IBOutlet weak var mediaItemIconImageView: UIImageView!
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        mediaItemSegmentedControl.addTarget(self, action: #selector(changeMediaItemKind(sender:)), for: .valueChanged)
        
    }
    
    @objc func changeMediaItemKind(sender: UISegmentedControl) {
        guard let selectedMediaItemKind = MediaItemKind(rawValue: sender.selectedSegmentIndex) else { return }
        
        mediaItemIconImageView.image = selectedMediaItemKind.imageIcon
        
        delegate?.changeMediaItemKindTableViewCell(self, didChangeMediaItemKind: selectedMediaItemKind)
    }
}
