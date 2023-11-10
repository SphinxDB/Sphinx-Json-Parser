use core::zeroable::Zeroable;
use core::array::ArrayTrait;
use debug::PrintTrait;


// fn deserializer(records: Array<felt252>) -> Felt252Dict<felt252> {
//     let mut i: u32 = 0;
//     loop {
//         if i == records.len() {
//             break;
//         }
//         i.print();
//         i = i + 1;
//     }
//     let mut x = *records.at(0);
// }

// fn dict_to_dict() -> Felt252Dict<Felt252Dict<felt252>> {
//     let mut dict: Felt252Dict<Felt252Dict<felt252>> = Default::default();

//     dict
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
    arr.append('"user":{"name":"Izzet"}');
    arr.append('"user":{"name":"Mete"}');
    arr.append('"user":{"name":"Yusuf"}');
    arr.append('"user":{"name":"Yaman"}');
// let mut x = deserializer(arr);
// x.print();
}
