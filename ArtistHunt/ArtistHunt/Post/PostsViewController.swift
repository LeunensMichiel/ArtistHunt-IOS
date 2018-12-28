//
//  FirstViewController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 25/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import UIKit
import RxSwift
import Nuke
import RealmSwift

class PostsViewController: UICollectionViewController {
    private let localDB = ArtisthuntRealmDb()
    private let formatter = DateFormatter()
    private let SERVER_IMG_URL = "http://projecten3studserver03.westeurope.cloudapp.azure.com:3001/images/"
    private lazy var posts: Results<RealmPost> = {
        localDB.getAllPosts()
    }()
    
    
    var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.size.width
        layout.estimatedItemSize = CGSize(width: width, height: 10)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(PostCollectionViewCell.self, forCellWithReuseIdentifier: "postCell")
        collectionView?.collectionViewLayout = layout
        // Do any additional setup after loading the view, typically from a nib.
        formatter.dateFormat = "dd-MM-yyyy  hh:mm"
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let postCell = collectionView.dequeueReusableCell(withReuseIdentifier: "postCell", for: indexPath) as! PostCollectionViewCell

        
        postCell.post_title.text = posts[indexPath.row].title
        postCell.post_description.text = posts[indexPath.row].postdescription
        
        if (posts[indexPath.row].post_image_filename != nil) {
            postCell.imageWidth?.isActive = true
            postCell.imageHeight?.isActive = true
            let url = URL(string: SERVER_IMG_URL + posts[indexPath.row].post_image_filename!)
            Nuke.loadImage(with: url!, options: ImageLoadingOptions(transition: .fadeIn(duration: 0.33)), into: postCell.post_image)
        } else {
            postCell.imageWidth?.isActive = false
            postCell.imageHeight?.isActive = false
        }
        
        postCell.post_date.text = formatter.string(from: posts[indexPath.row].date!)
        
        return postCell
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
        super.traitCollectionDidChange(previousTraitCollection)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        layout.estimatedItemSize = CGSize(width: view.bounds.size.width, height: 10)
        layout.invalidateLayout()
        super.viewWillTransition(to: size, with: coordinator)
    }
    

}

