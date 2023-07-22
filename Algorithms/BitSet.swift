public struct BitSet {
    private(set) var count: Int
    
    private let WSize = 64
    public typealias Word = UInt64
    private(set) public var words: [Word]
    
    public init(bitCount count: Int) {
        assert(count > 0)
        self.count = count
        
        let size: Int = (count - 1) / 64 + 1
        words = Array<Word>(repeating: 0, count: size)
    }
    ///
    /// returns (word index, mask) by passing bit index
    /// example:
    ///     0000000\0/000000000000... (first 20 bits)
    ///     indexOf(8) (9th bit) --> (0, 1 << 8) = (0, 2^8)
    /// MARK:   here and in the next methods we store bits in reverse order
    public func indexOf(_ i: Int) -> (Int, Word) {
        assert(i >= 0 && i < count)
        
        let wordIndex = i / WSize
        let bitIndex = i - wordIndex * WSize
        let mask: Word = 1 << bitIndex
        return (wordIndex, mask)
    }
    /// sets bit of given index to 1
    public mutating func set(_ i: Int) {
        let (word, mask) = indexOf(i)
        words[word] |= mask
        
    }
    /// changes bit of given index to 0
    public mutating func clear(_ i: Int) {
        let (word, mask) = indexOf(i)
        words[word] &= ~mask
    }
    
    /// see if bit is set
    public func isSet(_ i: Int) -> Bool {
        let (word, mask) = indexOf(i)
        return (words[word] & mask) != 0
    }
    
    public subscript(i: Int) -> Bool {
        get { return isSet(i) }
        set { if newValue { set(i) } else { clear(i) } }
    }
    
    /// flip bit of given index
    /// returns true if change to 1 else false
    public mutating func flip(_ i: Int) -> Bool {
        let (word, mask) = indexOf(i)
        words[word] ^= mask
        return (words[word] & mask) != 0
    }
    public mutating func clearAll() {
        for word in 0..<words.count {
            words[word] = 0
        }
    }
    public mutating func setAll() {
        for word in 0..<words.count {
            words[word] = Word.max
        }
        /// clearUnused() is important in cases where we want to apply different bitwise operation
        /// to two bit arrays of different sizes. (this static methods follows)
        clearUnused()
    }
    
    private func lastUsedWordMask() -> Word {
        let leftovers = words.count * WSize - count
        if leftovers > 0 {
            let mask: Word = 1 << Word(63 - leftovers)
            return mask | (mask - 1)
        } else {
            return ~Word()
        }
    }
    private mutating func clearUnused() {
        words[words.count - 1] &= lastUsedWordMask()
    }
    /// returns largest bitset and minimum word size(another size one)
    static private func copyLargest(_ lhs: BitSet, _ rhs: BitSet) -> (BitSet, Int) {
        return (lhs.words.count > rhs.words.count) ? (lhs, rhs.words.count) : (rhs, lhs.words.count)
    }
    
    static public func |(lhs: BitSet, rhs: BitSet) -> BitSet {
        var (result, minWordCount) = BitSet.copyLargest(lhs, rhs)
        for wordIndex in 0..<minWordCount {
            result.words[wordIndex] = lhs.words[wordIndex] | rhs.words[wordIndex]
        }
        return result
    }
    static public func &(lhs: BitSet, rhs: BitSet) -> BitSet {
        let maxBitCount = max(lhs.count, rhs.count)
        let minWordCount = min(lhs.words.count, rhs.words.count)
        
        var result = BitSet(bitCount: maxBitCount)
        for wordIndex in 0..<minWordCount {
            result.words[wordIndex] = lhs.words[wordIndex] & rhs.words[wordIndex]
        }
        return result
    }
}
