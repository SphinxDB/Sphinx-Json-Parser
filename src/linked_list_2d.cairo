struct LinkedList2D<T> {
    key: felt252,
    value: felt252,
    head: Option<LinkedList2D<T>>,
    next: Option<LinkedList2D<T>>,
    sub: Option<LinkedList2D<T>>
}

trait LinkedListTrait<S, T> {
    fn initialize() -> LinkedList2D<T>;
    fn create(head: LinkedList2D<T>, key: T, value: T) -> LinkedList2D<T>;
    fn find(ref self: S, parent_head: LinkedList2D<T>, key: Array<T>) -> LinkedList2D<T>;
    fn push(ref self: S, key: T, value: T);
    fn push_sub(ref self: S, key: T, value: T);
}

impl LinkedListImpl<
    T, impl TDrop: Drop<T>, impl TCopy: Copy<T>
> of LinkedListTrait<LinkedList2D<T>, T> {
    fn initialize() -> LinkedList2D<T> {
        let mut self = LinkedList2D {
            key: 0, value: 0, head: Option::None(()), next: Option::None(()), sub: Option::None(())
        };
        self.head = Option::Some(self);
        self
    }

    fn create(head: LinkedList2D<T>, key: T, value: T) -> LinkedList2D<T> {
        LinkedList2D {
            key: key, value: value, head: head, next: Option::None(()), sub: Option::None(())
        }
    }

    fn find(ref self: LinkedList2D<T>, key: Array<T>) -> LinkedList2D<T> {
        let mut tmp = self.head;
        let is_found = loop {
            if tmp.sub != Option::None(()) {
                let res = tmp._find_sub(key);
                if (res == Some::None()) {
                    continue;
                } else {
                    res
                }
            }
            if tmp.key == key {
                break true;
            }
            if tmp.next == Option::None(()) {
                break false;
            }
            tmp = tmp.next;
        };
        if is_found {
            tmp
        } else {
            Option::None(())
        }
    }

    fn _find_sub(ref self: LinkedList2D<T>, key: Array<T>) -> LinkedList2D<T> {
        let mut tmp = self.sub;
        let is_found = loop {
            if tmp.sub != Option::None(()) {
                let res = tmp._find_sub(key);
                if (res == Some::None()) {
                    continue;
                } else {
                    res
                }
            }
            if tmp.key == key {
                break true;
            }
            if tmp.next == Option::None(()) {
                break false;
            }
            tmp = tmp.next;
        };
        if is_found {
            tmp
        } else {
            Option::None(())
        }
    }

    fn _get_tail(ref self: LinkedList2D<T>) -> LinkedList2D<T> {
        let mut tmp = self.head;
        loop {
            if tmp.next == Option::None(()) {
                break;
            }
            tmp = tmp.next;
        }
        tmp
    }
    fn push(ref self: LinkedList2D<T>, head: LinkedList2D<T>, key: T, value: T) {
        let mut tail = self._get_tail();
        tail.next = create(head, key, value);
    }

    fn _get_subtail(ref self: LinkedList2D<T>) -> LinkedList2D<T> {
        let mut tmp = self.sub;
        loop {
            if tmp.next == Option::None(()) {
                break;
            }
            tmp = tmp.next;
        }
        tmp
    }

    fn push_sub(ref self: LinkedList2D<T>, parent_key: T, key: T, value: T) {
        let parent_node = self.find(parent_key);
        let tail = parent_node._get_subtail();
        if (parent_node == tail) {
            parent_node.sub = create(parent_node, key, value);
        } else {
            tail.next = create(parent_node, key, value);
        }
    }
}
