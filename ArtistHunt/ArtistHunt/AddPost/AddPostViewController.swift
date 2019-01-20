//
//  SecondViewController.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 25/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.
//

import UIKit
import YPImagePicker

class AddPostViewController: UIViewController {
    @IBOutlet weak var add_post_titleTxf: UITextField!
    @IBOutlet weak var add_post_descriptionTxf: UITextField!
    @IBOutlet weak var add_post_imageView: UIImageView!
    
    private var postViewModel = PostViewModel()
    private var imageSelected = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func post(_ sender: Any) {
        view.endEditing(true)
        
        guard let title = add_post_titleTxf.text, title.count > 0 else {
            return
        }
        guard let description = add_post_descriptionTxf.text, description.count > 0 else {
            return
        }
        
        let currentDate = Date()
        let format = DateFormatter.postFormatter
        
        let date = format.string(from: currentDate)
        
        if (imageSelected) {
            guard let imageData = add_post_imageView.image?.jpegData(compressionQuality: 0.75) else {
                return
            }
//            guard let directory = try? FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false) as NSURL else {
//                return
//            }
//            do {
//                try imageData.write(to: directory.appendingPathComponent("file.jpg")!)
//                
//            } catch {
//                print(error.localizedDescription)
//                return
//            }
            
            postViewModel.addImagePost(title: title, description: description, type: "IMAGE", user_id: AuthenticationController.getUserId()!, date: date, image: imageData)

        } else {
            postViewModel.addPost(title: title, description: description, type: "TEXT", user_id: AuthenticationController.getUserId()!, date: date)
        }
    }

    @IBAction func addPostImageClicked(_ sender: Any) {
        var config = YPImagePickerConfiguration()
        config.usesFrontCamera = true
        config.albumName = "Artist Hunt"
        config.showsCrop = .rectangle(ratio: 1)
        
        let picker = YPImagePicker(configuration: config)
        
        picker.didFinishPicking { [unowned picker] items, cancelled in
            if let photo = items.singlePhoto {
                self.add_post_imageView.contentMode = .scaleAspectFit
                self.add_post_imageView.image = photo.image
                self.imageSelected = true
            }
            if cancelled {
                self.imageSelected = false
                print("Image picking was canceled")
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
}


