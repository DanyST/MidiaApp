//
//  UIImageView+Networking.swift
//  Midia
//
//  Created by Luis Herrera Lillo on 14-11-19.
//  Copyright © 2019 Luis Herrera Lillo. All rights reserved.
//

import UIKit

extension UIImageView {
    
    func loadImage(fromURL url: URL) {
        DispatchQueue.global().async { [unowned self] in
            guard let data = try? Data(contentsOf: url),
                let image = UIImage(data: data) else { return }
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
}
