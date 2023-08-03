public struct Heap<T> {
    private(set) var elements: [T]
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
    
    @inline(__always) public func isRoot(at index: Int) -> Bool {
        return index == 0
    }
    @inline(__always) public func left(of index: Int) -> Int {
        return (2 * index) + 1
    }
    @inline(__always) public func right(of index: Int) -> Int {
        return (2 * index) + 2
    }
    @inline(__always) public func parent(of index: Int) -> Int {
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
    public mutating func insert(_ element: T) {
        elements.append(element)
        standUp(index: count - 1)
    }
    
    private mutating func getDown(parent: Int) {
        getDown(from: parent, until: count)
    }
    @discardableResult public mutating func remove() -> T? {
        if isEmpty {
            return nil
        }
        if count == 1 {
            return elements.removeLast()
        }
        
        elements.swapAt(0, count - 1)
        let element = elements.removeLast()
        if !isEmpty {
            getDown(parent: 0)
        }
        return element
    }
    
    private mutating func buildHeap() {
        var index = count / 2 - 1
        while index >= 0 {
            getDown(parent: index)
            index -= 1
        }
    }
    
    /// be careful in choosing appropriate order function!
    /// you must choose functions like > or <, not >= and <=
    /// because heap will be built incorrect if some elements
    /// will be repeated
    public init(_ array: [T], orderFunc order: @escaping (T, T) -> Bool) {
        self.elements = array
        self.orderFunc = order
        buildHeap()
    }
    public init(orderFunc order: @escaping (T, T) -> Bool) {
        self.orderFunc = order
        self.elements = []
    }
}
extension Heap {
    private mutating func getDown(from parent: Int, until end: Int) {
        let leftChild = left(of: parent)
        let rightChild = leftChild + 1
        var child = parent
        
        if leftChild < end && orderFunc(elements[leftChild], elements[child]) {
            child = leftChild
        }
        if rightChild < end && orderFunc(elements[rightChild], elements[child]) {
            child = rightChild
        }
        
        if child == parent {
            return
        }
        
        elements.swapAt(parent, child)
        getDown(from: child, until: end)
        
    }
    @discardableResult public mutating func remove(at index: Int) -> T? {
        if isEmpty || index >= count {
            return nil
        }
        
        let size = count - 1
        if size != index {
            elements.swapAt(index, size)
            getDown(from: index, until: size)
            standUp(index: index)
        }
        return elements.removeLast()
    }
}
extension Heap {
    public mutating func insert<seqType: Sequence<T>>(_ sequence: seqType) {
        for element in sequence {
            insert(element)
        }
    }
    public mutating func replace(at index: Int, to element: T) {
        guard index < count else { return }
        remove(at: index)
        insert(element)
    }
}

extension Heap where T: Equatable {
    public func index(of element: T) -> Int? {
        return elements.firstIndex(where: {$0 == element})
    }
    @discardableResult public mutating func remove(element: T) -> T? {
        if let index = index(of: element) {
            return remove(at: index)
        }
        return nil
    }
}
