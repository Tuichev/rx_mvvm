//
//  ViewController.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 19.10.2021.
//

import UIKit
import RxSwift
import RxCocoa

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = UsersViewModel()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }

    private func setupViews() {
        setupTableView()
    }
    
    private func setupTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        
        tableView.register(MainTableViewCell.self)
        tableView.tableFooterView = UIView()
        
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: MainTableViewCell.identifier, cellType: MainTableViewCell.self)) { (row,item,cell) in
            cell.display(image: item.avatar, name: item.firstName)
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(UsersModel.UserEntity.self).subscribe(onNext: { item in
            print("SelectedItem: \(item.id)")
        }).disposed(by: bag)
        
        viewModel.fetchData()
    }
}

extension MainViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
