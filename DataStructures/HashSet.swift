/// Since Swift uses its hash table in the set(hash set) implementation,
/// I don't use the HashTable.swift I wrote,
/// but just take the Dictionary struct like <Key, Bool>
public struct HashSet<Key: Hashable> {
    private(set) var dict = Dictionary<Key, Bool>()
    public init() {}
    public var count: Int {
        return dict.count
    }
    public var isEmpty: Bool {
        return dict.isEmpty
    }
    
    public mutating func insert(_ element: Key) {
        dict[element] = true
    }
    public mutating func remove(_ element: Key) {
        dict[element] = nil
        
    }
    public func contains(_ element: Key) -> Bool {
        return dict[element] != nil
    }
    
    public func union(with set: HashSet<Key>) -> HashSet<Key> {
        var combo = HashSet<Key>()
        
        for key in dict.keys {
            combo.insert(key)
        }
        for key in set.dict.keys {
            combo.insert(key)
        }
        return combo
    }
    public func intersect(with set: HashSet<Key>) -> HashSet<Key> {
        var common = HashSet<Key>()
        
        for key in dict.keys {
            if set.contains(key) {
                common.insert(key)
            }
        }
        return common
    }
    public func difference(with set: HashSet<Key>) -> HashSet<Key> {
        var differ = HashSet<Key>()
        
        for key in dict.keys {
            if !(set.contains(key)) {
                differ.insert(key)
            }
        }
        return differ
    }
    
}
