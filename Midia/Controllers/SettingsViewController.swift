//
//  ConfigurationViewController.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 02-12-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    // MARK: - Properties
    var mediaItemKind: MediaItemKind!
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let midiaTabBarController = self.tabBarController as? MidiaTabBarViewController else { return }
        
        midiaTabBarController.update(with: mediaItemKind)        
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return SettingsSection.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = SettingsSection(rawValue: section) else { return 0 }
        
        switch section {
        case .mediaItemKind:
            return MediaItemKindOptions.allCases.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChangeMediaItemKindTableViewCell.reuseIdentifier, for: indexPath) as! ChangeMediaItemKindTableViewCell
        
        cell.mediaItemKind = mediaItemKind
        cell.delegate = self
        
        return cell
    }
}

// MARK: - ChangeMediaItemKindTableViewCellDelegate
extension SettingsViewController: ChangeMediaItemKindTableViewCellDelegate {
    func changeMediaItemKindTableViewCell(_ vc: ChangeMediaItemKindTableViewCell, didChangeMediaItemKind mediaItemKind: MediaItemKind) {
        
        guard let midiaTabBarController = self.tabBarController as? MidiaTabBarViewController else { return }
        
        midiaTabBarController.update(with: mediaItemKind)
    }
    
    
}
