/// A BinarySearchTree class
/// It describes only node of some tree, because any node "contains" a subtree
///
/// Here a description of the main variables(methods) that show the structure of the tree
/// Other importatant methods are shown below
public class BinarySearchTree<T: Comparable> {
    private(set) public var value: T
    private(set) public var parent: BinarySearchTree?
    private(set) public var left: BinarySearchTree?
    private(set) public var right: BinarySearchTree?
    public init(value: T) { self.value = value}
    
    public var count: Int {
        return (left?.count ?? 0) + (right?.count ?? 0) + 1
    }
    
    public var isRoot: Bool {
        // root has not a parent node(tree)
        return parent == nil
    }
    
    public var isLeaf: Bool {
        // leaf has not any child node(tree)
        return left == nil && right == nil
    }
    
    public var isLeftChild: Bool {
        return parent?.left === self
    }
    
    public var isRightChild: Bool {
        return parent?.right === self
    }
    
    public func isLeftChild(of: BinarySearchTree) -> Bool {
        let onlyParent = parent
        return onlyParent === of && onlyParent?.left === self
    }
    
    public func isRightChild(of: BinarySearchTree) -> Bool {
        let onlyParent = parent
        return onlyParent === of && onlyParent?.right === self
    }
    
    public var hasLeftChild: Bool {
        return left != nil
    }
    
    public var hasRightChild: Bool {
        return right != nil
    }
    
    public var hasAChild: Bool {
        return hasLeftChild || hasRightChild
    }
    
    public var hasBothChildren: Bool {
        return hasLeftChild && hasRightChild
    }
    
    /// Returns height of the tree from self node
    /// Complexity: O(*n*), where n is a count of nodes in a tree
    public func height() -> Int {
        return max(left?.height() ?? 0, right?.height() ?? 0) + 1
        
    }
    
    /// Return distance to the root from self node
    /// Complexity: O(*h*), where h is a height of a tree
    public func depth() -> Int {
        var current = self
        var count = 0
        
        while let parent = current.parent {
            current = parent
            count += 1
        }
        return count
    }
}

/// Impementation of insertion method
/// MARK: insertion wrote iteratively, because in a large tree there
///       will be a stack overflow error
/// Complexity: O(*h*), where h is a height of a tree
extension BinarySearchTree {
    public func insert(newValue: T) {
        var current: BinarySearchTree? = self
        
        while let node = current {
            if newValue < node.value {
                if let leftChild = node.left {
                    current = leftChild
                } else {
                    node.left = BinarySearchTree(value: newValue)
                    node.left?.parent = node
                    return
                }
            } else {
                if let rightChild = node.right {
                    current = rightChild
                } else {
                    node.right = BinarySearchTree(value: newValue)
                    node.right?.parent = node
                    return
                }
            }
        }
    }
}

/// Impementation of searching method
/// Complexity: O(*h*), where h is a height of a tree
extension BinarySearchTree {
    public func search(value: T) -> BinarySearchTree? {
        var current: BinarySearchTree? = self
        while let node = current {
            if value < node.value {
                current = node.left
            } else if value > node.value {
                current = node.right
            } else {
                return node
            }
        }
        return nil
    }
}

/// Impementation of traversal methods
/// Complexity: O(*n*), where n is a count of nodes in a tree
extension BinarySearchTree {
    public func traverseInOrder(doing closure: (T) -> Void = { print($0) }) {
        left?.traverseInOrder(doing: closure)
        closure(value)
        right?.traverseInOrder(doing: closure)
    }
    public func traversePostOrder(doing closure: (T) -> Void = { print($0) }) {
        left?.traverseInOrder(doing: closure)
        right?.traverseInOrder(doing: closure)
        closure(value)
    }
    public func traversePreOrder(doing closure: (T) -> Void = { print($0) }) {
        closure(value)
        left?.traverseInOrder(doing: closure)
        right?.traverseInOrder(doing: closure)
    }
}

/// Implementation of deleting methods
/// Here are 3 helpers and 1 main methods
extension BinarySearchTree {
    /// Helper method that search minimum node from self
    /// Complexity: O(*h*), where h is a height of a tree
    public func minNode() -> BinarySearchTree {
        var node = self
        while let next = node.left {
            node = next
        }
        return node
    }
    /// Helper method that search maximum node from self
    /// Complexity: O(*h*), where h is a height of a tree
    public func maxNode() -> BinarySearchTree {
        var node = self
        while let next = node.right {
            node = next
        }
        return node
    }
    
    /// Deleting method that returns a replacement node
    /// Complexity: O(*h*), where h is a height of a tree
    @discardableResult
    public func remove() -> BinarySearchTree? {
        // We find replacement to the node that will be deleted
        // Note: replacement can be either biggest node on the left or
        //       smallest one on the right
        //       Of course, as well nil if the right and the left don't exist
        let nodeToReplace: BinarySearchTree?
        if let right = self.right {
            nodeToReplace = right.minNode()
        } else if let left = self.left {
            nodeToReplace = left.maxNode()
        } else {
            nodeToReplace = nil
        }
        
        // After, we must delete replacement from the tree
        // Note: it's a leaf, so replacement node for its is a nil
        nodeToReplace?.remove()
        
        // Then we change the connections of the replacement
        // (we prepare its for the new home)
        nodeToReplace?.right = self.right
        nodeToReplace?.left = self.left
        self.right?.parent = nodeToReplace
        self.left?.parent = nodeToReplace
        
        // But we must not forget about the parent
        // Here we still refer to the node that will be deleted
        if let parent = self.parent {
            if isLeftChild { parent.left = nodeToReplace }
            else { parent.right = nodeToReplace }
        }
        // After this line, all communication with the node being deleted will be lost
        nodeToReplace?.parent = parent
        
        // However, it stores the references - delete them
        self.parent = nil
        self.left = nil
        self.right = nil
        
        // That's all
        return nodeToReplace
    }
}

