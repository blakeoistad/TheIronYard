//
//  TuneCollectionViewCell.swift
//  SwiftTune
//
//  Created by Blake Oistad on 11/3/15.
//  Copyright © 2015 Blake Oistad. All rights reserved.
//

import UIKit

class TuneCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var artistNameLabel :UILabel!
    @IBOutlet var trackNameLabel :UILabel!
    @IBOutlet var artworkImageView :UIImageView!
    
//    #if os(tvOS)
//    override func didUpdateFocusInContext(context: UIFocusUpdateContext, withAnimationCoordinator coordinator: UIFocusAnimationCoordinator) {
//        if self.focused {
//            self.artworkImageView.adjustsImageWhenAncestorFocused = true
//        } else {
//            self.artworkImageView.adjustsImageWhenAncestorFocused = false
//        }
//    }
//    #endif
}
