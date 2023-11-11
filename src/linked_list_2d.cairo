use core::option::OptionTrait;
struct LinkedList2D<T> {
    key: felt252,
    value: felt252,
    head: Option<LinkedList2D<T>>,
    next: Option<LinkedList2D<T>>,
    sub: Option<LinkedList2D<T>>
}

trait LinkedListTrait<S, T> {
    fn initialize() -> LinkedList2D<T>;
    fn create(head: LinkedList2D<T>, key: felt252, value: felt252) -> LinkedList2D<T>;
    fn find(ref self: S, key: felt252) -> Option::<LinkedList2D<T>>;
    fn _find_sub(ref self: LinkedList2D<T>, key: felt252) -> Option::<LinkedList2D<T>>;
    fn push(ref self: S, key: felt252, value: felt252);
    fn push_sub(ref self: LinkedList2D<T>, parent_key: felt252, key: felt252, value: felt252);
    fn _get_tail(ref self: LinkedList2D<T>) -> LinkedList2D<T>;
    fn _get_subtail(ref self: LinkedList2D<T>) -> LinkedList2D<T>;
}

impl LinkedListImpl<
    T, impl TDrop: Drop<T>, impl TCopy: Copy<T>
> of LinkedListTrait<LinkedList2D<T>, T> {
    fn initialize() -> LinkedList2D<T> {
        let mut node = LinkedList2D {
            key: 0, value: 0, head: Option::None(()), next: Option::None(()), sub: Option::None(())
        };
        node.head = Option::Some(node);
        node
    }

    fn create(head: LinkedList2D<T>, key: felt252, value: felt252) -> LinkedList2D<T> {
        LinkedList2D {
            key: key,
            value: value,
            head: Option::Some(head),
            next: Option::None(()),
            sub: Option::None(())
        }
    }

    fn find(ref self: LinkedList2D<T>, key: felt252) -> Option::<LinkedList2D<T>> {
        let mut tmp = self.head.unwrap();
        let is_found = loop {
            if tmp.sub != Option::None(()) {
                let res = tmp._find_sub(key);
                if res == Option::None(()) {
                    continue;
                } else {
                    tmp = res.unwrap();
                    break true;
                }
            }
            if tmp.key == key {
                break true;
            }
            if tmp.next == Option::None(()) {
                break false;
            }
            tmp = tmp.next.unwrap();
        };
        let res = if is_found {
            Option::Some(tmp)
        } else {
            Option::None(())
        };
        res
    }

    fn _find_sub(ref self: LinkedList2D<T>, key: felt252) -> Option::<LinkedList2D<T>> {
        let mut tmp = self.sub.unwrap();
        let is_found = loop {
            if tmp.sub != Option::None(()) {
                let res: Option::<LinkedList2D<T>> = tmp._find_sub(key);
                if res == Option::None(()) {
                    continue;
                } else {
                    tmp = res.unwrap();
                    break true;
                }
            }

            if tmp.key == key {
                break true;
            }
            if tmp.next == Option::None(()) {
                break false;
            }
            tmp = tmp.next.unwrap();
        };
        let res = if is_found {
            Option::Some(tmp)
        } else {
            Option::None(())
        };
        res
    }

    fn _get_tail(ref self: LinkedList2D<T>) -> LinkedList2D<T> {
        let mut tmp = self.head.unwrap();
        loop {
            if tmp.next == Option::None(()) {
                break;
            }
            tmp = tmp.next.unwrap();
        };
        tmp
    }
    fn push(ref self: LinkedList2D<T>, key: felt252, value: felt252) {
        let head = self.head.unwrap();
        let mut tail = self._get_tail();
        tail.next = create(head, key, value);
    }

    fn _get_subtail(ref self: LinkedList2D<T>) -> LinkedList2D<T> {
        let mut tmp = self.sub.unwrap();
        loop {
            if tmp.next == Option::None(()) {
                break;
            }
            tmp = tmp.next.unwrap();
        };
        tmp
    }

    fn push_sub(ref self: LinkedList2D<T>, parent_key: felt252, key: felt252, value: felt252) {
        let mut parent_node = self.find(parent_key).unwrap();
        let mut tail = parent_node._get_subtail();
        if (parent_node == tail) {
            parent_node.sub = create(parent_node, key, value);
        } else {
            tail.next = create(parent_node, key, value);
        }
    }
}
