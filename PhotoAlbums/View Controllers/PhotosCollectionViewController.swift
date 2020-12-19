//
//  PhotosCollectionViewController.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import Foundation
import UIKit
import Alamofire
import AlamofireImage

class PhotosCollectionViewController: UICollectionViewController {
    
    // MARK: Properties
    
    private var photoListVM = PhotoListViewModel()
    var albumId: Int?
    var selectedIndexPath: IndexPath!
    let numberOfItemsPerRow: CGFloat = 3.0
    
    // MARK: Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    // assign delegate and get photos
    
    private func setup() {
        photoListVM.delegate = self
        if let albumId = albumId {
            // get photos
            photoListVM.getPhotos(albumId: albumId)
        }
    }
    
    // MARK: CollectionView Methods
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.photoListVM.numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoListVM.numberOfItemsInSection(section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        cell.photoImageView.image = UIImage(named: "placeholder")
        let photoVM = self.photoListVM.photoAtIndex(indexPath.row)
        cell.configureCell(for: photoVM)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photoVM = self.photoListVM.photoAtIndex(indexPath.row)
        let imageUrl = URL(string: photoVM.fullSizeImage)!
        self.selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "ShowDetail", sender: imageUrl)
    }
    
    // prepare full size image for display
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetail" {
            let detailVC = segue.destination as! PhotoDetailViewController
            let imageData = try! Data(contentsOf: sender as! URL)
            let image = UIImage(data: imageData)
            detailVC.image = image
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let photoCountView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PhotoCountView", for: indexPath) as! PhotoCountView
        photoCountView.photoCountLabel.text =  "\(photoListVM.numberOfItemsInSection(0)) photos"
        return photoCountView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func createAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }

}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacingBetweenCells: CGFloat = 1
        let totalSpacing = (2 * spacingBetweenCells) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let size = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: size, height: size)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension PhotosCollectionViewController : ZoomingViewController {
    func zoomingBackgroundView(for transition: ZoomTransitioningDelegate) -> UIView? {
        return nil
    }
    
    func zoomingImageView(for transition: ZoomTransitioningDelegate) -> UIImageView? {
        if let indexPath = selectedIndexPath {
            let cell = collectionView?.cellForItem(at: indexPath) as! PhotoCell
            return cell.photoImageView
        }
        
        return nil
    }
}

// AlbumListViewDelegate implementation

extension PhotosCollectionViewController : PhotoListViewDelegate {
    func showPhotos() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    func failure(message: String) {
        DispatchQueue.main.async {
            self.createAlert(title: "", message: message)
        }
    }
}




