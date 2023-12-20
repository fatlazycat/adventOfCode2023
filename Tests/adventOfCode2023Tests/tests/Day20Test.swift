import XCTest
import Parsing
import Foundation

class Day20Test : XCTestCase {
    
    func testPart1Dummy(){
        let data = try! Day20Test.parser.parse(day20DummyData)
        let graph = constructGraph(data: data)
        let result = processPulse(instruction: Instruction(to: "broadcaster", from: "button", pulse: .Low), startingModules: graph, buttonPresses: 1000)
        
        XCTAssertEqual(32000000, result.0 * result.1)
    }
    
    func testPart1Dummy2(){
        let data = try! Day20Test.parser.parse(day20DummyData2)
        let graph = constructGraph(data: data)
        let result = processPulse(instruction: Instruction(to: "broadcaster", from: "button", pulse: .Low), startingModules: graph, buttonPresses: 1000)
        
        XCTAssertEqual(11687500, result.0 * result.1)
    }
    
    func testPart1(){
        let data = try! Day20Test.parser.parse(day20Data)
        let graph = constructGraph(data: data)
        let result = processPulse(instruction: Instruction(to: "broadcaster", from: "button", pulse: .Low), startingModules: graph, buttonPresses: 1000)
        
        XCTAssertEqual(812721756, result.0 * result.1)
    }
    
    func processPulse(instruction: Instruction, startingModules: [String : Module], buttonPresses: Int) -> (Int, Int) {
        var stop = false
        var cycles = 0
        var cycleCounts: [(Int, Int)] = []
        var modules = startingModules
        
        while !stop {
            var instructions = [instruction]
            var lowCount = 1
            var highCount = 0
            
            while !instructions.isEmpty {
                let i = instructions.removeFirst()
                let m = modules[i.to]!
                var pulseType = Pulse.Low
                var pulseCount = 0
                
                switch m {
                case .Standard(name: let name, outputs: let outputs):
                    let newInstructions = outputs.map{ Instruction(to: $0, from: name, pulse: i.pulse) }
                    instructions.append(contentsOf: newInstructions)
                    pulseType = i.pulse
                    pulseCount += newInstructions.count
                case .FlipFlop(name: let name, outputs: let outputs, state: let state):
                    switch i.pulse {
                    case .High:
                        break
                    case .Low:
                        switch state {
                        case .On:
                            modules[name] = Module.FlipFlop(name: name, outputs: outputs, state: .Off)
                            let newInstructions = outputs.map{ Instruction(to: $0, from: name, pulse: .Low) }
                            instructions.append(contentsOf: newInstructions)
                            pulseType = .Low
                            pulseCount += newInstructions.count
                        case .Off:
                            modules[name] = Module.FlipFlop(name: name, outputs: outputs, state: .On)
                            let newInstructions = outputs.map{ Instruction(to: $0, from: name, pulse: .High) }
                            instructions.append(contentsOf: newInstructions)
                            pulseType = .High
                            pulseCount += newInstructions.count
                        }
                    }
                case .Conjunction(name: let name, inputs: let inputs, outputs: let outputs):
                    var updatedInputs = inputs
                    updatedInputs[i.from] = i.pulse
                    modules[name] = Module.Conjunction(name: name, inputs: updatedInputs, outputs: outputs)
                    
                    if updatedInputs.allSatisfy({ $0.value == .High}) {
                        let newInstructions = outputs.map{ Instruction(to: $0, from: name, pulse: .Low) }
                        instructions.append(contentsOf: newInstructions)
                        pulseType = .Low
                        pulseCount += newInstructions.count
                    } else {
                        let newInstructions = outputs.map{ Instruction(to: $0, from: name, pulse: .High) }
                        instructions.append(contentsOf: newInstructions)
                        pulseType = .High
                        pulseCount += newInstructions.count
                    }
                }
                
                switch pulseType {
                case .High:
                    highCount += pulseCount
                case .Low:
                    lowCount += pulseCount
                }
            }
            
            cycles += 1
            cycleCounts.append((lowCount, highCount))
            
            if modules == startingModules || cycles == 1000 {
                stop = true
            }
        }
        
        let counts = foldl(sequence: cycleCounts, base: (0,0)){ (acc, i) in (acc.0+i.0, acc.1+i.1) }
        let multiplier = buttonPresses / cycles
        
        return (counts.0 * multiplier, counts.1 * multiplier)
    }
    
