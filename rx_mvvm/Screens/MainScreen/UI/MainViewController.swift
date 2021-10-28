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
    @IBOutlet private weak var tableView: UITableView!
    
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
        
        let isEmpty = tableView.rx.isEmpty(message: StringValues.emptyData.localization())
        viewModel.items.map({ $0.count <= 0 }).distinctUntilChanged().bind(to: isEmpty).disposed(by: bag)
        
        viewModel.items.bind(to: tableView.rx.items(cellIdentifier: MainTableViewCell.identifier, cellType: MainTableViewCell.self)) { row,item,cell in
            cell.display(data: item)
        }.disposed(by: bag)
        
        tableView.rx.modelSelected(UsersModel.UserEntity.self).subscribe(onNext: { item in
            self.showDetails(data: item)
        }).disposed(by: bag)
        
        viewModel.fetchData()
    }
    
    private func showDetails(data: UsersModel.UserEntity) {
        let vc = DetailScreenViewController.fromStoryboard
        vc.item = data
        present(vc, animated: true, completion: nil)
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}
