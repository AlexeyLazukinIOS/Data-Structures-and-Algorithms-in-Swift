
// MARK: - Node
class Node<T: Equatable> {

    // MARK: - Public (Properties)
    var value: T
    var next: Node<T>? = nil
    var prev: Node<T>? = nil

    // MARK: - Init
    init(value: T) {
        self.value = value
    }
}

// MARK: - Equatable
extension Node: Equatable {
    static func == (lhs: Node<T>, rhs: Node<T>) -> Bool {
        return lhs.value == rhs.value
    }
}

// MARK: - DoublyLinkedList
class DoublyLinkedList<T: Equatable> {

    // MARK: - Public (Properties)
    var head: Node<T>? = nil
    var tail: Node<T>? = nil
    var size: Int = 0

    // MARK: - Public (Interface)
    func append(value: T) {
        let newNode = Node(value: value)

        guard head != nil else {
            head = newNode
            tail = newNode
            size += 1
            
            return
        }

        tail?.next = newNode
        newNode.prev = tail
        tail = newNode

        size += 1
    }

    func prepend(value: T) {
        let newNode = Node(value: value)

        guard head != nil else {
            head = newNode
            tail = newNode
            size += 1

            return
        }

        head?.prev = newNode
        newNode.next = head
        head = newNode

        size += 1
    }

    func items() -> [T?] {
        guard head != nil else {
            return []
        }

        var allItems = [T]()
        var curr = head

        while curr != nil {
            allItems.append(curr!.value)
            curr = curr?.next
        }

        return allItems
    }

    func insertAtIndex(_ value: T, atIndex: Int) {
        guard atIndex >= 0 && atIndex <= size else {
            print("Error, index out of bounds")
            return
        }

        switch atIndex {
        case .zero:
            prepend(value: value)
        case size:
            append(value: value)
        default:
            let newNode = Node(value: value)
            
            var curr = head
            for _ in 0..<atIndex {
                curr = curr?.next
            }
            
            curr?.prev?.next = newNode
            newNode.prev = curr?.prev
            curr?.prev = newNode
            newNode.next = curr
            
            size += 1
        }
    }

    func getAtIndex(_ index: Int) -> T? {
        guard index >= 0 && index <= size else {
            print("Error, index out of bounds")
            return nil
        }

        var curr = head
        for _ in 0..<index {
            curr = curr?.next
        }

        return curr?.value
    }
}

let list = DoublyLinkedList<Int>()
list.prepend(value: 112)
list.prepend(value: 113)
list.prepend(value: 2)
list.items()
