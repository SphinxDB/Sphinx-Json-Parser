use core::zeroable::Zeroable;
use core::array::ArrayTrait;
use dict::Felt252DictTrait;
use debug::PrintTrait;


fn deserializer(records: Array<felt252>) -> Felt252Dict<felt252> {
    let mut i: u32 = 0;

    loop {
        if i >= records.len() - 1 {
            break;
        }
        if (*records.at(i + 1) != '_') {//push to linked list
        }
        if (*records.at(i + 1) == '_') {
            loop {//push to sub linked list
            };
        }
        if (*records.at(i) == '*') {
            i += 1;
            continue;
        }
        i += 2;
    };
}


// fn obj_to_dict(records: Array<felt252>, i: u32) -> Felt252Dict<felt252> {
//     let mut inner_dict: Felt252Dict<felt252> = Default::default();
//     loop{

//     }
//     inner_dict
// }

// fn string_to_dict(str: felt252) -> Felt252Dict<felt252> {
//     let mut dict: Felt252Dict<felt252> = Default::default();
//     for
//     dict
// }

// fn field_to_number() -> felt252 {}

// fn field_to_bool() -> felt252 {}

fn get_char(str: felt252) -> felt252 {
    str
}

fn main() {
    let mut arr: Array<felt252> = ArrayTrait::new();
    arr.append('id');
    arr.append(1);
    arr.append('name');
    arr.append('John Doe');
    arr.append('x');
    arr.append('_');
    arr.append('y');
    arr.append(14);
    arr.append('z');
    arr.append(15);
    arr.append('*');
    arr.append('age');
    arr.append(12);
// let mut x = deserializer(arr);
// x.print();
}
