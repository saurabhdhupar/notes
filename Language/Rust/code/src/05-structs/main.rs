fn main() {

    // defining-structs
    {
        struct User {
            username: String,
            email: String,
            sign_in_count: u64,
            active: bool,
        }

        // 实例
        let user1 = User {
            email: String::from("someone@example.com"),
            username: String::from("someusername123"),
            active: true,
            sign_in_count: 1,
        };

        // 可变实例
        let mut user1 = User {
            email: String::from("someone@example.com"),
            username: String::from("someusername123"),
            active: true,
            sign_in_count: 1,
        };
        user1.username = String::from("chen");


        // 函数返回struct
        fn build_user(email: String, username: String) -> User {
            User {
                email: email,
                username: username,
                active: true,
                sign_in_count: 1,
            }
        }

        // 变量与字段同名时的字段初始化简写语法

        let user2 = User {
            email: String::from("another@example.com"),
            username: String::from("anotherusername567"),
            active: user1.active,
            sign_in_count: user1.sign_in_count,
        };

        // 可以简写为
        let user2 = User {
            email: String::from("another@example.com"),
            username: String::from("anotherusername567"),
            ..user1
        };

        // 使用没有命名字段的元组结构体来创建不同的类型
        // 元组结构体（tuple structs）
        struct Color(i32, i32, i32);
        struct Point(i32, i32, i32);
        let black = Color(0, 0, 0);
        let origin = Point(0, 0, 0);

        // 没有任何字段的类单元结构体
        // 类单元结构体（unit-like structs）,因为它们类似于 ()，即 unit 类型
        // 类单元结构体常常在你想要在某个类型上实现 trait 但不需要在类型内存储数据的时候发挥作用

        // 结构体数据的所有权
        // 在示例 5-1 中的 User 结构体的定义中，我们使用了自身拥有所有权的 String 类型而不是 &str 字符串 slice 类型。
        // 这是一个有意而为之的选择，因为我们想要这个结构体拥有它所有的数据，为此只要整个结构体是有效的话其数据也是有效的。
        // 可以使结构体储存被其他对象拥有的数据的引用，不过这么做的话需要用上 生命周期（lifetimes），这是一个第十章会讨论的 Rust 功能。
        // 生命周期确保结构体引用的数据有效性跟结构体本身保持一致。如果你尝试在结构体中储存一个引用而不指定生命周期将是无效的
    }

    // example-structs
    // 一个使用结构体的示例程序
    {
        #[derive(Debug)]
        struct Rectangle {
            width: u32,
            height: u32,
        }
        let rect1 = Rectangle { width: 30, height: 50 };

        // 增加注解来派生 Debug trait
        println!("rect1 is {:?}", rect1);
        println!("rect1 is {:#?}", rect1);
        println!("The area of the rectangle is {} square pixels.", area(&rect1));

        fn area(rectangle: &Rectangle) -> u32 {
            rectangle.width * rectangle.height
        }
    }

    // method-syntax
    // 方法语法
    {
        {
            #[derive(Debug)]
            struct Rectangle {
                width: u32,
                height: u32,
            }

            impl Rectangle {
                fn area(&self) -> u32 {
                    self.width * self.height
                }
            }

            let rect1 = Rectangle { width: 30, height: 50 };
            println!("The area of the rectangle is {} square pixels.", rect1.area());
        }

        // 关联函数
        {
            // impl 块的另一个有用的功能是：允许在 impl 块中定义 不 以 self 作为参数的函数。这被称为 关联函数（associated functions），因为它们与结构体相关联。
            // 即便如此它们仍是函数而不是方法，因为它们并不作用于一个结构体的实例。我们已经使用过 String::from 关联函数了。
            // 关联函数经常被用作返回一个结构体新实例的构造函数。
            #[derive(Debug)]
            struct Rectangle {
                width: u32,
                height: u32,
            }

            impl Rectangle {
                fn square(size: u32) -> Rectangle {
                    Rectangle { width: size, height: size }
                }
            }

            let sq = Rectangle::square(3);
            println!("sq is {:?}", sq);
        }

        // 每个结构体都允许拥有多个 impl 块
    }
}