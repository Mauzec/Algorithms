public struct Heap<T> {
    var elements: [T]
    public var isEmpty: Bool {
        return elements.isEmpty
    }
    public var count: Int {
        return elements.count
    }
    public func peek() -> T? {
        return elements.first
    }
    private let orderFunc: (T, T) -> Bool
    
    public func isRoot(at index: Int) -> Bool {
        return index == 0
    }
    public func left(of index: Int) -> Int {
        return (2 * index) + 1
    }
    public func right(of index: Int) -> Int {
        return (2 * index) + 2
    }
    public func parent(of index: Int) -> Int {
        return (index == 0) ? 0 : (index - 1) / 2
    }
    
    private mutating func standUp(index: Int) {
        let parent = parent(of: index)
        if (isRoot(at: index)) || !(orderFunc(elements[index], elements[parent])) {
            return
        }
        
        elements.swapAt(index, parent)
        standUp(index: parent)
    }
    public mutating func enq(_ element: T) {
        elements.append(element)
        standUp(index: count - 1)
    }
    
    private mutating func getDown(parent: Int) {
        let leftChild = left(of: parent)
        let rightChild = right(of: parent)
        var child = parent
        
        if leftChild < count && !orderFunc(elements[leftChild], elements[child])  {
            child = leftChild
        }
        if rightChild < count && !orderFunc(elements[rightChild], elements[child])  {
            child = rightChild
        }
        
        if parent == child {
            return
        }
        
        elements.swapAt(parent, child)
        getDown(parent: child)
    }
    @discardableResult public mutating func deq() -> T? {
        if isEmpty {
            return nil
        }
        
        elements.swapAt(0, count - 1)
        let element = elements.removeLast()
        if !isEmpty {
            getDown(parent: 0)
        }
        return element
    }
    
    private mutating func buildHeap() {
        for index in (0..<count/2).reversed() {
            getDown(parent: index)
        }
    }
    public init(_ array: [T] = [], orderFunc order: @escaping (T, T) -> Bool) {
        self.elements = array
        self.orderFunc = order
        buildHeap()
    }
}
