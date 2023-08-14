import XCTest

final class RedBlackTreeTest: XCTestCase {
    func testTree() {
        let tree = RedBlackTree<Int, String>()
        let array = (1...15)
        
        for item in array {
            tree.insert(key: item)
        }
        
        print(tree)
        print(tree.root.key!)
        
        for item in array.shuffled() {
            tree.remove(key: item)
            XCTAssertNil(tree.search(key: item))
        }
    }
}
