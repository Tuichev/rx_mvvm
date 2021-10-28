//
//  MainTableViewCell.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import UIKit
import SDWebImage

class MainTableViewCell: UITableViewCell {
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private let placeholderImage = UIImage(systemName: "person")
   
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userImageView.sd_cancelCurrentImageLoad()
        userImageView.image = placeholderImage
        
        nameLabel.text = nil
    }
     
    func display(data: UsersModel.UserEntity) {
        let imageUrl = URL(string: data.avatar ?? "")
        
        self.nameLabel.text = data.firstName
        self.userImageView.sd_setImage(with: imageUrl, placeholderImage: self.placeholderImage, options: [], completed: nil)
    }
}
