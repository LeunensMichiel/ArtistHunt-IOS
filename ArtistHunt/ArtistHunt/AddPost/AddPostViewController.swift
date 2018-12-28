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
        
        if (add_post_imageView.image != nil) {
            var imageData = add_post_imageView.image?.jpegData(compressionQuality: 1)

        } else {
            
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
                print(photo.image)
            }
            if cancelled {
                print("Image picking was canceled")
            }
            picker.dismiss(animated: true, completion: nil)
        }
        present(picker, animated: true, completion: nil)
    }
}


