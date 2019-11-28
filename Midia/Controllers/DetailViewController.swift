//
//  DetailViewController.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 19-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

enum FavoriteToggleKind {
    case add
    case remove
}

// MARK: - DetailViewControllerDelegate
protocol DetailViewControllerDelegate: class {
    // Send favorite that it was toggle, with it toggle kind(add or remove)
    func detailViewController(_ vc: DetailViewController, didToggleFavorite favorite: MediaItemDetailedProvidable, withFavoriteToggleKind toggleKind: FavoriteToggleKind)
}

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
    @IBOutlet weak var toggleFavoriteButton: UIButton!
    
    
    // MARK: - Properties
    weak var delegate: DetailViewControllerDelegate?
    // Nos tienen que dar el valor de esta variable, si no esta pantalla no tiene ningun sentido
    var mediaItemId: String!
    weak var mediaItemProvider: MediaItemProvider?
    var detailedMediaItem: MediaItemDetailedProvidable? // model
    var isFavorite = false
    
    // MARK: - Life Cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        loadingView.isHidden = false
        
        // Si encuentra el 'detailedMediaItem' guardado en el store de favoritos, lo utiliza, si no, lo busca en la red
        if let storedMediaItem = StorageManager.shared.getFavorite(byId: mediaItemId) {
            // instanciar detailedMediaItem guardado en favoritos
            detailedMediaItem = storedMediaItem
            
            // Favorite
            isFavorite = true
            toggleFavoriteButton.setTitle("Remove Favorite", for: .normal)
            
            // sync
            syncViewWithModel()
            
            // mostrar pantalla de detalle
            loadingView.isHidden = true
        } else {
            
            // pedirle al media provider, el detalle del media item con el id recibido
            mediaItemProvider?.getMediaItem(byId: mediaItemId) { [weak self] (result) in
                switch result {
                case .success(let detailedMediaItem):
                    self?.detailedMediaItem = detailedMediaItem
                     // sync
                    self?.syncViewWithModel()
                    self?.loadingView.isHidden = true
                case .failure(_):
                    self?.loadingView.isHidden = true
                    
                    // Creo alertController
                    let alertController = UIAlertController(title: "Error", message: "An error has occurred with the Media Item :(", preferredStyle: .alert)
                    
                    // Creo AlertAction
                    let alertAction = UIAlertAction(title: "OK", style: .default, handler: { (_) in
                        self?.dismiss(animated: true, completion: nil)
                    })
                    
                    // Añado AlertAction a AlertContorller
                    alertController.addAction(alertAction)
                    
                    // Presento alertController en pantalla
                    self?.present(alertController, animated: true, completion: nil)
                }
            }
        }
    }
    
}

// MARK: - Sync View With Model
extension DetailViewController {
    func syncViewWithModel() {
        guard let mediaItem = detailedMediaItem else { return }
        
        // Required
        titleLabel.text = mediaItem.title
        
        // It can be nil
        descriptionTextView.htmlText(withString: mediaItem.description)
        
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
    
    @IBAction func didTapToggleFavorite(_ sender: Any) {
        guard let detailedMediaItem = detailedMediaItem else { return }
        isFavorite.toggle()
        
        if isFavorite {
            StorageManager.shared.add(favorite: detailedMediaItem)
            toggleFavoriteButton.setTitle("Remove Favorite", for: .normal)
            
            // avisamos al delegate
            self.delegate?.detailViewController(self, didToggleFavorite: detailedMediaItem, withFavoriteToggleKind: .add)
        } else {
            StorageManager.shared.remove(favoriteWithId: detailedMediaItem.mediaItemId)
            toggleFavoriteButton.setTitle("Add Favorite", for: .normal)
            
            // avisamos al delegate
            self.delegate?.detailViewController(self, didToggleFavorite: detailedMediaItem, withFavoriteToggleKind: .remove)
        }
    }
    
}
