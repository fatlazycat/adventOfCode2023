//
//  SequenceExtensions.swift
//  adventOfCode2021
//
//  Created by Graham Berks on 10/12/2021.
//

import Foundation

extension Sequence where Element: Hashable {
    func histogram() -> [Element: Int] {
        return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
    }
}
