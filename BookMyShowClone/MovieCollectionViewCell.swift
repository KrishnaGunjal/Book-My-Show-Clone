//
//  MovieCollectionViewCell.swift
//  BookMyShowClone
//
//  Created by Krrish  on 21/10/18.
//  Copyright © 2018 Krrish . All rights reserved.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var progress: UIActivityIndicatorView!
    
    @IBOutlet weak var imgPoster: UIImageView!
    @IBOutlet weak var lableName: UILabel!
    @IBOutlet weak var labelGenre: UILabel!
}
