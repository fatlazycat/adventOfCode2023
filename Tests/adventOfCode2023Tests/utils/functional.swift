//
//  functional.swift
//  adventOfCode2021
//
//  Created by Graham Berks on 02/12/2021.
//

import Foundation

func foldl<S: Sequence,E>(sequence: S, base:E, transform:(_ acc: E, _ item: S.Element) -> E) -> E {
    var result = base
    for item in sequence {
        result = transform(result, item)
    }
    return result
}

infix operator >>> : RangeFormationPrecedence
func >>><Bound>(maximum: Bound, minimum: Bound) -> ReversedCollection<Range<Bound>> where Bound : Strideable {
    return (minimum..<maximum).reversed()
}
