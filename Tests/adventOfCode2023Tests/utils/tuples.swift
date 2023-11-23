//
//  tuples.swift
//  adventOfCode2021
//
//  Created by Graham Berks on 02/12/2021.
//

import Foundation

func +<T : Numeric> (x: (T, T), y: (T, T)) -> (T, T) {
    return (x.0 + y.0, x.1 + y.1)
}

func +<T : Numeric> (x: (T, T, T), y: (T, T, T)) -> (T, T, T) {
    return (x.0 + y.0, x.1 + y.1, x.2 + y.2)
}

func +<T : Numeric> (x: (T, T, T, T), y: (T, T, T, T)) -> (T, T, T, T) {
    return (x.0 + y.0, x.1 + y.1, x.2 + y.2, x.3 + y.3)
}
