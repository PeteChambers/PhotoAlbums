//
//  AlbumCell.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import UIKit

class AlbumCell: UICollectionViewCell
{
    
    @IBOutlet weak var albumTitle: UILabel!
    @IBOutlet weak var albumImageView: UIImageView!
    
    func configureCell(for album: AlbumViewModel) {
        
        albumTitle.text = album.title
        
        albumImageView.image = UIImage(named: "placeholder")
        albumImageView.tintColor = .black

//        if !product.image.isEmpty {
//
//            productImage.af.setImage(
//                withURL: URL(string: product.image)!,
//                placeholderImage: UIImage(named: "placeholder"),
//                imageTransition: .crossDissolve(0.2)
//            )
//        }
    }
}
