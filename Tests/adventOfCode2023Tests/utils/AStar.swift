
import Foundation
import SwiftPriorityQueue

// Typealiases for function types
typealias NeighbourFunction<K> = (K) -> [K]
typealias CostFunction<K> = (K, K) -> Int
typealias HeuristicFunction<K> = (K) -> Int

/**
 * Implements A* search to find the shortest path between two vertices
 */
func findShortestPath<K: Hashable>(
    start: K,
    end: K,
    neighbours: @escaping NeighbourFunction<K>,
    cost: @escaping CostFunction<K> = { _, _ in 1 },
    heuristic: @escaping HeuristicFunction<K> = { _ in 0 }
) -> GraphSearchResult<K> {
    return findShortestPathByPredicate(
        start: start,
        endFunction: { $0 == end },
        neighbours: neighbours,
        cost: cost,
        heuristic: heuristic)
}

/**
 * Implements A* search to find the shortest path between two vertices using a predicate to determine the ending vertex
 */
func findShortestPathByPredicate<K: Hashable>(
    start: K,
    endFunction: @escaping (K) -> Bool,
    neighbours: @escaping NeighbourFunction<K>,
    cost: @escaping CostFunction<K> = { _, _ in 1 },
    heuristic: @escaping HeuristicFunction<K> = { _ in 0 }
) -> GraphSearchResult<K> {
    var toVisit = PriorityQueue<ScoredVertex<K>>(ascending: true, startingValues: [ScoredVertex(vertex: start, score: 0, heuristic: heuristic(start))])
    var endVertex: K? = nil
    var seenPoints: [K: SeenVertex<K>] = [start: SeenVertex(cost: 0, prev: nil)]

    while endVertex == nil {
        if toVisit.isEmpty {
            return GraphSearchResult(start: start, end: nil, result: seenPoints)
        }

        let current = toVisit.pop()!
        let currentVertex = current.vertex
        
        if endFunction(currentVertex) {
            endVertex = currentVertex
        } else {
            endVertex = nil
        }

        for next in neighbours(currentVertex).filter({ seenPoints[$0] == nil }) {
            let nextScore = current.score + cost(currentVertex, next)
            let nextPoint = ScoredVertex(vertex: next, score: nextScore, heuristic: heuristic(next))
            toVisit.push(nextPoint)
            seenPoints[nextPoint.vertex] = SeenVertex(cost: nextPoint.score, prev: currentVertex)
        }
    }

    return GraphSearchResult(start: start, end: endVertex, result: seenPoints)
}

// Supporting data structures and classes
struct GraphSearchResult<K: Hashable> {
    let start: K
    let end: K?
    private let result: [K: SeenVertex<K>]

    init(start: K, end: K?, result: [K : SeenVertex<K>]) {
        self.start = start
        self.end = end
        self.result = result
    }
    
    func getScore(vertex: K) -> Int {
        guard let score = result[vertex]?.cost else {
            fatalError("Result for \(vertex) not available")
        }
        return score
    }

    func getScore() -> Int {
        guard let endVertex = end else {
            fatalError("No path found")
        }
        return getScore(vertex: endVertex)
    }

    func getPath() -> [K] {
        guard let endVertex = end else {
            fatalError("No path found")
        }
        return getPath(endVertex: endVertex, pathEnd: [])
    }

    private func getPath(endVertex: K, pathEnd: [K]) -> [K] {
        guard let previous = result[endVertex]?.prev else {
            return [endVertex] + pathEnd
        }
        return getPath(endVertex: previous, pathEnd: [endVertex] + pathEnd)
    }
}

struct SeenVertex<K> {
    let cost: Int
    let prev: K?
}

struct ScoredVertex<K: Hashable>: Comparable {
    let vertex: K
    let score: Int
    let heuristic: Int

    static func < (lhs: ScoredVertex<K>, rhs: ScoredVertex<K>) -> Bool {
        return lhs.score + lhs.heuristic < rhs.score + rhs.heuristic
    }
}
