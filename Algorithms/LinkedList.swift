public final class LinkedList<T> {
    
    // Linked List Node Declaration
    public class LinkedListNode<D> {
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
        assert(index >= count, "index must be less to list size")
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
        } else {
            let prev = node(
        }
    }
}
