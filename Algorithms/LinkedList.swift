public final class LinkedList<T> {
    
    // Linked List Node Declaration
    public class LinkedListNode<D>  {
        var value: D
        var next: LinkedListNode?
        weak var previous: LinkedListNode?
        
        public init(value: D) {
            self.value = value
        }
    }
    
    // For readability typealiasing the node
    public typealias Node = LinkedListNode<T>
    
    // LL head & tail
    private(set) var head: Node?
    private(set) var tail: Node?
    
    // LL Nodes count
    public var count: Int
    
    // Check if LL is empty
    public var isEmpty: Bool {
        return head == nil
    }
    
    // Default initializer
    public init() {
        count = 0
    }
    
    
    // Method to return node at index.
    // index: requested index value
    // return: LL Node
    public func node(at index: Int) -> Node {
        assert(head != nil, "List is empty")
        assert(index < count, "index must be less to list size")
        assert(index >= 0, "index must be greater or equal to 0")
        
        if index == 0 {
            return head!
        } else {
            var node = head!.next
            for _ in 1..<index {
                node = node?.next
                if node == nil {
                    break
                }
            }
            return node!
        }
    }
    
    // Subscript method to return node at index
    // index: requested index value
    public subscript(index: Int) -> T {
        let node = self.node(at: index)
        return node.value
    }
    
    // Append node to the end
    // node: the node to be appended
    public func append(_ node: Node) {
        let new = node
        if let last = tail {
            new.previous = tail
            last.next = new
        } else {
            head = new
        }
        tail = new
        count += 1
    }
    
    // Append value to the end
    // value: the data to be appended
    public func append(_ value: T) {
        let new = Node(value: value)
        append(new)
    }
    
    // Append copy of LL to the end
    // list: the list to be appended(copied)
    public func append(_ list: LinkedList) {
        var copy = list.head
        while let node = copy {
            append(node.value)
            copy = node.next
        }
    }
    
    // Insert value at index
    // value: the data to be inserted
    // index: value of index to be inserted at
    public func insert(_ value: T, at index: Int) {
        let new = Node(value: value)
        insert(new, at: index)
    }
    
    // Insert copy of node at index
    // value: the node to be inserted
    // index: node of index to be inserted at
    public func insert(_ new: Node, at index: Int) {
        if index == 0 {
            new.next = head
            head?.previous = new
            head = new
            count += 1
        } else if index == count {
            append(new)
        } else {
            let prev = node(at: index - 1)
            let next = prev.next
            new.previous = prev
            new.next = next
            next?.previous = new
            prev.next = new
            count += 1
        }
    }
    
    // Remove node
    // node: node to be deleted
    // return: data value in the deleted node
    @discardableResult public func remove(node: Node) -> T {
        let prev = node.previous
        let next = node.next
        
        if let next = next {
            next.previous = prev
        } else {
            tail = prev
        }
        
        if let prev = prev {
            prev.next = next
        } else {
            head = next
        }
        
        node.previous = nil
        node.next = nil
        
        count -= 1
        return node.value
    }
    
    public func removeAll() {
        head = nil
        tail = nil
    }
    
    @discardableResult public func removeLast() -> T {
        assert(!isEmpty, "list is empty")
        return remove(node: tail!)
    }
    
    @discardableResult public func remove(at index: Int) -> T {
        let node = self.node(at: index)
        return remove(node: node)
    }
    
    // Reverse method
    public func reverse() {
        var node = head
        while let curr = node {
            node = curr.next
            swap(&curr.next, &curr.previous)
        }
    }
    // Map method
    public func map<K>(transform: (T) -> K) -> LinkedList<K> {
        let result = LinkedList<K>()
        var node = head
        while let curr = node {
            result.append(transform(curr.value))
            node = curr.next
        }
        return result
    }
    
    // Filter method
    public func filter(predicate: (T) -> Bool) -> LinkedList<T> {
        let result = LinkedList<T>()
        var node = head
        while let curr = node {
            if predicate(curr.value) {
                result.append(curr.value)
            }
            node = curr.next
        }
        return result
    }
}

extension LinkedList: CustomStringConvertible {
    public var description: String {
        var s = "["
        var node = head
        while let curr = node {
            s += "\(curr.value)"
            node = curr.next
            if node != nil {
                s += ", "
            }
        }
        s += "]"
        return s
    }
}

// Initialization from an Array
extension LinkedList {
    convenience init(array: Array<T>) {
        self.init()
        array.forEach {
            append($0)
        }
    }
}

// Initialization from an Array literal
extension LinkedList: ExpressibleByArrayLiteral {
    public convenience init(arrayLiteral elements: T...) {
        self.init()
        elements.forEach {
            append($0)
        }
    }
}

// Collection
extension LinkedList: Collection {
    public typealias Index = LinkedListIndex<T>
    
    public var startIndex: Index {
        get {
            return LinkedListIndex<T>(node:head, tag:0)
        }
    }
    public var endIndex: Index {
        get {
            return LinkedListIndex<T>(node:tail, tag:count)
        }
    }
    public subscript(position: Index) -> T {
        get {
            return position.node!.value
        }
    }
    public func index(after idx: Index) -> Index {
        return LinkedListIndex<T>(node: idx.node?.next, tag: idx.tag + 1)
    }
}

public struct LinkedListIndex<T>: Comparable {
    fileprivate let node: LinkedList<T>.LinkedListNode<T>?
    fileprivate let tag: Int
    
    public static func < <K>(lhs: LinkedListIndex<K>, rhs: LinkedListIndex<K>) -> Bool {
        return (lhs.tag < rhs.tag)
    }
    public static func == <K>(lhs: LinkedListIndex<K>, rhs: LinkedListIndex<K>) -> Bool {
        return (lhs.tag == rhs.tag)
    }
}
