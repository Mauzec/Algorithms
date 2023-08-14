fileprivate enum RedBlackColor {
    case red
    case black
}

final public class RedBlackNode<Key: Comparable, Value>: TreeNodeKeyValue {
    public typealias Key = Key
    public typealias Value = Value
    public typealias Node = RedBlackNode<Key, Value>
    
    fileprivate(set) public var key: Key?
    fileprivate(set) public var value: Value?
    fileprivate var color: RedBlackColor
    
    fileprivate(set) public var leftChild: Node?
    fileprivate(set) public var rightChild: Node?
    fileprivate(set) public weak var parent: Node?
    
    public var isLeaf: Bool { return leftChild == nil && rightChild == nil }
    public var isNullLeaf: Bool { return isLeaf && color == .black && key == nil }
    public var sibling: Node? {
        return isLeftChild ? parent?.rightChild : parent?.leftChild
    }
    public var grandparent: Node? { return parent?.parent }
    public var uncle: Node? { return parent?.sibling }
    
    public init(key: Key, value: Value?, leftChild: Node?, rightChild: Node?, parent: Node?) {
        self.key = key
        self.value = value
        self.color = .black
        self.leftChild = leftChild
        self.rightChild = rightChild
        self.parent = parent
        
        self.leftChild?.parent = self
        self.rightChild?.parent = self
    }
    
    public init() {
        self.key = nil
        self.value = nil
        self.color = .black
        self.leftChild = nil
        self.rightChild = nil
        self.parent = nil
    }
    
    public convenience init(key: Key, value: Value? = nil) {
        self.init(key: key, value: value, leftChild: Node(), rightChild: Node(), parent: nil)
    }
}

/// Search methods
extension RedBlackNode {
    public func minNode() -> Node? {
        if let leftChild = leftChild {
            if !leftChild.isNullLeaf {
                return leftChild.minNode()
            }
        }
        return self
    }
    
    public func maxNode() -> Node? {
        if let rightChild = rightChild {
            if !rightChild.isNullLeaf {
                return rightChild.maxNode()
            }
        }
        return self
    }
}

extension RedBlackNode: Equatable {
    static public func ==<K: Comparable, V>(lhs: RedBlackNode<K, V>, rhs: RedBlackNode<K, V>) -> Bool {
        return lhs.key == rhs.key
    }

}

extension RedBlackNode {
    public func successor() -> Node? {
        if let rightChild = rightChild {
            if !rightChild.isNullLeaf {
                return rightChild.minNode()
            }
        }
        
        var curr = self
        while curr.isRightChild {
            if let parent = curr.parent {
                curr = parent
            }
        }
        return curr
    }
}
open class RedBlackTree<Key: Comparable, Value> {
    public typealias Node = RedBlackNode<Key, Value>
    
    fileprivate(set) public var root: Node
    fileprivate(set) public var size: Int
    private let allowDuplicates: Bool
    
    public init(hasDuplicates: Bool = false) {
        self.root = Node()
        self.size = 0
        self.allowDuplicates = hasDuplicates
    }
}

/// Rotation methods
extension RedBlackTree {
    private func leftRotate(at nd: Node?) {
        guard let nd = nd, let pivot = nd.rightChild else { return }
        nd.rightChild = pivot.leftChild
        nd.rightChild?.parent = nd
        pivot.parent = nd.parent
        
        if root === nd { root = pivot }
        else if nd.isLeftChild {
            nd.parent?.leftChild = pivot
        } else if nd.isRightChild {
            nd.parent?.rightChild = pivot
        }
        pivot.leftChild = nd
        nd.parent = pivot
    }
    
    private func rightRotate(at nd: Node?) {
        guard let nd = nd, let pivot = nd.leftChild else { return }
        nd.leftChild = pivot.rightChild
        nd.leftChild?.parent = nd
        pivot.parent = nd.parent
        
        if root === nd { root = pivot }
        else if nd.isLeftChild {
            nd.parent?.leftChild = pivot
        } else if nd.isRightChild {
            nd.parent?.rightChild = pivot
        }
        pivot.rightChild = nd
        nd.parent = pivot
    }
}

/// Insertion methods
extension RedBlackTree {
    public func insert(key: Key, value: Value? = nil) {
        if search(key: key) != nil && !allowDuplicates { return }
        
        if root.isNullLeaf {
            root = Node(key: key, value: value)
        } else {
            insert(Node(key: key, value: value), at: root)
        }
        size += 1
    }
    
    private func insert(_ ins: Node, at nd: Node) {
        guard let insertKey = ins.key, let nodeKey = nd.key else { return }
        if insertKey < nodeKey {
            guard let child = nd.leftChild else {
                addToLeft(ins, parent: nd)
                return
            }
            if child.isNullLeaf {
                addToLeft(ins, parent: nd)
            } else {
                insert(ins, at: child)
            }
        } else {
            guard let child = nd.rightChild else {
                addToRight(ins, parent: nd)
                return
            }
            if child.isNullLeaf {
                addToRight(ins, parent: nd)
            } else {
                insert(ins, at: child)
            }
        }
    }
    
    private func addToLeft(_ ins: Node, parent nd: Node) {
        nd.leftChild = ins
        ins.parent = nd
        ins.color = .red
        fixUpwards(from: ins)
    }
    
    private func addToRight(_ ins: Node, parent nd: Node) {
        nd.rightChild = ins
        ins.parent = nd
        ins.color = .red
        fixUpwards(from: ins)
    }
    
