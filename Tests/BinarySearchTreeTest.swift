//
//  BinarySearchTreeTest.swift
//  Tests
//
//  Created by Timur Murzakov on 05/08/2023.
//

import XCTest

final class BinarySearchTreeTest: XCTestCase {
    private func testUniversal<T>(
        tree: BinarySearchTree<T>,
        value: T,
        parentValue: T?,
        leftValue: T?,
        rightValue: T?,
        count: Int,
        isRoot: Bool,
        isLeaf: Bool,
        isLeftChild: Bool,
        isRightChild: Bool,
        hasLeftChild: Bool,
        hasRightChild: Bool,
        hasAChild: Bool,
        hasBothChildren: Bool,
        height: Int,
        depth: Int,
        minNodeValue: T,
        maxNodeValue: T,
        toArray: inout [T],
        toArrayPreOrder: inout [T],
        toArrayPostOrder: inout [T]
    ) {
        XCTAssertEqual(tree.value, value)
        XCTAssertEqual(tree.parent?.value, parentValue)
        XCTAssertEqual(tree.left?.value, leftValue)
        XCTAssertEqual(tree.right?.value, rightValue)
        XCTAssertEqual(tree.count, count)
        XCTAssertEqual(tree.isRoot, isRoot)
        XCTAssertEqual(tree.isLeaf, isLeaf)
        XCTAssertEqual(tree.isLeftChild, isLeftChild)
        XCTAssertEqual(tree.isRightChild, isRightChild)
        XCTAssertEqual(tree.hasLeftChild, hasLeftChild)
        XCTAssertEqual(tree.hasRightChild, hasRightChild)
        XCTAssertEqual(tree.hasAChild, hasAChild)
        XCTAssertEqual(tree.hasBothChildren, hasBothChildren)
        XCTAssertEqual(tree.height(), height)
        XCTAssertEqual(tree.depth(), depth)
        XCTAssertEqual(tree.minNode().value, minNodeValue)
        XCTAssertEqual(tree.maxNode().value, maxNodeValue)
        XCTAssertEqual(tree.toArray(), toArray)
        XCTAssertEqual(tree.toArrayInPreOrder(), toArrayPreOrder)
        XCTAssertEqual(tree.toArrayInPostOrder(), toArrayPostOrder)
    }
    private func testSearchAllNodes<T>(tree: BinarySearchTree<T>, nodes: [T]) {
        for node in nodes {
            XCTAssertEqual(tree.search(value: node)!.value, node)
        }
    }
    
    func testOnlyRoot() {
        let tree = BinarySearchTree(value: 12)
        var arrayIn = [12]
        var arrayPre = [12]
        var arrayPost = [12]
        
        testUniversal(tree: tree, value: 12, parentValue: nil, leftValue: nil, rightValue: nil, count: 1, isRoot: true, isLeaf: true, isLeftChild: false, isRightChild: false, hasLeftChild: false, hasRightChild: false, hasAChild: false, hasBothChildren: false, height: 1, depth: 0, minNodeValue: 12, maxNodeValue: 12, toArray: &arrayIn, toArrayPreOrder: &arrayPre, toArrayPostOrder: &arrayPost)
    }
    
    func testInitFromArray() {
        let tree = BinarySearchTree(array: [10,5,3,2,8,11,65,10,255,64])
        var arrayIn = [2, 3, 5, 8, 10, 10, 11, 64, 65, 255]
        var arrayPre = [10, 5, 3, 2, 8, 11, 10, 65, 64, 255]
        var arrayPost = [2, 3, 8, 5, 10, 64, 255, 65, 11, 10]
        
        testUniversal(tree: tree, value: 10, parentValue: nil, leftValue: 5, rightValue: 11, count: 10, isRoot: true, isLeaf: false, isLeftChild: false, isRightChild: false, hasLeftChild: true, hasRightChild: true, hasAChild: true, hasBothChildren: true, height: 4, depth: 0, minNodeValue: 2, maxNodeValue: 255, toArray: &arrayIn, toArrayPreOrder: &arrayPre, toArrayPostOrder: &arrayPost)
        testSearchAllNodes(tree: tree, nodes: arrayPost)
        
        let node1 = tree.search(value: 255)
        XCTAssertEqual(node1!.height(), 1)
        XCTAssertEqual(node1!.depth(), 3)
        
        let node2 = tree.search(value: 8)
        XCTAssertEqual(node2!.height(), 1)
        XCTAssertEqual(node2!.depth(), 2)
    }
    