/// Map and filter methods in different orders
/// Complexity(for all): O(*n*), where n is a count of nodes in a tree
/// MARK: map() and filter() methods do inorder traversal
extension BinarySearchTree {
    public func map(_ transform: (T) -> T) -> [T] {
        var array = [T]()
        if let leftChild = self.left {
            array.append(contentsOf: leftChild.map(transform))
        }
        array.append(transform(value))
        if let rightChild = self.right {
            array.append(contentsOf: rightChild.map(transform))
        }
        return array
    }
    public func mapInPostOrder(_ transform: (T) -> T) -> [T] {
        var array = [T]()
        if let leftChild = self.left {
            array.append(contentsOf: leftChild.mapInPostOrder(transform))
        }
        if let rightChild = self.right {
            array.append(contentsOf: rightChild.mapInPostOrder(transform))
        }
        array.append(transform(value))
        return array
    }
    public func mapInPreOrder(_ transform: (T) -> T) -> [T] {
        var array = [T]()
        array.append(transform(value))
        if let leftChild = self.left {
            array.append(contentsOf: leftChild.mapInPreOrder(transform))
        }
        if let rightChild = self.right {
            array.append(contentsOf: rightChild.mapInPreOrder(transform))
        }
        return array
    }
    public func toArray() -> [T] { return map { $0 } }
    public func toArrayInPostOrder() -> [T] { return mapInPostOrder { $0 } }
    public func toArrayInPreOrder() -> [T] { return mapInPreOrder { $0 } }
    
    public func filter(_ condition: (T) -> Bool) -> [T] {
        var array = [T]()
        if self.left != nil && self.left!.value == value {
            array.append(contentsOf: self.left!.filter(condition))
        }
        array.append(value)
        if self.right != nil && self.right!.value == value {
            array.append(contentsOf: self.right!.filter(condition))
        }
        return array
    }
    public func filterInPreOrder(_ condition: (T) -> Bool) -> [T] {
        var array = [T]()
        array.append(value)
        if self.left != nil && self.left!.value == value {
            array.append(contentsOf: self.left!.filter(condition))
        }
        if self.right != nil && self.right!.value == value {
            array.append(contentsOf: self.right!.filter(condition))
        }
        return array
    }
    public func filterInPostOrder(_ condition: (T) -> Bool) -> [T] {
        var array = [T]()
        if self.left != nil && self.left!.value == value {
            array.append(contentsOf: self.left!.filter(condition))
        }
        if self.right != nil && self.right!.value == value {
            array.append(contentsOf: self.right!.filter(condition))
        }
        array.append(value)
        return array
    }
}

/// Method that checks the left tree stores values that are less than the current node value,
/// and that the right tree stores values that are larger than the current node value
/// Example: (note: we check from the root node)
/// [0] <- [15] -> [100] is a valid binary search tree
/// [[0] -> [100]] <- [15] is a not valid binary search tree, because 100 > 15
/// Complexity: O(*n*), where h is a count of of nodes in a tree
extension BinarySearchTree {
    public func isValid(from minValue: T, to maxValue: T) -> Bool {
        if value < minValue || value > maxValue { return false }
        
        let leftValid: Bool = left?.isValid(from: minValue, to: value) ?? true
        let rightValid: Bool = right?.isValid(from: value, to: maxValue) ?? true
        return leftValid && rightValid
    }
}

/// Searching predecessor and successor nodes
/// Complexity: O(*h*), where h is a height of a tree
extension BinarySearchTree {
    public func predecessor() -> BinarySearchTree? {
        if let left = self.left {
            return left.maxNode()
        } else {
            var current = self
            while let parent = current.parent {
                if parent.value < self.value {
                    return parent
                } else { current = parent }
            }
        }
        return nil
    }
}

/// Convenience initializer that receive an array
/// Complexity: O(*nh(n)*), where n is a count of items in an array
///                         and h(n) is a height of a tree
/// MARK: h(n) is measured after adding all nodes
extension BinarySearchTree {
    public convenience init(array: [T]) {
        precondition(array.count > 0)
        self.init(value: array.first!)
        for value in array.dropFirst() {
            insert(newValue: value)
        }
    }
}

/// Debug output extension
extension BinarySearchTree: CustomStringConvertible {
    public var description: String {
        var str = ""
        if let leftChild = self.left {
            str += "[\(leftChild.description)] <- "
        }
        str += "\(value)"
        if let rightChild = self.right {
            str += " -> [\(rightChild.description)]"
        }
        return str
    }
}
