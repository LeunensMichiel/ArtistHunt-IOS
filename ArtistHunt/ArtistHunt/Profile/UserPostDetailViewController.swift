//
//  UserPostDetailViewController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 20/01/2019.
//  Copyright © 2019 Leunes Media. All rights reserved.
//

import UIKit

class UserPostDetailViewController: UIViewController {
    @IBOutlet weak var imageDetail: UIImageView!
    @IBOutlet var titleDetail: UILabel!
    @IBOutlet weak var descriptionDetail: UILabel!
    @IBOutlet weak var dateDetail: UILabel!
    
    var post: RealmPost? {
        didSet {
            updateUI()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func updateUI() {
        loadViewIfNeeded()
        titleDetail.text = post?.title
        descriptionDetail.text = post?.description
        
        dateDetail.text = DateFormatter.postFormatter.string(from: (post?.date)!)
    }

}

extension UserPostDetailViewController: PostSelectionDelegate {
    func postSelected(_ postje: RealmPost) {
        post = postje
    }
}
