//
//  StringExtensions.swift
//  where to eat
//
//  Created by DucLA on 6/5/17.
//  Copyright © 2017 Le Anh Duc. All rights reserved.
//

import Foundation

extension String {
    public func toPhoneNumber() -> String {
        return self.replacingOccurrences(of: "(\\d{3})(\\d{3})(\\d+)", with: "($1) $2-$3", options: .regularExpression, range: nil)
    }
}
