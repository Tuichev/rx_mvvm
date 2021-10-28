//
//  MainTableViewCell.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa

class MainTableViewCell: UITableViewCell {
    @IBOutlet private weak var userImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    
    private let placeholderImage = UIImage(systemName: "person")
    private let bag = DisposeBag()
    
    let item: PublishSubject<UsersModel.UserEntity> = .init()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupDataBinding()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        userImageView.sd_cancelCurrentImageLoad()
        userImageView.image = placeholderImage
        
        nameLabel.text = nil
    }
    
    private func setupDataBinding() {
        item.asObservable()
            .subscribe(onNext: {
                data in
                
                let imageLink: Observable<String?> = Observable.of(data.avatar)
                let nameValue: Observable<String?> = Observable.of(data.firstName)
                
                _ = nameValue.bind(to: self.nameLabel.rx.text)
                _ = imageLink.bind(onNext: { link in
                    let imageUrl = URL(string: link ?? "")
                    self.userImageView.sd_setImage(with: imageUrl, placeholderImage: self.placeholderImage, options: [], completed: nil)
                })
            }).disposed(by: bag)
    }
}
