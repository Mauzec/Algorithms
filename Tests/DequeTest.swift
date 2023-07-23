import XCTest

final class DequeTest: XCTestCase {
    func testEmpty() {
        var deque = Deque<Array<String>>(100)
        
        XCTAssertEqual(deque.isEmpty, true)
        XCTAssertEqual(deque.count, 0)
        XCTAssertEqual(deque.front, nil)
        XCTAssertEqual(deque.back, nil)
        
        XCTAssertEqual(deque.deq(), nil)
        XCTAssertEqual(deque.isEmpty, true)
        XCTAssertEqual(deque.count, 0)
        XCTAssertEqual(deque.front, nil)
        XCTAssertEqual(deque.back, nil)
        
        XCTAssertEqual(deque.deqBack(), nil)
        XCTAssertEqual(deque.isEmpty, true)
        XCTAssertEqual(deque.count, 0)
        XCTAssertEqual(deque.front, nil)
        XCTAssertEqual(deque.back, nil)
    }
    
    func testOneElement() {
        var deque = Deque<Array<String>>(100)
        let element = ["i'll", "know", "swift"]
        
        deque.enq(element)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 1)
        XCTAssertEqual(deque.front, element)
        XCTAssertEqual(element, element)
        
        XCTAssertEqual(deque.deq(), element)
        XCTAssertEqual(deque.isEmpty, true)
        XCTAssertEqual(deque.count, 0)
        XCTAssertEqual(deque.front, nil)
        XCTAssertEqual(deque.back, nil)
        
        deque.enq(element)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 1)
        XCTAssertEqual(deque.front, element)
        XCTAssertEqual(deque.back, element)
        
        XCTAssertEqual(deque.deqBack(), element)
        XCTAssertEqual(deque.isEmpty, true)
        XCTAssertEqual(deque.count, 0)
        XCTAssertEqual(deque.front, nil)
        XCTAssertEqual(deque.back, nil)
        
        /// --- ///
        deque.enqFront(element)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 1)
        XCTAssertEqual(deque.front, element)
        XCTAssertEqual(deque.back, element)
        
        XCTAssertEqual(deque.deq(), element)
        XCTAssertEqual(deque.isEmpty, true)
        XCTAssertEqual(deque.count, 0)
        XCTAssertEqual(deque.front, nil)
        XCTAssertEqual(deque.back, nil)
        
        deque.enqFront(element)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 1)
        XCTAssertEqual(deque.front, element)
        XCTAssertEqual(deque.back, element)
        
        XCTAssertEqual(deque.deqBack(), element)
        XCTAssertEqual(deque.isEmpty, true)
        XCTAssertEqual(deque.count, 0)
        XCTAssertEqual(deque.front, nil)
        XCTAssertEqual(deque.back, nil)
    }
    
    func testTwoElementEnqueueOnly() {
        var deque = Deque<Array<String>>(100)
        let element1 = ["I"]
        let element2 = ["Know"]
        
        deque.enq(element1)
        deque.enq(element2)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 2)
        XCTAssertEqual(deque.front, element1)
        XCTAssertEqual(deque.back, element2)
        
        XCTAssertEqual(deque.deq(), element1)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 1)
        XCTAssertEqual(deque.front, element2)
        XCTAssertEqual(deque.back, element2)
        
        deque.enq(element1)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 2)
        XCTAssertEqual(deque.front, element2)
        XCTAssertEqual(deque.back, element1)
        
        XCTAssertEqual(deque.deq(), element2)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 1)
        XCTAssertEqual(deque.front, element1)
        XCTAssertEqual(deque.back, element1)
        
        XCTAssertEqual(deque.deq(), element1)
        XCTAssertEqual(deque.isEmpty, true)
        XCTAssertEqual(deque.count, 0)
        XCTAssertEqual(deque.front, nil)
        XCTAssertEqual(deque.back, nil)
    }
    
    func testTwoElementEnqueueFrontOnly() {
        var deque = Deque<Array<String>>(100)
        let element1 = ["I"]
        let element2 = ["Know"]
        
        deque.enqFront(element1)
        deque.enqFront(element2)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 2)
        XCTAssertEqual(deque.front, element2)
        XCTAssertEqual(deque.back, element1)
        
        XCTAssertEqual(deque.deq(), element2)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 1)
        XCTAssertEqual(deque.front, element1)
        XCTAssertEqual(deque.back, element1)
        
        deque.enqFront(element2)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 2)
        XCTAssertEqual(deque.front, element2)
        XCTAssertEqual(deque.back, element1)
        
        XCTAssertEqual(deque.deq(), element2)
        XCTAssertEqual(deque.isEmpty, false)
        XCTAssertEqual(deque.count, 1)
        XCTAssertEqual(deque.front, element1)
        XCTAssertEqual(deque.back, element1)
        
        XCTAssertEqual(deque.deq(), element1)
        XCTAssertEqual(deque.isEmpty, true)
        XCTAssertEqual(deque.count, 0)
        XCTAssertEqual(deque.front, nil)
        XCTAssertEqual(deque.back, nil)
    }
}
