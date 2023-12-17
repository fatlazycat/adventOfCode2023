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
    var toVisit = PriorityQueue<ScoredVertex<K>>()
    toVisit.push(ScoredVertex(vertex: start, score: 0, heuristic: heuristic(start)))
    var endVertex: K?
    var seenPoints: [K: SeenVertex<K>] = [start: SeenVertex(cost: 0, prev: nil)]

    while endVertex == nil {
        guard let current = toVisit.pop() else {
            return GraphSearchResult(start: start, end: nil, result: seenPoints)
        }

        let currentVertex = current.vertex
        if endFunction(currentVertex) {
            endVertex = currentVertex
        }

        for next in neighbours(currentVertex).filter({ seenPoints[$0] == nil }) {
            let nextScore = current.score + cost(currentVertex, next)
            toVisit.push(ScoredVertex(vertex: next, score: nextScore, heuristic: heuristic(next)))
            seenPoints[next] = SeenVertex(cost: nextScore, prev: currentVertex)
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

// Priority Queue implementation (not available natively in Swift)
//class PriorityQueue<T: Comparable> {
//    private var heap: [T] = []
//
//    func enqueue(_ element: T) {
//        heap.append(element)
//        siftUp(from: heap.count - 1)
//    }
//
//    func dequeue() -> T? {
//        guard !heap.isEmpty else { return nil }
//        heap.swapAt(0, heap.count - 1)
//        let dequeued = heap.removeLast()
//        siftDown(from: 0)
//        return dequeued
//    }
//
//    private func siftUp(from index: Int) {
//        var childIndex = index
//        let child = heap[childIndex]
//        var parentIndex = self.parentIndex(of: childIndex)
//
//        while childIndex > 0 && child < heap[parentIndex] {
//            heap[childIndex] = heap[parentIndex]
//            childIndex = parentIndex
//            parentIndex = self.parentIndex(of: childIndex)
//        }
//
//        heap[childIndex] = child
//    }
//
//    private func siftDown(from index: Int) {
//        var parentIndex = index
//        while true {
//            let leftChildIndex = self.leftChildIndex(of: parentIndex)
//            let rightChildIndex = leftChildIndex + 1
//
//            var optionalParentSwapIndex: Int?
//            if leftChildIndex < heap.count && heap[leftChildIndex] < heap[parentIndex] {
//                optionalParentSwapIndex = leftChildIndex
//            }
//
//            if rightChildIndex < heap.count && heap[rightChildIndex] < heap[parentIndex] {
//                if let parentSwapIndex = optionalParentSwapIndex {
//                    optionalParentSwapIndex = heap[leftChildIndex] < heap[rightChildIndex] ? leftChildIndex : rightChildIndex
//                } else {
//                    optionalParentSwapIndex = rightChildIndex
//                }
//            }
//
//            guard let parentSwapIndex = optionalParentSwapIndex else { return }
//            heap.swapAt(parentIndex, parentSwapIndex)
//            parentIndex = parentSwapIndex
//        }
//    }
//
//    private func parentIndex(of index: Int) -> Int {
//        return (index - 1) / 2
//    }
//
//    private func leftChildIndex(of index: Int) -> Int {
//        return 2 * index + 1
//    }
//}
