//
//  PhotoCell.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    // Cell configure method
    
    func configureCell(for photo: PhotoViewModel) {

        photoImageView.af.setImage(
                withURL: URL(string: photo.thumbnailImage)!,
                placeholderImage: UIImage(named: "placeholder"),
                imageTransition: .crossDissolve(0.2)
            )

    }
    
}
