//
//  File.swift
//  iOS_PresentationLayer
//
//  Created by Dmytro Yurchenko on 2025-02-03.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, bundle: .module, comment: "")
    }
}
