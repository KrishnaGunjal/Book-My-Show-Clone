//
//  ViewController.swift
//  BookMyShowClone
//
//  Created by Krrish  on 21/10/18.
//  Copyright © 2018 Krrish . All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tagline: UILabel!
    @IBOutlet weak var logo: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        logo.image = UIImage(named: "bookmyshow.jpg")
        tagline.text = "Movies. Plays. Events. Sports"
        push()
    }
    func push(){
        var collectionVC = storyboard?.instantiateViewController(withIdentifier: "collection")as! MovieCollectionViewController
        self.navigationController?.pushViewController(collectionVC, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