    func testInsert() {
        let tree = BinarySearchTree(value: 12)
        
        tree.insert(newValue: 4)
        XCTAssertEqual(tree.count, 2)
        XCTAssertEqual(tree.height(), 2)
        XCTAssertEqual(tree.depth(), 0)
        
        let node1 = tree.search(value: 4)
        XCTAssertEqual(node1!.height(), 1)
        XCTAssertEqual(node1!.depth(), 1)
        
        tree.insert(newValue: 13)
        XCTAssertEqual(tree.count, 3)
        XCTAssertEqual(tree.height(), 2)
        
        let node2 = tree.search(value: 13)
        XCTAssertEqual(node2!.height(), 1)
        XCTAssertEqual(node2!.depth(), 1)
        
        tree.insert(newValue: 8)
        XCTAssertEqual(tree.count, 4)
        XCTAssertEqual(tree.height(), 3)
        
        let node3 = tree.search(value: 8)
        XCTAssertEqual(node3!.height(), 1)
        XCTAssertEqual(node3!.depth(), 2)
        
        var arrayIn = [4,8,12,13]
        var arrayPre = [12,4,8,13]
        var arrayPost = [8,4,13,12]
        testUniversal(tree: tree, value: 12, parentValue: nil, leftValue: 4, rightValue: 13, count: 4, isRoot: true, isLeaf: false, isLeftChild: false, isRightChild: false, hasLeftChild: true, hasRightChild: true, hasAChild: true, hasBothChildren: true, height: 3, depth: 0, minNodeValue: 4, maxNodeValue: 13, toArray: &arrayIn, toArrayPreOrder: &arrayPre, toArrayPostOrder: &arrayPost)
    }
    
    func testInsertSorted() {
        var array = [10,5,3,2,8,11,65,10,255,64].sorted(by: <)
        var array1 = array
        var array2 = array.sorted(by: >)
        let tree = BinarySearchTree(array: array)
        testUniversal(tree: tree, value: 2, parentValue: nil, leftValue: nil, rightValue: 3, count: 10, isRoot: true, isLeaf: false, isLeftChild: false, isRightChild: false, hasLeftChild: false, hasRightChild: true, hasAChild: true, hasBothChildren: false, height: 10, depth: 0, minNodeValue: 2, maxNodeValue: 255, toArray: &array, toArrayPreOrder: &array1, toArrayPostOrder: &array2)
        testSearchAllNodes(tree: tree, nodes: array)
        
        let node1 = tree.search(value: 255)
        XCTAssertEqual(node1?.height(), 1)
        XCTAssertEqual(node1?.depth(), 9)
    }
    
    func testRemoveLeafs() {
        let tree = BinarySearchTree(array: [2,1,3,4])
        
        var arrayIn = [4]
        var arrayPre = [4]
        var arrayPost = [4]
        let node4 = tree.search(value: 4)
        testUniversal(tree: node4!, value: 4, parentValue: 3, leftValue: nil, rightValue: nil, count: 1, isRoot: false, isLeaf: true, isLeftChild: false, isRightChild: true, hasLeftChild: false, hasRightChild: false, hasAChild: false, hasBothChildren: false, height: 1, depth: 2, minNodeValue: 4, maxNodeValue: 4, toArray: &arrayIn, toArrayPreOrder: &arrayPre, toArrayPostOrder: &arrayPost)
        let replaceFor4 = node4!.remove()
        XCTAssertNil(replaceFor4)
        XCTAssertNil(tree.search(value:3)!.left)
        
        let node1 = tree.search(value: 1)
        arrayIn = [1]
        arrayPre = [1]
        arrayPost = [1]
        testUniversal(tree: node1!, value: 1, parentValue: 2, leftValue: nil, rightValue: nil, count: 1, isRoot: false, isLeaf: true, isLeftChild: true, isRightChild: false, hasLeftChild: false, hasRightChild: false, hasAChild: false, hasBothChildren: false, height: 1, depth: 1, minNodeValue: 1, maxNodeValue: 1, toArray: &arrayIn, toArrayPreOrder: &arrayPre, toArrayPostOrder: &arrayPost)
        let replaceFor1 = node1!.remove()
        XCTAssertNil(replaceFor1)
        XCTAssertNil(tree.left)
        
        let node3 = tree.search(value: 3)
        arrayIn = [3]
        arrayPre = [3]
        arrayPost = [3]
        testUniversal(tree: node3!, value: 3, parentValue: 2, leftValue: nil, rightValue: nil, count: 1, isRoot: false, isLeaf: true, isLeftChild: false, isRightChild: true, hasLeftChild: false, hasRightChild: false, hasAChild: false, hasBothChildren: false, height: 1, depth: 1, minNodeValue: 3, maxNodeValue: 3, toArray: &arrayIn, toArrayPreOrder: &arrayPre, toArrayPostOrder: &arrayPost)
        let replaceFor3 = node3!.remove()
        XCTAssertNil(replaceFor3)
        XCTAssertNil(tree.right)
        
        arrayIn = [2]
        arrayPre = [2]
        arrayPost = [2]
        testUniversal(tree: tree, value: 2, parentValue: nil, leftValue: nil, rightValue: nil, count: 1, isRoot: true, isLeaf: true, isLeftChild: false, isRightChild: false, hasLeftChild: false, hasRightChild: false, hasAChild: false, hasBothChildren: false, height: 1, depth: 0, minNodeValue: 2, maxNodeValue: 2, toArray: &arrayIn, toArrayPreOrder: &arrayPre, toArrayPostOrder: &arrayPost)
    }
    
