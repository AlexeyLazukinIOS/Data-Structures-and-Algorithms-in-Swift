
// MARK: - LinkedList
struct LinkedList<Value>: CustomStringConvertible {
    
    // MARK: - Public (Properties)
    var head: Node<Value>?
    var tail: Node<Value>?
    
    var isEmpty: Bool {
        return head == nil
    }
    
    // MARK: - CustomStringConvertible
    var description: String {
        guard let head = head else {
            return "Empty list"
        }
        
        return String(describing: head)
    }
    
    // MARK: - Init
    init() {}
    
    // MARK: - Public (Interface)
    public mutating func push(_ value: Value) {
        head = Node(value: value, next: head)
        
        if tail == nil {
            tail = head
        }
    }
    
    public mutating func append(_ value: Value) {
        guard !isEmpty else {
            push(value)
            return
        }
        
        tail!.next = Node(value: value)
        tail = tail!.next
    }
    
    public func node(at index: Int) -> Node<Value>? {
        var currentNode = head
        var currentIndex = 0
        
        while currentNode != nil && currentIndex < index {
            currentNode = currentNode!.next
            currentIndex += 1
        }
        
        return currentNode
    }
    
    @discardableResult
    public mutating func insert(_ value: Value, after node: Node<Value>) -> Node<Value> {
        guard tail !== node else {
            append(value)
            return tail!
        }
        
        node.next = Node(value: value, next: node.next)
        return node.next!
    }
    
    @discardableResult
    public mutating func pop() -> Value? {
        defer {
            head = head?.next
            
            if isEmpty {
                tail = nil
            }
        }
        
        return head?.value
    }

    @discardableResult
    public mutating func removeLast() -> Value? {
        guard let head = head else {
            return nil
        }
        
        guard head.next != nil else {
            return pop()
        }
        
        var prev = head
        var current = head
        
        while let next = current.next {
            prev = current
            current = next
        }
        
        prev.next = nil
        tail = prev
        
        return current.value
    }

    @discardableResult
    public mutating func remove(after node: Node<Value>) -> Value? {
        defer {
            if node.next === tail {
                tail = node
            }

            node.next = node.next?.next
        }

        return node.next?.value
    }
}

// MARK: - Node
class Node<Value>: CustomStringConvertible {
    
    // MARK: - Properties (Public)
    var value: Value
    var next: Node?
    
    // MARK: - CustomStringConvertible
    var description: String {
        guard let next = next else {
            return "\(value)"
        }
        
        return "\(value) -> " + String(describing: next) + " "
    }
    
    // MARK: - Init
    init(value: Value, next: Node? = nil) {
        self.value = value
        self.next = next
    }
}

// MARK: - Examples
func creatingExample() {
    print("---Example of creating and linking nodes---")
    let node1 = Node(value: 1)
    let node2 = Node(value: 2)
    let node3 = Node(value: 3)
    
    node1.next = node2
    node2.next = node3
    
    print(node1)
}

func pushExample() {
    print("---Example of push---")
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print(list)
}

func appendExample() {
    print("---Example of append---")
    var list = LinkedList<Int>()
    list.append(1)
    list.append(2)
    list.append(3)
    
    print(list)
}

func insertAtExample() {
    print("---Example of inserting at a particular index---")
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before inserting: \(list)")
    
    var middleNode = list.node(at: 1)!
    
    for _ in 1...4 {
        middleNode = list.insert(-1, after: middleNode)
    }
    
    print("After inserting: \(list)")
}

func popExample() {
    print("---Example of pop---")
    
    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before popping list: \(list)")
    
    let poppedValue = list.pop()
    
    print("After popping list: \(list)")
    print("Popped value: " + String(describing: poppedValue))
}

func removeLastExample() {
    print("---Example of removing the last node---")

    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before removing last node: \(list)")
    
    let removedValue = list.removeLast()
    
    print("After removing last node: \(list)")
    print("Removed value: " + String(describing: removedValue))
}

func removeAtExample() {
    print("---Example of removing a node after a particular node---")

    var list = LinkedList<Int>()
    list.push(3)
    list.push(2)
    list.push(1)
    
    print("Before removing at particular index: \(list)")
    let index = 1
    let node = list.node(at: index - 1)!
    let removedValue = list.remove(after: node)
    
    print("After removing at index \(index): \(list)")
    print("Removed value: " + String(describing: removedValue))
}

creatingExample()
pushExample()
appendExample()
insertAtExample()
popExample()
removeLastExample()
removeAtExample()
