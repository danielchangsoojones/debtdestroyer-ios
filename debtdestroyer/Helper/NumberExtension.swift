//
//  NumberExtension.swift
//  debtdestroyer
//
//  Created by Daniel Jones on 9/29/22.
//

import Foundation

extension Double {
    var toPrice: String {
        let price = String(format: "$%.02f", self)
        return price
    }
}
