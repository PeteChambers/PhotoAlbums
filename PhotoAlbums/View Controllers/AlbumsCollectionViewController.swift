//
//  AlbumsCollectionViewController.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 16/12/2020.
//

import Foundation
import UIKit

class AlbumsCollectionViewController: UICollectionViewController, UISearchBarDelegate {
    
    @IBOutlet weak var toggleAppearance: UISwitch!
    
    private var albumListVM: AlbumListViewModel!
    
    var currentSearchText: String = ""
    
    let numberOfItemsPerRow: CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.delegate = self
        collectionView.dataSource = self
        toggleAppearance.onTintColor = UIColor.black
        toggleAppearance.thumbTintColor = UIColor.white
        setup()
        
    }
    
    private func setup() {
        WebService().getAlbums { (albums) in
            self.albumListVM = AlbumListViewModel(albums: albums)
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        } error: { (error) in
            debugPrint(error.localizedDescription)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return albumListVM == nil ? 0 : self.albumListVM.numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if albumListVM.numberOfItemsInSection(section) == 0 {
            self.collectionView.setEmptyMessage("No Results\n\nThere were no results for '\(currentSearchText)'.  Only exact matches will be found")
        } else {
            self.collectionView.restore()
        }
        return albumListVM.numberOfItemsInSection(section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! AlbumCell
        let albumVM = self.albumListVM.albumtAtIndex(indexPath.row)
        cell.configureCell(for: albumVM)
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let photosCollectionVC = self.storyboard!.instantiateViewController(withIdentifier: "PhotosCollectionViewController") as! PhotosCollectionViewController
        let albumVM = self.albumListVM.albumtAtIndex(indexPath.row)
        photosCollectionVC.albumId = albumVM.id
        self.navigationController?.pushViewController(photosCollectionVC, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let searchView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "SearchBar", for: indexPath) as! SearchBarView
        searchView.albumCountLabel.text = albumListVM.numberOfItemsInSection(0) == 1 ? "\(albumListVM.numberOfItemsInSection(0)) album" : "\(albumListVM.numberOfItemsInSection(0)) albums"
        searchView.searchBar.autocapitalizationType = .none
        return searchView
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        currentSearchText = text
            WebService().searchAlbums(searchText: text) { (albums) in
                self.albumListVM = AlbumListViewModel(albums: albums)
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            } error: { (error) in
                self.createAlert(title: "Error", message: "No Albums Found")
            }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard let text = searchBar.text else { return }
        if text.isEmpty {
            setup()
        }
    }
    
    func createAlert(title: String, message: String, completion: ((UIAlertAction) -> Void)? = nil) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: completion))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func toggleAppearance(_ sender: Any) {
        UIView.transition (with: self.view, duration: 0.5, options: .transitionFlipFromBottom, animations: {
            self.navigationController?.overrideUserInterfaceStyle = self.toggleAppearance.isOn ? .light : .dark
        }, completion: nil)
    }
}

extension AlbumsCollectionViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let spacingBetweenCells: CGFloat = 20
        
        let totalSpacing = (2 * spacingBetweenCells) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        
        let size = (collectionView.bounds.width - totalSpacing)/numberOfItemsPerRow
        return CGSize(width: size, height: size)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 30
    }
}

extension UICollectionView {

    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width - 40, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
