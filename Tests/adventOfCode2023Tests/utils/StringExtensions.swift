//
//  StringExtensions.swift
//  adventOfCode2021
//
//  Created by Graham Berks on 28/11/2021.
//

import Foundation

extension String {
    var lines: [String] {
        self.components(separatedBy: "\n")
    }
    
    func toCharArray() -> [Character] {
        Array(self)
    }
    
    func toCharArraySlice() -> ArraySlice<Character> {
        ArraySlice(self.toCharArray())
    }
    
    func rightJustified(width: Int, truncate: Bool = false, pad: String = " ") -> String {
        guard width > count else {
            return truncate ? String(suffix(width)) : self
        }
        return String(repeating: pad, count: width - count) + self
    }
    
    func leftJustified(width: Int, truncate: Bool = false, pad: String = " ") -> String {
        guard width > count else {
            return truncate ? String(prefix(width)) : self
        }
        return self + String(repeating: pad, count: width - count)
    }
}

extension StringProtocol {
  subscript(offset: Int) -> Character {
    self[index(startIndex, offsetBy: offset)]
  }
}

extension Substring {
  func toCharArray() -> [Character] {
    Array(self)
  }
}
