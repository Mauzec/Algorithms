import XCTest


class LinkedListTest: XCTestCase {
    let numbers = [2,3,1,2,3,4,5,1,51,5,435,23,321]
    
    fileprivate func buildList() -> LinkedList<Int> {
        let list = LinkedList<Int>()
        for x in numbers {
            list.append(x)
        }
        
        return list
    }
    
    func testEmptyList() {
        let list = LinkedList<Int>()
        XCTAssertTrue(list.isEmpty)
        XCTAssertEqual(list.count, 0)
        XCTAssertNil(list.first)
        XCTAssertNil(list.tail)
    }
    
    func testListOneElement() {
        let list = LinkedList<Int>()
        list.append(123)
        
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 1)
        
        XCTAssertNotNil(list.first)
        XCTAssertNil(list.head!.previous)
        XCTAssertNil(list.head!.next)
        XCTAssertEqual(list.first, 123)
        XCTAssertEqual(list.first, list.head!.value)
        
        XCTAssertNotNil(list.tail)
        XCTAssertNil(list.tail!.previous)
        XCTAssertNil(list.tail!.next)
        XCTAssertEqual(list.tail!.value, 123)
        XCTAssertEqual(list.first, list.tail!.value)
        
        XCTAssertTrue(list.head === list.tail)
    }
    
    func testListTwoElement() {
        let list = LinkedList<String>()
        list.append("fallen")
        list.append("133")
        
        XCTAssertEqual(list.count, 2)
        
        XCTAssertNotNil(list.first)
        XCTAssertEqual(list.head!.value, "fallen")
        
        XCTAssertNotNil(list.tail)
        XCTAssertEqual(list.tail!.value, "133")
        
        XCTAssertTrue(list.head !== list.tail)
        XCTAssertTrue(list.tail!.value == list[1])
        
        XCTAssertNil(list.head!.previous)
        XCTAssertNil(list.tail!.next)
        XCTAssertTrue(list.head!.next === list.tail)
        XCTAssertTrue(list.tail!.previous === list.head)
    }
    
    func testListThreeElement() {
        let list = LinkedList<Double>()
        list.append(3.5)
        list.append(4.55)
        list.append(5.555)
        
        XCTAssertEqual(list.count, 3)
        
        XCTAssertNotNil(list.first)
        XCTAssertEqual(list.head!.value, 3.5)
        
        let sec = list.head!.next
        XCTAssertNotNil(sec)
        XCTAssertEqual(sec!.value, 4.55)
        XCTAssertEqual(sec!.value, list[1])
        
        let third = list.tail
        XCTAssertNotNil(third)
        XCTAssertEqual(third!.value, 5.555)
        XCTAssertEqual(third!.value, list[2])
        
        XCTAssertNil(list.head!.previous)
        XCTAssertTrue(list.head!.next === sec)
        XCTAssertTrue(sec!.previous === list.head)
        XCTAssertEqual(sec!.previous!.value, list.head!.value)
        XCTAssertTrue(sec!.next === list.tail)
        XCTAssertEqual(sec!.next!.value, list.tail!.value)
        XCTAssertTrue(sec === list.tail!.previous)
        XCTAssertNil(list.tail!.next)
    }
    
    func testSubscript() {
        let list = buildList()
        for i in 0..<list.count {
            XCTAssertEqual(list[i], numbers[i])
        }
    }
    
    func testInsertAtIndexInEmpty() {
        let list = LinkedList<Int>()
        list.insert(123, at: 0)
        
        XCTAssertFalse(list.isEmpty)
        XCTAssertEqual(list.count, 1)
        
        let node = list.node(at: 0)
        XCTAssertNotNil(node)
        XCTAssertEqual(node.value, 123)
        XCTAssertTrue(list.head === node)
    }
    
    func testInsertAtIndex() {
        let list = buildList()
        let prev = list.node(at:2)
        let next = list.node(at:3)
        
        list.insert(432333, at: 3)
        
        let node = list.node(at:3)
        XCTAssertNotNil(node)
        XCTAssertEqual(node.value, 432333)
        XCTAssertEqual(list.count, 14)
        
        XCTAssertFalse(prev === node)
        XCTAssertFalse(next === node)
        XCTAssertTrue(prev.next === node)
        XCTAssertTrue(next.previous === node)
    }
    
    func testRemoveAtIndex() {
        let list = buildList()
        let prev = list.node(at: 2)
        let next = list.node(at: 3)
        list.insert(12333, at: 3)
        
        let value = list.remove(at: 3)
        XCTAssertEqual(value, 12333)
        
        let node = list.node(at: 3)
        XCTAssertTrue(node === next)
        XCTAssertTrue(prev.next === node)
        XCTAssertTrue(next.previous === prev)
        XCTAssertEqual(list.count, 13)
    }
}
