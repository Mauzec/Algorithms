import XCTest

class QueueTest: XCTestCase {
    func testEmpty() {
        var queue = Queue<Array<String>>()
        XCTAssertTrue(queue.isEmpty)
        XCTAssertNil(queue.deq())
        XCTAssertEqual(queue.count, 0)
        XCTAssertEqual(queue.front, nil)
    }
    
    func testOneElement() {
        var queue = Queue<Array<String>>()
        
        let faats = ["fallen", "angel", "at", "the", "sea"]
        queue.enq(["fallen", "angel", "at", "the", "sea"])
        
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 1)
        XCTAssertEqual(queue.front, faats)
        
        let result1 = queue.deq()
        XCTAssertEqual(result1, faats)
        XCTAssertTrue(queue.isEmpty)
        XCTAssertEqual(queue.count, 0)
        XCTAssertEqual(queue.front, nil)
        XCTAssertEqual(queue.deq(), nil)
    }
    
    func testTwentyElement() {
        var queue = Queue<Array<String>>()
        
        for x in 0..<20 {
            queue.enq([String(x)])
        }
        
        XCTAssertFalse(queue.isEmpty)
        XCTAssertEqual(queue.count, 20)
        XCTAssertEqual(queue.front, ["0"])
        
        for y in 0..<19 {
            let result1 = queue.deq()
            XCTAssertEqual(result1, [String(y)])
            XCTAssertFalse(queue.isEmpty)
            XCTAssertEqual(queue.count, 20 - y - 1)
            XCTAssertEqual(queue.front, [String(y+1)])
        }
        
        let result2 = queue.deq()
        XCTAssertEqual(result2, [String(19)])
        XCTAssertTrue(queue.isEmpty)
        XCTAssertEqual(queue.count, 0)
        XCTAssertEqual(queue.front, nil)
        XCTAssertEqual(queue.deq(), nil)
    }
}
