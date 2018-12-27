//
//  FirstViewController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 25/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import UIKit

class PostsViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    let titles = ["Haha dit is keigrappig!", "White Label zoekt band!!", "DJ zoekt back2backmattie"]
    let images = [UIImage(named: "image1"), UIImage(named: "image2"), UIImage(named: "image3")]
    let descriptions = ["Bladiebla", "Haahahahahaaaaa loooool", "WATTEFOK OFWEL OFWA OFNI"]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCollectionViewCell
        
        postCell.post_title.text = titles[indexPath.row]
        postCell.post_description.text = descriptions[indexPath.row]
        postCell.post_image.image = images[indexPath.row]
        postCell.post_date.text = "27/12/2018 17:32"
        
        return postCell
    }
    
}

