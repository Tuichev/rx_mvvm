//
//  MainTableViewCell.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    private let placeholderImage = UIImage(systemName: "person")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userImageView.sd_cancelCurrentImageLoad()
        userImageView.image = placeholderImage
        
        nameLabel.text = nil
    }
}

extension MainTableViewCell {
    
    func display(image: String?, name: String?) {
        let imageUrl = URL(string: image ?? "")
        userImageView.sd_setImage(with: imageUrl, placeholderImage: placeholderImage, options: [], completed: nil)
        
        nameLabel.text = name
    }
}
