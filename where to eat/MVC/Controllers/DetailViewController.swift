//
//  DetailViewController.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/3/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var image:UIImageView!
    @IBOutlet weak var tableView:UITableView!
    
    var restaurant: Restaurant!
    var reviews = [UserReview]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.hidesBarsOnSwipe = true
          APICallUtil.shared.getRestaurantsReview(id: restaurant.id) { result in
            if let reviews = result.value(forKey: "reviews") as? [NSDictionary] {
                for place in reviews {
                    let review = UserReview(review: place)
                    self.reviews.append(review)
                    self.tableView.reloadData()
                }
            }
        }
        
        image.imageFromServerURL(urlString: restaurant.image)

        let nib = UINib(nibName: "RestaurantDetailTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "restaurantInfo")
        
        let nib2 = UINib(nibName: "userReviewTableViewCell", bundle: nil)
        tableView.register(nib2, forCellReuseIdentifier: "userReviews")
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 300
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviews.count + 1
    }
    
    
    /// configure custom cell
    ///
    /// - Parameters:
    ///   - tableView: tableView
    ///   - indexPath: indexPath
    /// - Returns: custom uitable view cell
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            // Info cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "restaurantInfo") as! RestaurantDetailTableViewCell
            cell.configureCell(restaurant: restaurant)
            return cell
        } else {
            // Review cells
            let cell = tableView.dequeueReusableCell(withIdentifier: "userReviews", for: indexPath) as! userReviewTableViewCell
            cell.configureCell(review: reviews[indexPath.row - 1])
            return cell
        }
    }
    
    
    
}
