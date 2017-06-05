//
//  RestaurantDetailView.swift
//  where to eat
//
//  Created by DucLA on 6/5/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit

class RestaurantDetailView: UIView {
    
    @IBOutlet weak var categories: UILabel!
    @IBOutlet weak var address: UILabel!
    @IBOutlet weak var fone: UIButton!
    
    func configureCell(restaurant: Restaurant) {
        categories.text = "\(restaurant.categories!)"
        address.text = "\(restaurant.address!)"
        fone.titleLabel?.text = "\(restaurant.foneNumber.toPhoneNumber())"
    }

    var contentView : UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    func xibSetup() {
        contentView = loadViewFromNib()
        
        // use bounds not frame or it'll be offset
        contentView.frame = bounds
        
        // Make the view stretch with containing view
        contentView.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
        
        // Adding custom subview on top of our view (over any custom drawing > see note below)
        addSubview(contentView)
    }
    
    func loadViewFromNib() -> UIView! {
        
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    @IBAction func callRestaurant(_ sender: UIButton) {
        if let number = sender.titleLabel?.text {
            if let url = URL(string: "tel://\(number)"), UIApplication.shared.canOpenURL(url) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(url)
                }
            }
        }
    }

}
