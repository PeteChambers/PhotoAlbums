//
//  UICollectionView+Extensions.swift
//  PhotoAlbums
//
//  Created by Peter Chambers on 18/12/2020.
//

import UIKit

extension UICollectionView {

    func setEmptyMessage(boldText: String, normalText: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.attributedText =
            NSMutableAttributedString()
                .bold(boldText)
                .normal(normalText)
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        self.backgroundView = messageLabel;
    }

    func restore() {
        self.backgroundView = nil
    }
}
