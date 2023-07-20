import XCTest

class StackTest: XCTestCase {
    func testEmpty() {
        var stack = Stack<Int>()
        XCTAssertTrue(stack.isEmpty)
        XCTAssertEqual(stack.count, 0)
        XCTAssertEqual(stack.top, nil)
        XCTAssertNil(stack.pop())
    }
    
    func testOneElement() {
        var stack = Stack<Int>()
        stack.push(45244)
        
        XCTAssertFalse(stack.isEmpty)
        XCTAssertEqual(stack.count, 1)
        XCTAssertEqual(stack.top, 45244)
        
        let result = stack.pop()
        XCTAssertEqual(result, 45244)
        XCTAssertTrue(stack.isEmpty)
        XCTAssertEqual(stack.count, 0)
        XCTAssertEqual(stack.top, nil)
        XCTAssertNil(stack.pop())
    }
    
    func testTwoElement() {
        var stack = Stack<Int>()
        stack.push(1233)
        stack.push(4444)
        
        XCTAssertFalse(stack.isEmpty)
        XCTAssertEqual(stack.count, 2)
        XCTAssertEqual(stack.top, 4444)
        
        let result1 = stack.pop()
        XCTAssertEqual(4444, result1)
        XCTAssertEqual(stack.count, 1)
        XCTAssertEqual(stack.top, 1233)
        
        let result2 = stack.pop()
        XCTAssertEqual(1233, result2)
        XCTAssertTrue(stack.isEmpty)
        XCTAssertEqual(stack.count, 0)
        XCTAssertEqual(stack.top, nil)
        
        let result3 = stack.pop()
        XCTAssertNil(result3)
    }
}
