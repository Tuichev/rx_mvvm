//
//  DetailScreenViewController.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 25.10.2021.
//

import UIKit

class DetailScreenViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var fullNameLabel: UILabel!
    
    var item: UsersModel.UserEntity?
    
    private let placeholderImage = UIImage(systemName: "person")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    private func setupViews() {
        let imageUrl = URL(string: item?.avatar ?? "")
        var fullName =  (item?.firstName ?? "")  +  " " +  (item?.lastName ?? "")
        fullName = fullName.count > 1  ? fullName  : ""//1 is lenght of additional chars between first and last name
        
        self.imageView.sd_setImage(with: imageUrl, placeholderImage: self.placeholderImage, options: [], completed: nil)
        self.emailLabel.text = item?.email
        self.fullNameLabel.text = fullName
        
        self.imageView.viewCorner()
    }
}
