//
//  zip.swift
//  adventOfCode2021
//
//  Created by Graham Berks on 01/12/2021.
//

import Foundation

func zip2<A, B>(_ xs: [A], _ ys: [B]) -> [(A, B)] {
  var result: [(A, B)] = []
  (0..<min(xs.count, ys.count)).forEach { idx in
    result.append((xs[idx], ys[idx]))
  }
  return result
}

func zip3<A, B, C>(_ xs: [A], _ ys: [B], _ zs: [C]) -> [(A, B, C)] {
  return zip2(xs, zip2(ys, zs)) // [(A, (B, C))]
    .map { a, bc in (a, bc.0, bc.1) }
}

func zip2<A, B, C>(
  with f: @escaping (A, B) -> C
  ) -> ([A], [B]) -> [C] {

  return { zip2($0, $1).map(f) }
}

func zip3<A, B, C, D>(
  with f: @escaping (A, B, C) -> D
  ) -> ([A], [B], [C]) -> [D] {

  return { zip3($0, $1, $2).map(f) }
}
