//
//  PhotoDetailViewController.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import UIKit
import Alamofire
import AlamofireImage

class PhotoDetailViewController: UIViewController {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    // MARK: Properties
    
    var image: UIImage!
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        photoImageView.image = image
    }
    
}

extension PhotoDetailViewController : ZoomingViewController {
    func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return nil
    }
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        return photoImageView
    }
}
