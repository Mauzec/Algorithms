public struct HashTable <Key: Hashable, Value> {
    /// to avoid collisions, it uses multi-array
    /// example:
    /// -- [0] -> [("Granny": "Panam Storm") /-> ("Baby": "Little Vikky")]
    /// -- [1] -> [("Me": "Untitled")]
    /// -- [2] -> []
    /// -- [3] -> [("Teacher": "Ms Tutly") /-> ("Anon": "Anon") /-> ("Dad": "George Senior Storm")]
    /// == it find index after hash value found, and then if array[index] have collisions, it searches the tutle by comparing the keys(this increases complexity, unfort.)
    private typealias Element = (key: Key, value: Value)
    private typealias Bucket = [Element]
    private var buckets: [Bucket]
    
    private(set) var count: Int = 0
    public var isEmpty: Bool {
        return count == 0
    }
    
    /// default initializer (it creates "empty" hash table)
    public init(capacity c: Int) {
        assert(c > 0)
        buckets = Array<Bucket>(repeatElement([], count: c))
    }
    
    /// returns buckets index of key given
    private func index(forKey key: Key) -> Int {
        return abs(key.hashValue % buckets.count)
    }
    
    /// searches value for key given
    /// MARK:   it has complexity O(m)
    ///         m - number of elements in buckets[index]
    /// returns old value if exists else nil
    public mutating func value(forKey key: Key) -> Value? {
        let index = index(forKey: key)
        
        for element in buckets[index] {
            if element.key == key {
                return element.value
            }
        }
        return nil
    }
    
    /// updates value for key given
    /// MARK:   it has complexity O(m) in the worst case
    ///         m - number of elements in buckets[index]
    /// returns value if exists else nil
    @discardableResult public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        let index = index(forKey: key)
        
        // do it really has key given?
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index][i].value = value
                return element.value
            }
        }
        return nil
    }
    
    /// appends new value with key given
    /// MARK:   it has complexity O(m)
    ///         m - number of elements in buckets[index]
    /// WARNING: please remember that this method doesn't check for the presence of key given in the table
    ///          if you want to check, you've to set isHere to true (default: false)
    /// returns value if exists else nil
    @discardableResult public mutating func append(_ value: Value, forKey key: Key, isHere: Bool = false) -> Value? {
        let index = index(forKey: key)
        
        if isHere {
            for element in buckets[index] {
                if element.key == key {
                    return element.value
                }
            }
        }
        
        buckets[index].append((key: key, value: value))
        count += 1
        return nil
        
    }
    /// removes value for key given
    /// MARK:   it has complexity O(m) in the worst case
    ///         m - number of elements in buckets[index]
    /// returns value removed if exists else nil
    @discardableResult public mutating func removeValue(_ value: Value, forKey key: Key) -> Value? {
        let index = index(forKey: key)
        
        for (i, element) in buckets[index].enumerated() {
            if element.key == key {
                buckets[index].remove(at: i)
                count -= 1
                return element.value
            }
        }
        return nil
    }
    
    public mutating func removeAll() {
        buckets = Array<Bucket>(repeatElement([], count: buckets.count))
        count = 0
    }
}
