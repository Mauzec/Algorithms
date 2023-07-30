public struct Queue<T> {
    fileprivate var array = [T]()
    
    public var isEmpty: Bool {
        return array.isEmpty
    }
    
    public var count: Int {
        return array.count
    }
    
    public var front: T? {
        return array.first
    }
    
    public mutating func enq(_ element: T) {
        array.append(element)
    }
    
    /// O(n) operation
    public mutating func deq() ->T? {
        if isEmpty {
            return nil
        } else {
            return array.removeFirst()
        }
    }
    
}
