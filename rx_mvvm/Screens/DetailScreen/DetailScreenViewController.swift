//
//  DetailScreenViewController.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 25.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

class DetailScreenViewController: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var fullNameLabel: UILabel!
    
    let item: PublishSubject<UsersModel.UserEntity> = .init()
    
    private let placeholderImage = UIImage(systemName: "person")
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupDataBinding()
        setupViews()
    }

    private func setupDataBinding()  {
        item.asObservable()
            .subscribe(onNext: {
                data in
                
                var fullName =  (data.firstName ?? "")  +  " " +  (data.lastName ?? "")
                
                fullName = fullName.count > 1  ? fullName  : ""//1 is lenght of additional chars between first and last name
                
                let imageLink: Observable<String?> = Observable.of(data.avatar)
                let fullNameValue: Observable<String?> = Observable.of(fullName)
                let email: Observable<String?> = Observable.of(data.email)
                
                _ = email.bind(to: self.emailLabel.rx.text)
                _ = fullNameValue.bind(to: self.fullNameLabel.rx.text)
                _ = imageLink.bind(onNext: { link in
                    let imageUrl = URL(string: link ?? "")
                    self.imageView.sd_setImage(with: imageUrl, placeholderImage: self.placeholderImage, options: [], completed: nil)
                })
            }).disposed(by: bag)
    }
    
    private func setupViews() {
        self.imageView.viewCorner()
    }
}
