import XCTest

class HashTableTest: XCTestCase {
    var table: HashTable<String, Int>?
    
    func testEmpty() {
        var htable: HashTable<String, Int>
        if let t = table {
            htable = t
        } else {
            htable = HashTable<String, Int>(capacity: 10*12)
        }
        
        XCTAssertEqual(htable.count, 0)
        XCTAssertEqual(htable.isEmpty, true)
        XCTAssertEqual(htable.removeValue(120, forKey: "Mr John"), nil)
        XCTAssertEqual(htable.updateValue(120, forKey: "Ms Jonny"), nil)
        XCTAssertEqual(htable.value(forKey: "My Doggy"), nil)
    }
    
    func testOneElement() {
        var htable = HashTable<String, Int>(capacity: 10*13)
        table = htable
        testEmpty()
        
        htable.append(120, forKey: "Mr John")
        XCTAssertEqual(htable.count, 1)
        XCTAssertEqual(htable.isEmpty, false)
        XCTAssertEqual(htable.value(forKey: "Mr John"), 120)
        XCTAssertEqual(htable.updateValue(130, forKey: "Mr John"), 120)
        XCTAssertEqual(htable.value(forKey: "Mr John"), 130)
        
        XCTAssertEqual(htable.removeValue(130, forKey: "Mr John"), 130)
        table = htable
        testEmpty()
    }
    
    func testHundredElement() {
        var htable = HashTable<String, Int>(capacity: 10 * 14)
        table = htable
        testEmpty()
        
        for i in 0..<100 {
            XCTAssertEqual(htable.append(i, forKey: "++\(i).."), nil)
            XCTAssertEqual(htable.count, i+1)
            XCTAssertEqual(htable.isEmpty, false)
            XCTAssertEqual(htable.value(forKey: "++\(i).."), i)
        }
        
        for i in 0..<50 {
            XCTAssertEqual(htable.removeValue(i, forKey: "--\(i).."), nil)
            XCTAssertEqual(htable.removeValue(i, forKey: "++\(i).."), i)
            XCTAssertEqual(htable.count, 100 - 1 - i)
            XCTAssertEqual(htable.isEmpty, false)
            XCTAssertEqual(htable.value(forKey: "++\(i).."), nil)
        }
        
        for i in  (51..<100).reversed() {
            XCTAssertEqual(htable.removeValue(i, forKey: "--\(i).."), nil)
            XCTAssertEqual(htable.removeValue(i, forKey: "++\(i).."), i)
            XCTAssertEqual(htable.count, i - 50)
            XCTAssertEqual(htable.isEmpty, false)
            XCTAssertEqual(htable.value(forKey: "++\(i).."), nil)
        }
        
        XCTAssertEqual(htable.count, 1)
        XCTAssertEqual(htable.isEmpty, false)
        XCTAssertEqual(htable.value(forKey: "++\(99).."), nil)
        XCTAssertEqual(htable.value(forKey: "++\(50).."), 50)
        XCTAssertEqual(htable.updateValue(150, forKey: "++\(50).."), 50)
        XCTAssertEqual(htable.value(forKey: "++\(50).."), 150)
        
        htable.removeAll()
        table = htable
        testEmpty()
    }
}
