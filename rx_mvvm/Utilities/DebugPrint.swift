//
//  DebugPrint.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 28.10.2021.
//

import Foundation

public func printDebug(_ items: Any...) {
    #if DEBUG
    for item in items {
        Swift.print(item)
    }
    #endif
}
