public struct PriorityQueue <T> {
    private var heap: Heap<T>
    public init(orderFunc: @escaping (T, T) -> Bool) {
        heap = Heap(orderFunc: orderFunc)
    }
    
    public var isEmpty: Bool {
        return heap.isEmpty
    }
    public var count: Int {
        return heap.count
    }
    public func peek() -> T? {
        return heap.peek()
    }
    
    public mutating func enq(_ element: T) {
        heap.insert(element)
    }
    @discardableResult public mutating func deq() -> T? {
        return heap.remove()
    }
    
    public mutating func change(at index: Int, element: T) {
        heap.replace(at: index, to: element)
    }
}
extension PriorityQueue where T: Equatable {
    public func index(of element: T) -> Int? {
        return heap.index(of: element)
    }
}
