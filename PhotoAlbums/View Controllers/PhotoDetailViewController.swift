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
    
    @IBOutlet weak var photoImageView: UIImageView!
    
    var image: UIImage!
    
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
