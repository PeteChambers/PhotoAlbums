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
    
    private var albumListVM = AlbumListViewModel()
    
    var currentSearchText: String = ""
    
    let numberOfItemsPerRow: CGFloat = 2.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        collectionView.delegate = self
        collectionView.dataSource = self
        setupAppearance()
        setup()
        
    }

    
    private func setup() {
        albumListVM.delegate = self
        albumListVM.getAlbums()
    }
    
    
    private func setupAppearance() {
        if self.traitCollection.userInterfaceStyle == .dark {
            toggleAppearance.onTintColor = UIColor.white
            toggleAppearance.thumbTintColor = UIColor.white
        } else {
            toggleAppearance.onTintColor = UIColor.black
            toggleAppearance.thumbTintColor = UIColor.white
        }
    }
 
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.albumListVM.numberOfSections
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if albumListVM.numberOfItemsInSection(section) == 0 {
            self.collectionView.setEmptyMessage(boldText: "No Results", normalText: "\n\nThere were no results for '\(currentSearchText)'.  Only exact matches will be found")
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
        albumListVM.searchAlbum(text: text)
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
        UIView.transition (with: self.view, duration: 0.8, options: .transitionCrossDissolve, animations: {
            if self.traitCollection.userInterfaceStyle == .dark {
                self.navigationController?.overrideUserInterfaceStyle = .light
            } else {
                self.navigationController?.overrideUserInterfaceStyle = .dark
            }
        }, completion: nil)
        setupAppearance()
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

extension AlbumsCollectionViewController : AlbumListViewDelegate {
    func showAlbums() {
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

