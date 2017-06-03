//
//  RestaurantCustomViewViewController.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/3/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit

class RestaurantCustomView: UIView {
    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var ratingScore: UILabel!
    @IBOutlet var ratingStar: [UIImageView]!
    @IBOutlet weak var ratingNumber: UILabel!
    @IBOutlet weak var address: UILabel!
    
    func configureCell(restaurant: Restaurant) {
        name.text = restaurant.name
        address.text = restaurant.address
        ratingScore.text = "\(restaurant.rating!)"
        ratingNumber.text = "\(restaurant.reviewCount!)"
        
        // Setting rating star image
        if var rateScore = restaurant.rating {
            for i in 0...4 {
                if rateScore >= 1.0 {
                    ratingStar[i].image = UIImage(named: "full-star")
                } else if rateScore > 0 {
                    ratingStar[i].image = UIImage(named: "half-star")
                } else {
                    ratingStar[i].image = UIImage(named: "empty-star")
                }
                rateScore = rateScore - 1
            }
        }
        
        if let url = restaurant.image {
            
             APICallUtil.shared.getImage(url: url, competitionHandle: { data in
             let image = UIImage(data: data)
             self.image.image = image
             }) 
        }
        
    }
    
    let nibName = "RestaurantCustomView"
    var view : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    // MARK: - Private Helper Methods
    
    // Performs the initial setup.
    private func setupView() {
        let view = viewFromNibForClass()
        
        view.frame = bounds
        
        // Auto-layout stuff.
        view.autoresizingMask = [
            UIViewAutoresizing.flexibleWidth,
            UIViewAutoresizing.flexibleHeight
        ]
         
        // Show the view.
        addSubview(view)
 
    }
    
    // Loads a XIB file into a view and returns this view.
    private func viewFromNibForClass() -> UIView {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        image.transform = CGAffineTransform(rotationAngle: -0.08)
    }
}