    private func fixUpwards(from nd: Node) {
        guard !nd.isNullLeaf else { return } ///--- ?
        guard let parentND = nd.parent else { return }
        guard parentND.color == .red else { return }
        guard let uncle = nd.uncle else { return }
        
        if uncle.color == .red {
            parentND.color = .black
            uncle.color = .black
            nd.grandparent!.color = .red
            
            fixUpwards(from: nd.grandparent!)
        } else {
            var newND = nd
            
            if nd.isRightChild && parentND.isLeftChild {
                leftRotate(at: parentND)
                newND = nd.leftChild!
            } else if nd.isLeftChild && parentND.isRightChild {
                rightRotate(at: parentND)
                newND = nd.rightChild!
            }
            
            let g = newND.grandparent
            newND.parent!.color = .black
            g!.color = .red
            if newND.isLeftChild && newND.parent!.isLeftChild {
                rightRotate(at: g)
            } else {
                leftRotate(at: g)
            }
        }
        root.color = .black
    }
}

/// Search methods
extension RedBlackTree {
    public func minKey() -> Key? {
        guard let minNode = root.minNode() else { return nil }
        return minNode.key
    }
    
    public func maxKey() -> Key? {
        guard let maxNode = root.maxNode() else { return nil }
        return maxNode.key
    }
    
    public func search(key: Key, value: Value? = nil) -> Node? where Value: Equatable {
        return search(key: key, value: value, from: root)
    }
    
    public func search(key: Key) -> Node? {
        return search(key: key, from: root)
    }
    
    private func search(key: Key, from nd: Node?) -> Node? {
        guard let nd = nd, !nd.isNullLeaf else { return nil }
        guard let ndKey = nd.key else { return nil }
        if key == ndKey {
            return nd
        } else if (key < ndKey) {
            return search(key: key, from: nd.leftChild)
        } else {
            return search(key: key, from: nd.rightChild)
        }
    }
    
    private func search(key: Key, value: Value?, from nd: Node?) -> Node? where Value: Equatable {
        guard let nd = nd, !nd.isNullLeaf else { return nil }
        guard let ndKey = nd.key else { return nil }
        if key == ndKey && value == nd.value {
            return nd
        } else if (key == ndKey && value != nd.value) || (key > ndKey) {
            return search(key: key, value: value, from: nd.rightChild)
        } else {
            return search(key: key, value: value, from: nd.leftChild)
        }
    }
}

extension RedBlackTree {
    public func remove(key: Key) {
        if let nd = search(key: key, from: root) {
            if nd === root {
                root = Node()
            } else {
                remove(node: nd)
            }
            size -= 1
        }
    }
    
    private func remove(node nd: Node) {
        var x = Node()
        var y = Node()
        
        if let leftChild = nd.leftChild, let rightChild = nd.rightChild {
            if leftChild.isNullLeaf || rightChild.isNullLeaf {
                y = nd
            } else {
                if let succ = nd.successor() {
                    y = succ
                }
            }
        }
        
        if let leftChild = y.leftChild {
            x = leftChild
        } else if let rightChild = y.rightChild {
            x = rightChild
        }
        
        x.parent = y.parent
        if let parentY = y.parent, !parentY.isNullLeaf {
            if y.isLeftChild {
                parentY.leftChild = x
            } else {
                parentY.rightChild = x
            }
        } else {
            root = x
        }
        
        if y != nd {
            nd.key = y.key
        }
        
        if y.color == .black {
            deleteFixUpwards(from: x)
        }
    }
    
    private func deleteFixUpwards(from nd: Node) {
        var node = nd
        
        if !nd.isRoot && nd.color == .black {
            guard var sibling = nd.sibling else { return }
            
            if sibling.color == .red {
                sibling.color = .black
                
                if let parentND = nd.parent {
                    parentND.color = .red
                    if nd.isLeftChild {
                        leftRotate(at: parentND)
                    } else {
                        rightRotate(at: parentND)
                    }
                    
                    if let s = nd.sibling {
                        sibling = s
                    }
                }
            }
            
            if sibling.leftChild?.color == .black && sibling.rightChild?.color == .black {
                sibling.color = .red
                
                if let parentND = nd.parent {
                    deleteFixUpwards(from: parentND)
                }
            } else {
                if nd.isLeftChild && sibling.rightChild?.color == .black {
                    sibling.leftChild?.color = .black
                    sibling.color = .red
                    
                    rightRotate(at: sibling)
                    
                    if let s = nd.sibling {
                        sibling = s
                    }
                }
                else if nd.isRightChild && sibling.leftChild?.color == .black {
                    sibling.rightChild?.color = .black
                    sibling.color = .red
                    
                    leftRotate(at: sibling)
                    
                    if let s = nd.sibling {
                        sibling = s
                    }
                }
                
                if let parentND = nd.parent {
                    sibling.color = parentND.color
                    parentND.color = .black
                    
                    if nd.isLeftChild {
                        sibling.rightChild?.color = .black
                        
                        leftRotate(at: parentND)
                    }
                    else {
                        sibling.leftChild?.color = .black
                        
                        rightRotate(at: parentND)
                    }
                    node = root
                }
            }
        }
        node.color = .black
    }
}

extension RedBlackTree: CustomStringConvertible {
    private func helperDescription(from nd: Node) -> String {
        var str = ""
        if let leftChild = nd.leftChild {
            str += "[\(helperDescription(from: leftChild))] <- "
        }
        str += (nd.key != nil) ? "\(nd.key!)" : "nil"
        str += (nd.color == .red) ? ".R" : ".B"
        if let rightChild = nd.rightChild {
            str += " -> [\(helperDescription(from: rightChild))]"
        }
        return str
    }
    
    public var description: String {
        return helperDescription(from: root)
    }
}
