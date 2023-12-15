import Foundation
import CloudKit

extension Dictionary {
    
    func removeValueFor(forKey: Key) -> Dictionary {
        var dictCopy = self
        dictCopy.removeValue(forKey: forKey)
        return dictCopy
    }
}
