//
//  MovieCollectionViewController.swift
//  BookMyShowClone
//
//  Created by Krrish  on 21/10/18.
//  Copyright © 2018 Krrish . All rights reserved.
//

import UIKit
private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController {
    static var moviesArray = [movies]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Movies"
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        loadData()
        sleep(4)
    }
    func loadData(){
        let url = URL(string: "http://data.in.bookmyshow.com/getData.aspx?cc=&cmd=GETEVENTLIST&dt=&et=MT&f=json&lg=72.842588&lt=19.114186&rc=MUMBAI&sr=&t=a54a7b3aba576256614a")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            if error != nil{
            print("Error")
            }
            do{
                let rootDictionary = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSDictionary
                let subDictionary = rootDictionary.object(forKey: "BookMyShow")as! NSDictionary
                let rootArray = subDictionary.object(forKey: "arrEvent")as! NSArray
                for item in rootArray{
                    let detailDictionary = item as! NSDictionary
                    let movieObject = movies()
                    movieObject.movieName = detailDictionary.object(forKey: "EventTitle")as! String
                    movieObject.genre = detailDictionary.object(forKey: "Genre")as! String
                    movieObject.rating = detailDictionary.object(forKey: "Ratings")as! String
                    movieObject.language = detailDictionary.object(forKey: "Language")as! String
                    movieObject.synopsis = detailDictionary.object(forKey: "EventSynopsis")as! String
                    movieObject.trailerURL = detailDictionary.object(forKey: "TrailerURL")as! String
                    let posterURL = detailDictionary.object(forKey: "BannerURL")as! String
                    let imageData = try! Data.init(contentsOf: URL(string: posterURL)!)
                    movieObject.poster = UIImage(data: imageData)
           MovieCollectionViewController.moviesArray.append(movieObject)
                }
                self.collectionView?.reloadData()
            }
        }
        task.resume()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieCollectionViewController.moviesArray.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! MovieCollectionViewCell
        let tempObject = MovieCollectionViewController.moviesArray[indexPath.row]
        cell.progress.startAnimating()
        cell.lableName.text =  tempObject.movieName
        cell.labelGenre.text = tempObject.genre
        cell.imgPoster.image = tempObject.poster
        cell.progress.stopAnimating()
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "detailVC")as! DetailViewController
        let object = MovieCollectionViewController.moviesArray[indexPath.row]
        detail.movieDetail = object
        self.navigationController?.pushViewController(detail, animated: true)
    }
    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

