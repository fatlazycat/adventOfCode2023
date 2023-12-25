import Foundation
import CloudKit

extension Dictionary {
    func removeValueFor(forKey: Key) -> Dictionary {
        var dictCopy = self
        dictCopy.removeValue(forKey: forKey)
        return dictCopy
    }
}

extension Dictionary where Value: Collection, Value.Element: Equatable {
    mutating func addDistinctValue(forKey key: Key, value: Value.Element) {
        if var valuesArray = self[key] as? [Value.Element] {
            if !valuesArray.contains(value) {
                valuesArray.append(value)
                self[key] = valuesArray as? Value
            }
        } else {
            self[key] = [value] as? Value
        }
    }
}

extension Dictionary where Value: Sequence, Value.Element == Key, Key: Hashable {
    func reversedMappings() -> [Key: [Key]] {
        var reversed = [Key: [Key]]()

        for (key, valueArray) in self {
            for value in valueArray {
                reversed[value, default: []].append(key)
            }
        }

        return reversed
    }
}

extension Dictionary where Value: Collection, Value.Element: Hashable {
    func findKeysWithIdenticalValues() -> Set<[Key]> {
        var matches = Set<[Key]>()

        let keys = Array(self.keys)
        for i in 0..<keys.count {
            for j in (i + 1)..<keys.count {
                let key1 = keys[i]
                let key2 = keys[j]

                if let values1 = self[key1], let values2 = self[key2], Set(values1) == Set(values2) {
                    matches.insert([key1, key2].sorted(by: { "\($0)" < "\($1)" }))
                }
            }
        }

        return matches
    }
}

extension Dictionary where Value: Sequence, Value.Element == Key, Key: Hashable {
    func findKeysWhereValueIsContainedInAnother() -> Set<[Key]> {
        var matches = Set<[Key]>()

        let keys = Array(self.keys)
        for i in 0..<keys.count {
            for j in 0..<keys.count where i != j {
                let key1 = keys[i]
                let key2 = keys[j]

                if let values1 = self[key1], let values2 = self[key2], Set(values1).isSubset(of: Set(values2)) {
                    matches.insert([key1, key2].sorted(by: { "\($0)" < "\($1)" }))
                }
            }
        }

        return matches
    }
}
