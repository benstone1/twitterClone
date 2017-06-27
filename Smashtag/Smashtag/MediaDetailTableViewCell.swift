//
//  MediaDetailTableViewCell.swift
//  Smashtag
//
//  Created by C4Q  on 6/23/17.
//  Copyright © 2017 C4Q . All rights reserved.
//

import UIKit
import Twitter

class MediaDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var mediaImageView: UIImageView!
    
    var selectedMediaItem: MediaItem? {
        didSet {
            updateUI()
        }
    }
    func updateUI() {
        guard let mediaItem = selectedMediaItem else {
            return
        }
        DispatchQueue.main.async { [weak self] in
            if let imageData = try? Data(contentsOf: mediaItem.url) {
                self?.mediaImageView.image = UIImage(data: imageData)
            }
        }
    }
    
}