    func testRemoveLeftNode() {
        let tree = BinarySearchTree(array: [4,1,5,3,5])
        
        let node1 = tree.search(value: 1)
        let node3 = tree.search(value: 3)!
        var arrayIn = [1,3]
        var arrayPre = [1,3]
        var arrayPost = [3,1]
        testUniversal(tree: node1!, value: 1, parentValue: 4, leftValue: nil, rightValue: 3, count: 2, isRoot: false, isLeaf: false, isLeftChild: true, isRightChild: false, hasLeftChild: false, hasRightChild: true, hasAChild: true, hasBothChildren: false, height: 2, depth: 1, minNodeValue: 1, maxNodeValue: 3, toArray: &arrayIn, toArrayPreOrder: &arrayPre, toArrayPostOrder: &arrayPost)
        node1!.remove()
        XCTAssertTrue(tree.left === node3)
        XCTAssertTrue(tree === node3.parent)
        XCTAssertFalse(node3.hasBothChildren)
        XCTAssertEqual(tree.count, 4)
    }
    
    func testRemoveRightNode() {
        let tree = BinarySearchTree(array: [4,1,5,3,6])
        
        let node5 = tree.search(value: 5)
        let node6 = tree.search(value: 6)!
        var arrayIn = [5,6]
        var arrayPre = [5,6]
        var arrayPost = [6,5]
        testUniversal(tree: node5!, value: 5, parentValue: 4, leftValue: nil, rightValue: 6, count: 2, isRoot: false, isLeaf: false, isLeftChild: false, isRightChild: true, hasLeftChild: false, hasRightChild: true, hasAChild: true, hasBothChildren: false, height: 2, depth: 1, minNodeValue: 5, maxNodeValue: 6, toArray: &arrayIn, toArrayPreOrder: &arrayPre, toArrayPostOrder: &arrayPost)
        node5!.remove()
        XCTAssertTrue(tree.right === node6)
        XCTAssertTrue(tree === node6.parent)
        XCTAssertFalse(node6.hasBothChildren)
        XCTAssertEqual(tree.count, 4)
    }
    
    func testRemoveRoot() {
        let tree = BinarySearchTree(array: [4,1,5,3,6])
        
        let node5 = tree.search(value: 5)!
        tree.remove()
        var arrayIn = [1,3,5,6]
        var arrayPre = [5,1,3,6]
        var arrayPost = [3,1,6,5]
        testUniversal(tree: node5, value: 5, parentValue: nil, leftValue: 1, rightValue: 6, count: 4, isRoot: true, isLeaf: false, isLeftChild: false, isRightChild: false, hasLeftChild: true, hasRightChild: true, hasAChild: true, hasBothChildren: true, height: 3, depth: 0, minNodeValue: 1, maxNodeValue: 6, toArray: &arrayIn, toArrayPreOrder: &arrayPre, toArrayPostOrder: &arrayPost)
    }
}
