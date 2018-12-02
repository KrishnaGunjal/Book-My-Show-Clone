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
    var loader : UIActivityIndicatorView!
    
    static var moviesArray = [movies]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loader = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        loader.center = view.center
        loader.isHidden = true
        self.view.addSubview(loader)
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
                    if (try! Data.init(contentsOf: URL(string: posterURL)!) == nil){
                        movieObject.poster = UIImage(named: "IMG_20181003_195800")
                    }
                    else{
                        let imageData = try! Data.init(contentsOf: URL(string: posterURL)!)
                        movieObject.poster = UIImage(data: imageData)
                    }
           MovieCollectionViewController.moviesArray.append(movieObject)
                }
                self.collectionView?.reloadData()
            }
        }
        task.resume()
    }
    func displayActivityIndicatorView(){
        UIApplication.shared.beginIgnoringInteractionEvents()
        self.view.bringSubview(toFront: self.loader)
        self.loader.isHidden = false
        self.loader.startAnimating()
    }
    
    func hideActivityIndicatorView(){
        if !self.loader.isHidden{
            DispatchQueue.main.async {
                UIApplication.shared.endIgnoringInteractionEvents()
                self.loader.stopAnimating()
                self.loader.isHidden = true
            }
        }
        
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
        cell.lableName.text =  tempObject.movieName
        cell.labelGenre.text = tempObject.genre
        cell.imgPoster.image = tempObject.poster
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detail = storyboard?.instantiateViewController(withIdentifier: "detailVC")as! DetailViewController
        let object = MovieCollectionViewController.moviesArray[indexPath.row]
        detail.movieDetail = object
        self.navigationController?.pushViewController(detail, animated: true)
    }

}

