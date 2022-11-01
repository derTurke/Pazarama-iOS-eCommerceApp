//
//  Double+Extensions.swift
//  eCommerceApp
//
//  Created by GÜRHAN YUVARLAK on 1.11.2022.
//

import Foundation

extension Double {
    var priceFormatted: String {
        return String(format: "$%.2f", locale: Locale.current,self)
    }
}
