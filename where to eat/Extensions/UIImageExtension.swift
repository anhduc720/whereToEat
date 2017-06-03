//
//  UIImageExtension.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/3/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView {
    
    /// Load image from url
    ///
    /// - Parameter urlString: url of image
    public func imageFromServerURL(urlString: String) {
        URLSession.shared.dataTask(with: NSURL(string: urlString)! as URL, completionHandler: { (data, response, error) -> Void in
            
            if error != nil {
                print(error as Any)
                return
            }
            DispatchQueue.main.async(execute: { () -> Void in
                let image = UIImage(data: data!)
                self.image = image
            })
            
        }).resume()
    }
}


/// Circle view UIImage
class CircleView: UIImageView {
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.8
        layer.shadowOffset = CGSize(width: 1, height: 1)
        layer.shadowRadius = 5.0
        self.contentMode = .scaleAspectFill
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
}
