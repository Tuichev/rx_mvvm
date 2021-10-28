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
    
    private let placeholderImage = UIImage(systemName: "person")
    private var data: UsersModel.UserEntity?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    func setupData(data: UsersModel.UserEntity)  {
        self.data = data
    }
    
    private func setupViews() {
        let imageUrl = URL(string: data?.avatar ?? "")
        var fullName =  (data?.firstName ?? "")  +  " " +  (data?.lastName ?? "")
        
        fullName = fullName.count > 1  ? fullName  : ""//1 is lenght of additional chars between first and last name
        
        self.imageView.sd_setImage(with: imageUrl, placeholderImage: placeholderImage, options: [], completed: nil)
        self.emailLabel.text = data?.email
        self.fullNameLabel.text =  fullName
        
        self.imageView.viewCorner()
    }
}
