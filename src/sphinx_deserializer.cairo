use core::zeroable::Zeroable;
use core::array::ArrayTrait;
use dict::Felt252DictTrait;
use debug::PrintTrait;
use sphinx_deserializer::multi_dim_linked_list::{MultiDimLinkedListTrait, MultiDimLinkedList};

fn serializer(records: Array<felt252>) -> MultiDimLinkedList<felt252> {
    let mut i: u32 = 0;
    let mut head: MultiDimLinkedList<felt252> = MultiDimLinkedListTrait::<
        MultiDimLinkedList<felt252>
    >::initialize();
    loop {
        if i >= records.len() - 1 {
            break;
        }
        if (*records.at(i + 1) != '_') {
            let key = *records.at(i);
            let value = *records.at(i + 1);
            head.push(key, value);
        }
        if (*records.at(i + 1) == '_') {
            i = recursive_push(i, @records, head);
        }
        i += 2;
    };

    head
}

fn recursive_push(_i: u32, records: @Array<felt252>, _head: MultiDimLinkedList<felt252>) -> u32 {
    let mut i = _i;
    let mut head = _head;
    let key = *records.at(i);
    head.push(key, 0);
    i += 2;
    loop { //push to sub linked list
        let key = *records.at(i);
        let value = *records.at(i + 1);
        if key == '_' {
            i += 1;
            recursive_push(i, records, head);
        }
        if key == '*' {
            break;
        }
    };
    i
}


fn main() { // let mut arr: Array<felt252> = ArrayTrait::new();
// arr.append('id');
// arr.append(1);
// arr.append('name');
// arr.append('John Doe');
// arr.append('x');
// arr.append('_');
// arr.append('y');
// arr.append(14);
// arr.append('z');
// arr.append(15);
// arr.append('*');
// arr.append('age');
// arr.append(12);
// let mut x = deserializer(arr);
// x.print();
}
