//
//  LocalizationHelper.swift
//  rx_mvvm
//
//  Created by Vlad Tuichev on 28.10.2021.
//

import Foundation

extension String {
    func localization() -> String {
        return translation("Localizable", self)
    }
    
    fileprivate func translation(_ table: String, _ key: String, _ args: CVarArg...) -> String {
        let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
        return String(format: format, locale: Locale.current, arguments: args)
    }
}

private final class BundleToken {}
