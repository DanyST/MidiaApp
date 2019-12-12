//
//  MidiaTabBarViewController.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 03-12-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

final class MidiaTabBarViewController: UITabBarController {
    
    // MARK: Properties
    private var selectedMediaItemKind: MediaItemKind!
    
    
    // MARK: Methods
    func setup(with mediaItemKind: MediaItemKind) {
        
        self.selectedMediaItemKind = mediaItemKind
        
        // Add mediaItemProvider to ViewControllers
        guard let homeViewController = self.viewControllers?.first as? HomeViewController,
        let searchViewController = self.viewControllers?[1] as? SearchViewController,
            let settingViewController = self.viewControllers?[3] as? SettingsViewController
            else {
            fatalError("Wrong Initial Setup")
        }
        
        let mediaItemProvider = MediaItemProvider(withMediaItemKind: selectedMediaItemKind)
        
        // Setup ViewControllers
        
        // with media provider
        homeViewController.mediaItemProvider = mediaItemProvider
        searchViewController.mediaItemProvider = mediaItemProvider
        
        // with media mediaItemKind
        settingViewController.mediaItemKind = selectedMediaItemKind
        
        // Setup Storage Manager
        StorageManager.setup(withMediaItemKind: selectedMediaItemKind)
    }
    
    func update(with selectedMediaItemKind: MediaItemKind) {
        
        guard self.selectedMediaItemKind != selectedMediaItemKind,
            let homeViewController = self.viewControllers?.first as? HomeViewController,
            let searchViewController = self.viewControllers?[1] as? SearchViewController,
            let favoritesViewController = self.viewControllers?[2] as? FavoritesViewController,
            let settingViewController = self.viewControllers?[3] as? SettingsViewController
            else {
            return
        }
        
        self.selectedMediaItemKind = selectedMediaItemKind

        let mediaItemProvider = MediaItemProvider(withMediaItemKind: selectedMediaItemKind)
       
        // Setup ViewControllers
        homeViewController.mediaItemProvider = mediaItemProvider
        searchViewController.mediaItemProvider = mediaItemProvider

        settingViewController.mediaItemKind = selectedMediaItemKind
       
        // Setup Storage Manager
        StorageManager.setup(withMediaItemKind: selectedMediaItemKind)

       
        // Reset MediaItemKind from ViewViewControllers
        homeViewController.reset()
        searchViewController.reset()
        favoritesViewController.reset()
        
    }
}
