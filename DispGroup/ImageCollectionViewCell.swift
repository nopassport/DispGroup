//
//  ImageCollectionViewCell.swift
//  DispGoup
//
//  Created by Volodymyr D on 20.02.2023.
//

import UIKit

class ImageCollectionViewCell: UICollectionViewCell {
    
    let spiner = UIActivityIndicatorView(style: .large)
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true 
        spiner.startAnimating()
        return imageView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = bounds
        contentView.addSubview(imageView)
        imageView.addSubview(spiner)
        spiner.center = imageView.center
        spiner.color = .black
    }
    
    public func set(image: UIImage?){
        imageView.image = image
        spiner.stopAnimating()
    }
    
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        spiner.stopAnimating()
    }
}