    func constructGraph(data: [(Substring, [Substring])]) -> [String : Module] {
        var modules = [String : Module]()
        
        // Create the modules
        data.forEach({ m in
            switch m.0.first! {
            case "%":
                let name = String(m.0.dropFirst())
                modules[name] = Module.FlipFlop(name: name, outputs: [], state: .Off)
            case "&":
                let name = String(m.0.dropFirst())
                modules[name] = Module.Conjunction(name: name, inputs: [:], outputs: [])
            default:
                let name = String(m.0)
                modules[name] = Module.Standard(name: name, outputs: [])
            }
        })
        
        // Map the outputs
        data.forEach({ m in
            switch m.0.first! {
            case "%":
                let name = String(m.0.dropFirst())
                let outputs = m.1.map{ String($0) }
                modules[name] = Module.FlipFlop(name: name, outputs: outputs, state: .Off)
            case "&":
                let name = String(m.0.dropFirst())
                let outputs = m.1.map{ String($0) }
                modules[name] = Module.Conjunction(name: name, inputs: [:], outputs: outputs)
            default:
                let name = String(m.0)
                let outputs = m.1.map{ String($0) }
                modules[name] = Module.Standard(name: name, outputs: outputs)
            }
        })
        
        // Map the inputs for Conjunctions
        modules.values.forEach({ m in
            switch m {
            case .Standard(name: _, outputs: _):
                break
            case .FlipFlop(name: _, outputs: _, state: _):
                break
            case .Conjunction(name: let name, inputs: _, outputs: let outputs):
                let newInputs = Dictionary(uniqueKeysWithValues: modules.values.filter({$0.moduleOutputs.contains(m.moduleName)}).map{($0.moduleName, Pulse.Low)})
                modules[name] = Module.Conjunction(name: name, inputs: newInputs, outputs: outputs)
            }
        })
        
        // find any inputs that have no outputs themselves and create a standard entry
        var allInputNames = Set<String>(modules.keys)
        var allOutputNames = Set<String>()
        
        modules.values.forEach({ m in
                switch m {
                case .Standard(name: _, outputs: let outputs):
                    outputs.forEach({allOutputNames.insert($0)})
                case .FlipFlop(name: _, outputs: let outputs, state: _):
                    outputs.forEach({allOutputNames.insert($0)})
                case .Conjunction(name: _, inputs: _, outputs: let outputs):
                    outputs.forEach({allOutputNames.insert($0)})
                }
            })
        
        var onlyOutputs = allOutputNames.subtracting(allInputNames)
        
        onlyOutputs.forEach({ name in
            modules[name] = Module.Standard(name: name, outputs: [])
        })
        
        // Add the starting button
        modules["button"] = Module.Standard(name: "button", outputs: ["broadcaster"])
        
        return modules
    }
    
    func isConjunction(_ m: Module) -> Bool {
        if case Module.Conjunction(_, _, _) = m {
            true
        } else {
            false
        }
    }
    
    struct Instruction: Equatable, Hashable {
        let to: String
        let from: String
        let pulse: Pulse
        
        func AsString() -> String {
            "from: \(from) to: \(to) type \(pulse.asString)"
        }
    }
    
    enum Module: Equatable, Hashable {
        case Standard(name: String, outputs: [String])
        case FlipFlop(name: String, outputs: [String], state: State)
        case Conjunction(name: String, inputs: [String : Pulse], outputs: [String])
        
        var moduleName: String {
            switch self {
            case .Standard(name: let name, _):
                return name
            case .FlipFlop(name: let name, _, _):
                return name
            case .Conjunction(name: let name, _, _):
                return name
            }
        }
        
        var moduleOutputs: [String] {
            switch self {
            case .Standard(_, outputs: let outputs):
                return outputs
            case .FlipFlop(_, outputs: let outputs, _):
                return outputs
            case .Conjunction(_, _, outputs: let outputs):
                return outputs
            }
        }
    }
    
    enum State: Equatable, Hashable {
        case On
        case Off
    }
    
    enum Pulse : Equatable, Hashable {
        case High
        case Low
        
        var asString: String {
            switch self {
            case .High:
                "High"
            case .Low:
                "Low"
            }
        }
    }
    
    static let parser = Parse(input: Substring.self) {
        Many {
            Prefix{ $0 != " " }
            Skip{ " -> "}
            Many {
                Prefix{ $0 != "," && $0 != "\n" }
            } separator: {
                ", "
            }
        } separator: {
            Whitespace(1, .vertical)
        }
    }
    
}
