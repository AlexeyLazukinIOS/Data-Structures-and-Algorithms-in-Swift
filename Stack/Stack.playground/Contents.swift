
// MARK: - Stack
public struct Stack<Element> {
    
    // MARK: - Private (Properties)
    private var storage: [Element] = []
    
    // MARK: - Init
    public init() { }

    public init(_ elements: [Element]) {
      storage = elements
    }

    // MARK: - Public (Properties)
    public mutating func push(_ element: Element) {
      storage.append(element)
    }

    @discardableResult
    public mutating func pop() -> Element? {
        storage.popLast()
    }

    public func peek() -> Element? {
        storage.last
    }

    public var isEmpty: Bool {
        peek() == nil
    }
}

// MARK: - ExpressibleByArrayLiteral
extension Stack: ExpressibleByArrayLiteral {
    public init(arrayLiteral elements: Element...) {
        storage = elements
    }
}

// MARK: - CustomStringConvertible
extension Stack: CustomStringConvertible {
    public var description: String {
        let topDivider = "----top----\n"
        let bottomDivider = "\n-----------"
        let stackElements = storage
            .map { "\($0)" }
            .reversed()
            .joined(separator: "\n")

        return topDivider + stackElements + bottomDivider
    }
}

// MARK: - Examples
func usingStack() {
    print("---using a stack---")
    var stack = Stack<Int>()
    
    stack.push(1)
    stack.push(2)
    stack.push(3)
    stack.push(4)
    
    print(stack)
    
    if let poppedElement = stack.pop() {
        assert(4 == poppedElement)
        print("Popped: \(poppedElement)")
    }
}

func initStackFromArray() {
    print("---initializing a stack from an array---")
    let array = ["A", "B", "C", "D"]
    var stack = Stack(array)

    print(stack)

    stack.pop()
}

func initStackFromArrayLiteral() {
    var stack: Stack = [1.0, 2.0, 3.0, 4.0]
    
    print(stack)
    
    stack.pop()
}

usingStack()
initStackFromArray()
initStackFromArrayLiteral()
