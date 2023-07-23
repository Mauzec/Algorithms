public struct Deque<T> {
    fileprivate var array = [T?]()
    fileprivate var head: Int
    fileprivate var capacity: Int
    
    private let firstCapacity: Int
    
    public init(_ capacity: Int = 9) {
        self.capacity = max(capacity, 1)
        firstCapacity = self.capacity
        
        array = [T?](repeating: nil, count: capacity)
        head = capacity
    }
    public var count: Int {
        return array.count - head
    }
    public var isEmpty: Bool {
        return count == 0
    }
    
    public mutating func enq(_ element: T) {
        array.append(element)
    }
    public mutating func enqFront(_ element: T) {
        if head == 0 {
            capacity *= 2
            let empties = [T?](repeating: nil, count: capacity)
            array.insert(contentsOf: empties, at: 0)
            head = capacity
        }
        head -= 1
        array[head] = element
    }
    
    @discardableResult public mutating func deq() -> T? {
        guard head < array.count, let element = array[head] else {
            return nil
        }
        
        array[head] = nil
        head += 1
        
        if capacity >= firstCapacity && head >= capacity * 2 {
            let countToRemove = capacity + capacity / 2
            array.removeFirst(countToRemove)
            head -= countToRemove
            capacity /= 2
        }
        
        return element
    }
    @discardableResult public mutating func deqBack() -> T? {
        if isEmpty {
            return nil
        } else {
            return array.removeLast()
        }
    }
    
    public var front: T? {
        if isEmpty {
            return nil
        } else {
            return array[head]
        }
    }
    public var back: T? {
        if isEmpty {
            return nil
        } else {
            return array.last!
        }
    }
}
