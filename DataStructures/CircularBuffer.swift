public struct CircularBuffer<T> {
    private(set) var array: [T?]
    private var readIndex: Int = 0
    private var writeIndex: Int = 0
    
    public init(count: Int) {
        array = [T?](repeating: nil, count: count)
    }
    public init(_ arr: [T?]) {
        array = arr
    }
    
    public var isEmpty: Bool {
        return (writeIndex - readIndex) == 0
    }
    public var isFull: Bool {
        return (array.count - writeIndex + readIndex) == 0
    }
    
    @discardableResult public mutating func write(_ element: T) -> Bool {
        guard !isFull else {return false}
        array[imaginary: writeIndex] = element
        writeIndex += 1
        return true
    }
    @discardableResult public mutating func read() -> T? {
        guard !isEmpty else { return nil }
        defer {
            array[imaginary: readIndex] = nil
            readIndex += 1
        }
        return array[imaginary: readIndex]
    }
}

extension CircularBuffer: Sequence {
    public func makeIterator() -> AnyIterator<T> {
        var index = readIndex
        return AnyIterator {
            guard index < writeIndex else { return nil }
            defer { index += 1 }
            return array[imaginary: index]
        }
    }
}

/// write(read) index will always increase, and for get
/// current index in array we use the statement: write(read) % count
/// -- this feature is more efficient than constant if-statement in the
/// -- write() (read()) method
public extension Array {
    subscript(imaginary index: Int) -> Element {
        get { return self[index % count] }
        set { self[index % count] = newValue }
    }
}
