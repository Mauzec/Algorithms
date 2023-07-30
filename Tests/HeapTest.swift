import XCTest

class HeapTest: XCTestCase {
    private func testMax(heap: Heap<Int>) -> Bool {
        for index in 0..<heap.count {
            let left = heap.left(of: index)
            let right = heap.right(of: index)
            let parent = heap.parent(of: index)
            
            if left < heap.count && heap.elements[index] < heap.elements[left] {
                return false
            }
            if right < heap.count && heap.elements[index] < heap.elements[right] {
                return false
            }
            
            if index > 0 && heap.elements[parent] < heap.elements[index] {
                return false
            }
        }
        return true
    }
    private func testMin(heap: Heap<Int>) -> Bool {
        for index in 0..<heap.count {
            let left = heap.left(of: index)
            let right = heap.right(of: index)
            let parent = heap.parent(of: index)
            
            if left < heap.count && heap.elements[index] > heap.elements[left] {
                return false
            }
            if right < heap.count && heap.elements[index] > heap.elements[right] {
                return false
            }
            
            if index > 0 && heap.elements[parent] > heap.elements[index] {
                return false
            }
        }
        return true
    }
    
    func testEmpty() {
        var heap = Heap<Int>(orderFunc: <)
        XCTAssertEqual(heap.isEmpty, true)
        XCTAssertEqual(heap.count, 0)
        XCTAssertEqual(heap.peek(), nil)
        XCTAssertEqual(heap.deq(), nil)
    }
    
    func testIsEmptyMethod() {
        var heap = Heap<Int>(orderFunc: >)
        XCTAssertEqual(heap.isEmpty, true)
        heap.enq(Int.max)
        XCTAssertEqual(heap.isEmpty, false)
        heap.deq()
        XCTAssertEqual(heap.isEmpty, true)
    }
    func testCountMethod() {
        var heap = Heap<Int>(orderFunc: <=)
        XCTAssertEqual(heap.count, 0)
        heap.enq(Int.max - 1)
        XCTAssertEqual(heap.count, 1)
        heap.enq(Int.max - 2)
        XCTAssertEqual(heap.count, 2)
        XCTAssertEqual(heap.deq(), Int.max - 2)
        XCTAssertEqual(heap.count, 1)
        XCTAssertEqual(heap.deq(), Int.max - 1)
        XCTAssertEqual(heap.count, 0)
    }
    
    func testInitMaxHeap() {
        let heapBaby = Heap((1...10).map { $0 }, orderFunc: >=)
        // to do
    }
    func testOneElementMaxHeap() {
        let heap = Heap<Int>([Int.max], orderFunc: <=)
        XCTAssertTrue(testMax(heap: heap))
        XCTAssertTrue(testMin(heap: heap))
        XCTAssertEqual(heap.isEmpty, false)
        XCTAssertEqual(heap.count, 1)
        XCTAssertEqual(heap.peek()!, Int.max)
    }
}
