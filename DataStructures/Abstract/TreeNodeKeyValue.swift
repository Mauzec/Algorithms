public protocol TreeNodeKeyValue: AnyObject {
    associatedtype Key: Comparable
    associatedtype Value
    
    var key: Key?  {get}
    var value: Value? {get}
    var leftChild: Self? {get}
    var rightChild: Self? {get}
    var parent: Self? {get}
}

public extension TreeNodeKeyValue {
    var isRoot: Bool {
        return parent == nil
    }
    
    var isLeftChild: Bool {
        return parent?.leftChild === self
    }
    
    var isRightChild: Bool {
        return parent?.rightChild === self
    }
    
    var hasLeftChild: Bool {
        return leftChild != nil
    }
    
    var hasRightChild: Bool {
        return rightChild != nil
    }
}
