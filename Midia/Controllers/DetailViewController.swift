//
//  DetailViewController.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 19-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var creatorsLabel: UILabel!
    @IBOutlet weak var ratingsLabel: UILabel!
    @IBOutlet weak var numberOfReviewsLabel: UILabel!
    @IBOutlet weak var creationDateLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var ratingsContainerView: UIView!
    
    // MARK: - Properties
    // Nos tienen que dar el valor de esta variable, si no esta pantalla no tiene ningun sentido
    var mediaItemId: String!
    weak var mediaItemProvider: MediaItemProvider!
    var detailedMediaItem: MediaItemDetailedProvidable? // model
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.isHidden = false
        // pedirle al media provider, el detalle del media item con el id recibido
        Thread.sleep(forTimeInterval: 2)
        detailedMediaItem = Game()
        loadingView.isHidden = true
        
        // sync
        syncViewWithModel()
        
    }
}

// MARK: - Sync View With Model
extension DetailViewController {
    func syncViewWithModel() {
        guard let mediaItem = detailedMediaItem else { return }
        
        // Required
        titleLabel.text = mediaItem.title
        
        // It can be nil
        descriptionTextView.text = mediaItem.description
        
        // Stack view, if exist property it show, else hidden property for that stack view re-organize
        if let url = mediaItem.imageURL {
            imageView.loadImage(fromURL: url)
        }
        
        if let creators = mediaItem.creatorName {
            creatorsLabel.text = creators
        } else {
            creatorsLabel.isHidden = true
        }
        
        if let rating = mediaItem.ratings,
            let numberOfReviews = mediaItem.numberOfReviews {
            ratingsLabel.text = "Rating \(rating)"
            numberOfReviewsLabel.text = "\(numberOfReviews) reviews"
        } else {
            ratingsContainerView.isHidden = true
        }
        
        if let creationDate = mediaItem.creationDate {
            creationDateLabel.text = DateFormatter.booksAPIDateFormatter.string(from: creationDate)
        } else {
            creationDateLabel.isHidden = true
        }
        
        if let price = mediaItem.price {
            buyButton.setTitle("Buy for \(price)$", for: .normal)
        } else {
            buyButton.isHidden = true
        }
        
    }
}

// MARK: - Actions
extension DetailViewController {
    @IBAction func didTapCloseButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
