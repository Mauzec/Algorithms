import XCTest

class HashSetTest: XCTestCase {
    func testEmpty() {
        var set = HashSet<Array<Double>>()
        
        XCTAssertEqual(set.count, 0)
        XCTAssertEqual(set.isEmpty, true)
        XCTAssertEqual(set.contains([2.33, 2.33, 2.33]), false)
        
        set.remove([2.33, 3.14, 2.714])
        XCTAssertEqual(set.count, 0)
        XCTAssertEqual(set.isEmpty, true)
    }
    
    func testOneElement() {
        var set = HashSet<Array<Double>>()
        set.insert([3.0, 0.1, 0.04])
        XCTAssertEqual(set.count, 1)
        XCTAssertEqual(set.isEmpty, false)
        XCTAssertEqual(set.contains([3.0, 0.1, 0.04]), true)
        XCTAssertEqual(set.contains([3.0, 0.1, 0.05]), false)
        
        var with = set
        with.remove([3.0, 0.1, 0.04])
        with.insert([3.0, 0.1, 0.05])
        
        var union = set.union(with: with)
        XCTAssertEqual(union.count, 2)
        XCTAssertEqual(union.isEmpty, false)
        XCTAssertEqual(union.contains([3.0, 0.1, 0.04]), true)
        XCTAssertEqual(union.contains([3.0, 0.1, 0.05]), true)
        XCTAssertEqual(union.contains([3.0, 0.1, 0.050001]), false)
        
        var intersect = set.intersect(with:with)
        XCTAssertEqual(intersect.count, 0)
        XCTAssertEqual(intersect.isEmpty, true)
        XCTAssertEqual(intersect.contains([3.0, 0.1, 0.04]), false)
        XCTAssertEqual(intersect.contains([3.0, 0.1, 0.05]), false)
        XCTAssertEqual(intersect.contains([3.0, 0.1, 0.050001]), false)
        
        var differ = set.difference(with: with)
        XCTAssertEqual(differ.count, set.count)
        XCTAssertEqual(differ.isEmpty, set.isEmpty)
        XCTAssertEqual(differ.contains([3.0]), set.contains([3.0]))
        
        set.remove([3.0, 0.1, 0.04])
        XCTAssertEqual(set.count, 0)
        XCTAssertEqual(set.isEmpty, true)
    }
}
