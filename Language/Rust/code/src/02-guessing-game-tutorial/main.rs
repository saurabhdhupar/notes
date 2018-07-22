extern crate rand;

use std::io;
use rand::Rng;
use std::cmp::Ordering;

fn main() {
    println!("请输入:");

    let number = rand::thread_rng().gen_range(1, 101);

    loop {
        let mut guess = String::new();
        io::stdin().read_line(&mut guess).expect("fail");
        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        match guess.cmp(&number) {
            Ordering::Less => println!("too small"),
            Ordering::Greater => println!("too big"),
            Ordering::Equal => {
                println!("equal");
                break;
            }
        };
    }
}
