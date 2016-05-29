//
//  Player.swift
//  Ratings
//
//  Created by kpugame on 2016. 4. 12..
//  Copyright © 2016년 kpugame. All rights reserved.
//

import UIKit

struct Player
{
    var name: String?
    var game: String?
    var rating: Int
    
    init(name: String?, game: String?, rating: Int)
    {
        self.name = name
        self.game = game
        self.rating = rating
    }
}