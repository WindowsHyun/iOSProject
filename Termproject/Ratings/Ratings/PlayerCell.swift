//
//  PlayerCell.swift
//  Ratings
//
//  Created by kpugame on 2016. 4. 14..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var gameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    //Player가 변경될 떄 마다 프라퍼티 설정
    var player: Player!
        {
        didSet{
            gameLabel.text = player.game
            nameLabel.text = player.name
            ratingImageView.image = imageForRating(player.rating)
        }
    }
    
    //rating에 따라서 서로다른 별개수 이미지를 반환
    func imageForRating(rating:Int) ->UIImage?
    {
        let imageName = "\(rating)Stars"
        return UIImage(named: imageName)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
