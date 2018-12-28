//
//  PostCollectionViewCell.swift
//  ArtistHunt
//
//  Created by Michiel Leunens on 27/12/2018.
//  Copyright © 2018 Leunes Media. All rights reserved.

// SOURCE FOR FULL WIDTH AND DYNAMIC HEIGHT CELL INFO: https://github.com/andreatoso/UICollectionViewCell-dynamic-height-swift/blob/master/AutoResizingCollectionView/ViewController.swift
// Looks like android is a bit better in this regard, as you don't have to write boilerplate code to have a full width cell.

import UIKit

class PostCollectionViewCell: UICollectionViewCell {
    var imageWidth: NSLayoutConstraint?
    var imageHeight: NSLayoutConstraint?
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: bounds.size.width)
        width.isActive = true
        return width
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.translatesAutoresizingMaskIntoConstraints = false
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = bounds.size.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 1))
    }
    
    fileprivate func setupViews() {
        contentView.addSubview(post_date)
        post_date.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        post_date.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -8).isActive = true
        //        post_date.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        contentView.addSubview(post_title)
        post_title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        post_title.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        post_title.rightAnchor.constraint(equalTo: post_date.leftAnchor, constant: 8).isActive = true
        //        post_title.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        contentView.addSubview(post_image)
        post_image.topAnchor.constraint(equalTo: post_title.bottomAnchor, constant: 16).isActive = true
        post_image.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        post_image.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        imageWidth = post_image.widthAnchor.constraint(equalTo: contentView.widthAnchor)
        imageHeight = post_image.heightAnchor.constraint(equalTo: post_image.widthAnchor, multiplier: 1/1)
        imageWidth?.isActive = true
        imageHeight?.isActive = true
        
        contentView.addSubview(post_description)
        post_description.topAnchor.constraint(equalTo: post_image.bottomAnchor, constant: 16).isActive = true
        post_description.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 8).isActive = true
        post_description.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 8).isActive = true
        post_description.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true
        
        if let lastSubview = contentView.subviews.last {
            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 8).isActive = true
        }
    }
    
    let post_title: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.textColor = #colorLiteral(red: 0.1199426726, green: 0.1199426726, blue: 0.1199426726, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let post_description: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let post_date: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.textColor = #colorLiteral(red: 0.3333333433, green: 0.3333333433, blue: 0.3333333433, alpha: 1)
        label.font = label.font.withSize(10)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let post_image: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        return imageview
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.post_image.image = nil
    }
    
}
