import XCTest

public class CircularBufferTest: XCTestCase {
    fileprivate func testEmpty<T: Equatable>(buffer: inout CircularBuffer<T>) -> Bool {
        guard buffer.isEmpty, buffer.isFull, buffer.read() == nil, Array(buffer) == [], buffer.array == []
        else { return false}
        return true
    }
    func testEmptyArrayInit() {
        var buffer = CircularBuffer<String>([])
        XCTAssertTrue(buffer.isEmpty)
        XCTAssertTrue(buffer.isFull)
        XCTAssertNil(buffer.read())
        XCTAssertFalse(buffer.write("CL"))
        XCTAssertEqual(Array(buffer), [])
        XCTAssertEqual(buffer.array, [])
    }
    func testFiveElement() {
        var buffer = CircularBuffer<String>(count: 5)
        XCTAssertTrue(buffer.isEmpty)
        XCTAssertFalse(buffer.isFull)
        XCTAssertNil(buffer.read())
        XCTAssertEqual(Array(buffer), [])
        XCTAssertEqual(buffer.array, [nil, nil, nil, nil, nil])
        
        XCTAssertTrue(buffer.write("I"))
        XCTAssertTrue(buffer.write("am"))
        XCTAssertTrue(buffer.write("in"))
        XCTAssertTrue(buffer.write("your"))
        XCTAssertTrue(buffer.write("heart"))
        XCTAssertFalse(buffer.write("Sorry"))
        
        XCTAssertFalse(buffer.isEmpty)
        XCTAssertTrue(buffer.isFull)
        XCTAssertEqual(Array(buffer), ["I", "am", "in", "your", "heart"])
        XCTAssertEqual(buffer.array, ["I", "am", "in", "your", "heart"])
        
        XCTAssertEqual(buffer.read(), "I")
        XCTAssertTrue(buffer.write("Sorry, but I"))
        XCTAssertEqual(Array(buffer), ["am", "in", "your", "heart", "Sorry, but I"])
        XCTAssertEqual(buffer.array, ["Sorry, but I", "am", "in", "your", "heart"])
        XCTAssertTrue(buffer.isFull)
        
        XCTAssertEqual(buffer.read(), "am")
        XCTAssertEqual(buffer.read(), "in")
        XCTAssertEqual(buffer.read(), "your")
        XCTAssertEqual(buffer.read(), "heart")
        XCTAssertEqual(buffer.read(), "Sorry, but I")
        XCTAssertTrue(buffer.isEmpty)
        XCTAssertFalse(buffer.isFull)
        XCTAssertEqual(Array(buffer), [])
        XCTAssertEqual(buffer.array, [nil, nil, nil, nil, nil])
    }
}
