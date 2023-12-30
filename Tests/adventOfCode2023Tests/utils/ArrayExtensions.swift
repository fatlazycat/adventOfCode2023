/**
 
 ## Example
 
 To convert a tuple of Ints into an array of ints:
 
 ```
 let ints = (10, 20, 30)
 let result = [Int].fromTuple(ints)
 print(result!) // prints Optional([10, 20, 30])
 ```
 
 */

import Foundation
import CloudKit

extension Array where Element: Equatable & Hashable {
    
    public func removeElement(at index: Int) -> Array {
        var arrayCopy = self
        arrayCopy.remove(at: index)
        return arrayCopy
    }
    
    func appendElement(_ element: Element) -> Array {
        var arrayCopy = self
        arrayCopy.append(element)
        return arrayCopy
    }
    
    func replaceAtIndex(_ index: Int, _ element: Element) -> Array {
        var arrayCopy = self
        arrayCopy[index] = element
        return arrayCopy
    }
    
    func dropFirstArray() -> Array {
        Array(self.dropFirst())
    }
    
    func dropFirstArray(_ i: Int) -> Array {
        Array(self.dropFirst(i))
    }
    
    func sub(_ bounds: ClosedRange<Int>) -> Array {
        return Array(self[bounds])
    }
    
    func sub(_ bounds: PartialRangeFrom<Int>) -> Array {
        return Array(self[bounds])
    }
    
    func sub(_ bounds: Range<Int>) -> Array {
        return Array(self[bounds])
    }
    
    func appendOptionalAndCompact(_ item: Element?) -> Array<Element> {
        return (self + [item]).compactMap{ $0 }
    }
    
    
    func histogram() -> [Element: Int] {
        return self.reduce(into: [:]) { counts, elem in counts[elem, default: 0] += 1 }
    }
    
    func counts() -> [Element : Int] {
        var result: [Element : Int] = [:]
        for item in self {
            if let entry = result[item] {
                result[item] = entry + 1
            }
            else {
                result[item] = 1
            }
        }
        
        return result
    }
    
    func count(where predicate: (Element) throws -> Bool) rethrows -> Int {
        var count = 0
        for element in self {
            if try predicate(element) {
                count += 1
            }
        }
        return count
    }
    
    func windowed(size: Int, step: Int = 1, partialWindows: Bool = false) -> [[Element]] {
        let count = self.count
        var index = 0
        var result: [[Element]] = []
        while (index < count) {
            let windowSize = Swift.min(size, count - index)
            if windowSize < size && !partialWindows {
                break
            }
            result.append(Array(self[index ..< (index + windowSize)]))
            index += step
        }
        return result
    }
    
    func chunked(size: Int, partialWindows: Bool = false) -> [[Element]] {
        return self.windowed(size: size, step: size, partialWindows: partialWindows)
    }
    
    public func toDictionary<Key: Hashable>(with selectKey: (Element) -> Key) -> [Key:Element] {
        var dict = [Key:Element]()
        for element in self {
            dict[selectKey(element)] = element
        }
        return dict
    }
    
    public func toSet() -> Set<Self.ArrayLiteralElement> {
        Set(self)
    }
    
    public func groupBy<Key: Hashable>(by keyForValue: (Self.Element) throws -> Key) rethrows -> Dictionary<Key, [Element]> {
        return try Dictionary(grouping: self, by: keyForValue)
    }
    
    public func toString() -> String where Self.Element == Character {
        return String(self)
    }
    
    /**
     Attempt to convert a tuple into an Array.
     
     - Parameter tuple: The tuple to try and convert. All members must be of the same type.
     - Returns: An array of the tuple's values, or `nil` if any tuple members do not match the `Element` type of this array.
     */
    static func fromTuple<Tuple>(_ tuple: Tuple) -> [Element]? {
        let val = Array<Element>.fromTupleOptional(tuple)
        return val.allSatisfy({ $0 != nil }) ? val.map { $0! } : nil
    }
    
    /**
     Convert a tuple into an array.
     
     - Parameter tuple: The tuple to try and convert.
     - Returns: An array of the tuple's values, with `nil` for any values that could not be cast to the `Element` type of this array.
     */
    static func fromTupleOptional<Tuple>(_ tuple: Tuple) -> [Element?] {
        return Mirror(reflecting: tuple)
            .children
            .filter { child in
                (child.label ?? "x").allSatisfy { char in ".1234567890".contains(char) }
            }.map { $0.value as? Element }
    }
    
    func getAllUniquePairs() -> [(Element, Element)] {
        var pairs = [(Element, Element)]()
        
        for (index, firstElement) in self.enumerated() {
            for secondElement in self[(index + 1)...] {
                pairs.append((firstElement, secondElement))
            }
        }
        
        return pairs
    }
    
    func anySatisfy(_ predicate: (Element) -> Bool) -> Bool {
        for element in self {
            if predicate(element) {
                return true
            }
        }
        return false
    }
    
    func allPairings() -> [(Element, Element)] {
        var pairings: [(Element, Element)] = []
        
        for (i, element1) in self.enumerated() {
            for element2 in self[(i + 1)...] {
                pairings.append((element1, element2))
            }
        }
        
        return pairings
    }
    
}
