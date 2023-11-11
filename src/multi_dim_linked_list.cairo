use core::option::OptionTrait;

#[derive(Copy, Drop)]
struct MultiDimLinkedList<T> {
    key: felt252,
    value: felt252,
    head: Option<MultiDimLinkedList<T>>,
    next: Option<MultiDimLinkedList<T>>,
    sub: Option<MultiDimLinkedList<T>>
}

trait LinkedListTrait<S, T> {
    fn initialize() -> MultiDimLinkedList<T>;
    fn create(ref self: S, key: felt252, value: felt252) -> MultiDimLinkedList<T>;
    fn find(ref self: S, key: felt252) -> Option::<MultiDimLinkedList<T>>;
    fn _find_sub(ref self: S, key: felt252) -> Option::<MultiDimLinkedList<T>>;
    fn push(ref self: S, key: felt252, value: felt252);
    fn push_sub(ref self: S, parent_key: felt252, key: felt252, value: felt252);
    fn _get_tail(ref self: S) -> MultiDimLinkedList<T>;
    fn _get_subtail(ref self: S) -> MultiDimLinkedList<T>;
    fn _check_equal(self: S, comp: MultiDimLinkedList<T>) -> bool;
}

impl LinkedListImpl<
    T, impl TDrop: Drop<T>, impl TCopy: Copy<T>
> of LinkedListTrait<MultiDimLinkedList<T>, T> {
    fn initialize() -> MultiDimLinkedList<T> {
        let mut node = MultiDimLinkedList {
            key: 0, value: 0, head: Option::None(()), next: Option::None(()), sub: Option::None(())
        };
        node.head = Option::Some(node);
        node
    }

    fn create(
        ref self: MultiDimLinkedList<T>, key: felt252, value: felt252
    ) -> MultiDimLinkedList<T> {
        MultiDimLinkedList {
            key: key,
            value: value,
            head: Option::Some(self),
            next: Option::None(()),
            sub: Option::None(())
        }
    }

    fn find(ref self: MultiDimLinkedList<T>, key: felt252) -> Option::<MultiDimLinkedList<T>> {
        let mut tmp = self.head.unwrap();
        let is_found = loop {
            if tmp.sub.is_some() {
                let res = tmp._find_sub(key);
                if res.is_none() {
                    continue;
                } else {
                    tmp = res.unwrap();
                    break true;
                }
            }
            if tmp.key == key {
                break true;
            }
            if tmp.next.is_none() {
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

    fn _find_sub(ref self: MultiDimLinkedList<T>, key: felt252) -> Option::<MultiDimLinkedList<T>> {
        let mut tmp = self.sub.unwrap();
        let is_found = loop {
            if tmp.sub.is_some() {
                let res: Option::<MultiDimLinkedList<T>> = tmp._find_sub(key);
                tmp.create(1, 2);
                if res.is_none() {
                    continue;
                } else {
                    tmp = res.unwrap();
                    break true;
                }
            }

            if tmp.key == key {
                break true;
            }
            if tmp.next.is_none() {
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

    fn _get_tail(ref self: MultiDimLinkedList<T>) -> MultiDimLinkedList<T> {
        let mut tmp = self.head.unwrap();
        loop {
            if tmp.next.is_none() {
                break;
            }
            tmp = tmp.next.unwrap();
        };
        tmp
    }

    fn push(ref self: MultiDimLinkedList<T>, key: felt252, value: felt252) {
        let mut head = self.head.unwrap();
        let mut tail: MultiDimLinkedList::<T> = self._get_tail();
        head.create(key, value);
    }

    fn _get_subtail(ref self: MultiDimLinkedList<T>) -> MultiDimLinkedList<T> {
        let mut tmp = self.sub.unwrap();
        loop {
            if tmp.next.is_none() {
                break;
            }
            tmp = tmp.next.unwrap();
        };
        tmp
    }

    fn _check_equal(self: MultiDimLinkedList<T>, comp: MultiDimLinkedList<T>) -> bool {
        if self.key == comp.key && self.value == comp.value {
            true
        } else {
            false
        }
    }

    fn push_sub(
        ref self: MultiDimLinkedList<T>, parent_key: felt252, key: felt252, value: felt252
    ) {
        let mut parent_node = self.find(parent_key).unwrap();
        let mut tail = parent_node._get_subtail();

        if parent_node._check_equal(tail) {
            parent_node.create(key, value);
        } else {
            parent_node.create(key, value);
        }
    }
}
