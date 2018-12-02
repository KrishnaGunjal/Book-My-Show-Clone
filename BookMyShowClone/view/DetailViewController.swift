//
//  DetailViewController.swift
//  BookMyShowClone
//
//  Created by Krrish  on 22/10/18.
//  Copyright © 2018 Krrish . All rights reserved.
//

import UIKit
import youtube_ios_player_helper

class DetailViewController: UIViewController {
    @IBOutlet weak var YTView: YTPlayerView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLanguage: UILabel!
    @IBOutlet weak var lblRating: UILabel!
    @IBOutlet weak var lblGenre: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
     var movieDetail : movies!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = movieDetail.movieName
        lblName.text = movieDetail.movieName
        lblLanguage.text = movieDetail.language
        lblRating.text = "\(movieDetail.rating!)/10"
        lblGenre.text = movieDetail.genre
        lblDescription.text = movieDetail.synopsis
        let regexString = self.extractYoutubeIdFromLink(link: movieDetail.trailerURL)
        self.YTView.load(withVideoId: regexString!)
    }
    
    func extractYoutubeIdFromLink(link: String) -> String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        guard let regExp = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive) else {
            return nil
        }
        
        let nsLink = link as NSString
        let options = NSRegularExpression.MatchingOptions(rawValue: 0)
        let range = NSRange(location: 0,length: nsLink.length)
        let matches = regExp.matches(in: link as String, options:options, range:range)
        if let firstMatch = matches.first {
            return nsLink.substring(with: firstMatch.range)
        }
        return nil
    }

}
