
protocol Queue {
    associatedtype Element: Equatable
    
    private var list: [Element] { get set }
    
    mutating func enqueue(_ element: Element)
    
    mutating func dequeue() -> Element?
    
    subscript(i: Int) -> Element { get }
}

struct SomeCollection<T: Equatable>: Queue {
    
    var list = [T]()

    var isEmpty: Bool {
        return list.isEmpty
    }
    
    subscript(i: Int) -> T {
        return list[i]
    }
    
    
    public mutating func enqueue(_ element: T) {
        list.append(element)
    }

    public mutating func dequeue() -> T? {
        guard !list.isEmpty, list.first != nil else { return nil }
        
        return list.removeFirst()
    }

    public func peek() -> T? {
        return list.first
    }
}

var someOrder: SomeCollection<Int> = SomeCollection()

someOrder.enqueue(5)
someOrder.enqueue(1)
someOrder.enqueue(2)
someOrder.dequeue()

print(someOrder)


