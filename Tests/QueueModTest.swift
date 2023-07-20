import XCTest

class QueueModTest: XCTestCase {
    func testEmpty() {
        var queue = Queue<Int>()
        XCTAssertTrue(queue.isEmpty)
        XCTAssertEqual(queue.count, 0)
        XCTAssertEqual(queue.front, nil)
        XCTAssertNil(queue.deq())
    }
    
    func testOneElement() {
        var queue = Queue<Int>()
        queue.enq(132)
        
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 1)
        XCTAssertEqual(queue.front, 132)
        
        let result1 = queue.deq()
        XCTAssertEqual(result1, 132)
        XCTAssertTrue(queue.isEmpty)
        XCTAssertEqual(queue.count, 0)
        XCTAssertEqual(queue.front, nil)
    }
    
    func testTwoElement() {
        var queue = Queue<Int>()
        queue.enq(132)
        queue.enq(465)
        
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 2)
        XCTAssertEqual(queue.front, 132)
        
        let result1 = queue.deq()
        XCTAssertEqual(result1, 132)
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 1)
        XCTAssertEqual(queue.front, 465)
        
        let result2 = queue.deq()
        XCTAssertEqual(result2, 465)
        XCTAssertTrue(queue.isEmpty)
        XCTAssertEqual(queue.count, 0)
        XCTAssertEqual(queue.front, nil)
    }
}
