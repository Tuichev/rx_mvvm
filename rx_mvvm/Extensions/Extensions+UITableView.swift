//
//  Extensions+UITableView.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 21.10.2021.
//

import UIKit

extension UITableView {
    func dequeue<T: UITableViewCell>(_ cell: T.Type, _ indexPath: IndexPath) -> T {
        return self.dequeueReusableCell(withIdentifier: cell.identifier, for: indexPath) as! T
    }
    
    func register<T: UITableViewCell>(_ cell: T.Type) {
        self.register(UINib(nibName: T.identifier, bundle: nil), forCellReuseIdentifier: T.identifier)
    }
}

