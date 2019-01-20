//
//  ViewController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 25/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import UIKit
import Nuke
import YPImagePicker

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileUIImage: UIImageView!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    private var userViewModel = UserViewModel()
    private var postViewModel = PostViewModel()
    private let SERVER_IMG_URL = "http://projecten3studserver03.westeurope.cloudapp.azure.com:3001/images/"


    override func viewDidLoad() {
        super.viewDidLoad()
        updatedUI()
        // Do any additional setup after loading the view.
    }
    
    fileprivate func updatedUI() {
        profileName.text = userViewModel.user[0].firstname! + " " + userViewModel.user[0].lastname!

        if (userViewModel.user[0].profile_image_filename != nil) {
            let url = URL(string: SERVER_IMG_URL + userViewModel.user[0].profile_image_filename!)
            Nuke.loadImage(with: url!, options: ImageLoadingOptions(placeholder: UIImage(named: "person-icon"), transition: .fadeIn(duration: 0.2)), into: profileUIImage)
            Nuke.loadImage(with: url!, options: ImageLoadingOptions(transition: .fadeIn(duration: 0.5)), into: backgroundImage)
        }

        profileUIImage.layer.borderWidth = 5
        profileUIImage.layer.masksToBounds = false
        profileUIImage.layer.borderColor = UIColor.white.cgColor
        profileUIImage.layer.cornerRadius = profileUIImage.frame.height/2
        profileUIImage.clipsToBounds = true
    }
    
    @IBAction func profilePictureClicked(_ sender: Any) {
        var config = YPImagePickerConfiguration()
        config.usesFrontCamera = true
        config.albumName = "Artist Hunt"
        config.showsCrop = .rectangle(ratio: 1)
        
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if let photo = items.singlePhoto {
                self.profileUIImage.contentMode = .scaleAspectFit
                self.profileUIImage.image = photo.image
                self.backgroundImage.image = photo.image
            }
            if cancelled {
                print("Image picking was canceled")
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func logout(_ sender: Any) {
        AuthenticationController.logout()
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "loginVC") as! UINavigationController
        self.present(nextViewController, animated:true, completion:nil)
        
        //https://stackoverflow.com/questions/27374759/programmatically-navigate-to-another-view-controller-scene
    }
    
    @IBAction func showUserPosts(_ sender: Any) {
        performSegue(withIdentifier: "showUserPostsSegue", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Ik probeerde de link met het detailscherm hier werkende te krijgen, maar lukte hier niet helaas. Geen idee wat er foutliep.
        
        
//        if segue.identifier == "showUserPostsSegue" {
//            guard let splitViewController = segue.destination as? UISplitViewController,
//                let leftNavController = splitViewController.viewControllers.first as? UINavigationController,
//                let masterViewController = leftNavController.topViewController as? UserPostsControllerTableViewController,
//                let detailViewController = splitViewController.viewControllers.last as? UserPostDetailViewController
//                else { fatalError() }
//
//            detailViewController.post = postViewModel.userposts[0]
//
//            masterViewController.delegate = detailViewController
//        }
        if (segue.identifier == "showUserPostsSegue") {
            let splitController = segue.destination as! UserSplitViewController
            let leftNavController = splitController.viewControllers.first as? UINavigationController
            let masterViewController = leftNavController?.topViewController as? UserPostsControllerTableViewController
            let detailViewController = splitViewController?.viewControllers.last as? UserPostDetailViewController
    
            detailViewController?.post = postViewModel.userposts[0]
            
            masterViewController?.delegate = detailViewController
        }
    }
}
