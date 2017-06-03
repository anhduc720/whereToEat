//
//  userReviewTableViewCell.swift
//  where to eat
//
//  Created by Le Anh Duc on 6/3/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import UIKit

class userReviewTableViewCell: UITableViewCell {
    @IBOutlet weak var avatar: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var comment: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var score: UILabel!
    @IBOutlet var ratingStar: [UIImageView]!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(review: UserReview) {
        avatar.imageFromServerURL(urlString: review.userImage)
        name.text = review.userName!
        comment.text = review.text!
        date.text = review.time
        score.text = "\(review.rating!)"

        // Setting rating star image
        if var rateScore = review.rating {
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
    }
    
}
