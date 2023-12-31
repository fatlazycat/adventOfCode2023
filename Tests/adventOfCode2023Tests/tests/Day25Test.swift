import XCTest
import Parsing
import Foundation

class Day25Test : XCTestCase {
    
    func testPart1Dummy() {
        let data = day25Data.map{ processor($0) }
        let g = Graph()
        
        data.forEach({ (from, vals) in
            vals.forEach({ to in
                g.addEdge(from: from, to: to)
            })
        })
        
        g.printDagForGraphviz()
    }
    
    class Graph {
        private var connections: [String: Set<String>] = [:]
        
        func addEdge(from: String, to: String) {
            connections[from, default: []].insert(to)
            connections[to, default: []].insert(from)
        }
        
        func getNodes() -> Set<String> {
            Set(connections.keys)
        }
        
        func printDagForGraphviz() {
            print("-------")
            print("digraph G {")
            connections.keys.forEach({ from in
                let cons = connections[from]!
                
                cons.forEach({ to in
                    print("\(from) -> \(to)")
                })
            })
            print("}")
            print("-------")
        }
    }
    
    let processor: (String) -> (String, [String]) = {
        let row = try! parser.parse($0)
        return (row.0, row.1.split(separator: " ").map(String.init))
    }
    
    static let parser = Parse(input: Substring.self) {
        Prefix { $0 != ":" }.map(String.init)
        Skip{ ": " }
        Prefix { $0 != "\n" }.map(String.init)
    }
    

}
