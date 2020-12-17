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
    
    private var photoListVM: PhotoListViewModel!
    var albumId: Int?
    var selectedIndexPath: IndexPath!
    let numberOfItemsPerRow: CGFloat = 3.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        collectionView.delegate = self
        collectionView.dataSource = self
        
    }
    
    private func setup() {
        WebService().getPhotos(albumId: albumId!) { (photos) in
            self.photoListVM = PhotoListViewModel(photos: photos)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } error: { (error) in
            debugPrint(error.localizedDescription)
        }

    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return photoListVM == nil ? 0 : self.photoListVM.numberOfSections
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
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath)
    {

        let photoVM = self.photoListVM.photoAtIndex(indexPath.row)

        let imageUrl = URL(string: photoVM.fullSizeImage)!

        let imageData = try! Data(contentsOf: imageUrl)

        let image = UIImage(data: imageData)
        self.selectedIndexPath = indexPath
        self.performSegue(withIdentifier: "ShowDetail", sender: image)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "ShowDetail" {
            let detailVC = segue.destination as! PhotoDetailViewController
            detailVC.image = sender as? UIImage
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let photoCountView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "PhotoCountView", for: indexPath) as! PhotoCountView
        photoCountView.photoCountLabel.text =  "\(photoListVM.numberOfItemsInSection(0)) photos"
        return photoCountView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}

extension PhotosCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = collectionView.frame.width / numberOfItemsPerRow
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension PhotosCollectionViewController : ZoomingViewController
{
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




