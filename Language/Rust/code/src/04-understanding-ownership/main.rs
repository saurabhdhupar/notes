fn main() {
    // ownership
    // 所有权（系统）是 Rust 最独特的功能，其令 Rust 无需垃圾回收（garbage collector）即可保障内存安全

    // what-is-ownership
    {
        // 栈（Stack）与堆（Heap）
        // 栈和堆都是代码在运行时可供使用的内存部分，不过他们以不同的结构组成。

        // 栈以放入值的顺序存储并以相反顺序取出值。这也被称作 后进先出（last in, first out）。
        // 栈因为它访问数据方式的不同而导致操作 *数据快速* ：
        //    因为数据存取的位置总是在栈顶而不需要寻找一个位置存放或读取数据。
        //    因为栈中的所有数据都必须有一个已知且固定的大小。

        // 相反对于在编译时未知大小或大小可能变化的数据，可以把他们储存在堆上。
        // 堆是缺乏组织的：当向堆放入数据时，我们请求一定大小的空间。
        // 操作系统在堆的某处找到一块足够大的空位，把它标记为已使用，并返回给我们一个其位置的 指针（pointer）。
        // 这个过程称作 在堆上分配内存（allocating on the heap），并且有时这个过程就简称为 “分配”（allocating）。
        // 向栈中放入数据并不被认为是分配。因为指针是已知的固定大小的，我们可以将指针储存在栈上，不过当需要实际数据时，必须访问指针。

        // 当调用一个函数，传递给函数的值（包括可能指向堆上数据的指针）和函数的局部变量被压入栈中。当函数结束时，这些值被移出栈。
        //
        // 记录何处的代码在使用堆上的什么数据，最小化堆上的冗余数据的数量以及清理堆上不再使用的数据以致不至于耗尽空间，这些所有的问题正是所有权系统要处理的。
        // 一旦理解了所有权，你就不需要经常考虑栈和堆了，不过理解如何管理堆内存可以帮助我们理解所有权为何存在以及为什么要以这种方式工作。

        // 所有权规则
        // 1. Rust 中每一个值都有一个称之为其 所有者（owner）的变量。
        // 2. 值有且只能有一个所有者。
        // 3. 当所有者（变量）离开作用域，这个值将被丢弃。

        // 变量作用域
        {                            // s is not valid here, it’s not yet declared
            let s = "hello";   // s is valid from this point forward
        }                            // this scope is now over, and s is no longer valid

        // “Data Types” 部分涉及到的数据类型都是储存在栈上的并且当离开作用域时被移出栈，不过我们需要寻找一个储存在堆上的数据来探索 Rust 是如何知道该在何时清理数据的。

        let mut s = String::from("hello");
        s.push_str(", world");
        println!("x is {}", s);

        // 为什么 String 可变而字面值却不行呢？区别在于两个类型对内存的处理上

        //内存与分配
        // Rust 采取了一个不同的策略：内存在拥有它的变量离开作用域后就被自动释放
        // 当变量离开作用域，Rust 为其调用一个特殊的函数。这个函数叫做 drop，在这里 String 的作者可以放置释放内存的代码。Rust 在结尾的 } 处自动调用 drop。

        // 变量与数据交互的方式（一）：移动
        let s1 = String::from("hello");
        let s2 = s1;
        // println!("s1 is {}",s1) // error
        println!("s2 is {}", s2);
        // String由三部分组成：一个指向存放字符串内容内存的指针，一个长度，和一个容量。这一组数据储存在栈上
        // 字符串内容本身存储在堆上
        // 当 let s2 = s1 的时候，s1中指向字符串的指针就被移动到s2中存储，同时s1失效

        // 变量与数据交互的方式（二）：克隆
        let s1 = String::from("hello");
        let s2 = s1.clone();
        println!("s1 is {}, s2 is {}", s1, s2);

        // 只在栈上的数据：拷贝（称之为copy的）
        let x = 5;
        let y = x;
        println!("x = {}, y = {}", x, y);
        // 因为这里是数字，大小是固定的，所以数据是存储在栈上，而不是堆上
        // 这里没有深拷贝和浅拷贝的区别，无论如何都是在栈上复制数据的

        // 可以实现一个copy trait，以完成类似于这样整形的复制
        // 但是rust 不允许一个实现了drop trait的再去实现 copy trait

        // 一些称之为copy的数据类型
        // * 所有整数类型，比如 u32。
        // * 布尔类型，bool，它的值是 true 和 false。
        // * 所有浮点数类型，比如 f64。
        // * 元组，当且仅当其包含的类型也都是 Copy 的时候。(i32, i32) 是 Copy 的，不过 (i32, String) 就不是。

        // 所有权与函数
        let s = String::from("hello");  // s comes into scope.
        takes_ownership(s);             // s's value moves into the function， and so is no longer valid here.
        let x = 5;                      // x comes into scope.
        makes_copy(x);                  // x would move into the function,but i32 is Copy, so it’s okay to still
        // println!("s is invalid {}",s);
        println!("x is valid {}", x);

        // 返回值与作用域
    }

    // references-and-borrowing
    // 引用和借用
    {
        let s = String::from("hello");
        change(&s);
        fn change(some_string: &String) {
            println!("s is {}", some_string);
            // some_string.push_str(", world");// 无法修改数据
        }


        // 可变引用
        {
            let mut s = String::from("hello");
            change2(&mut s);
            fn change2(some_string: &mut String) {
                some_string.push_str(", world");
            }
            println!("new s is {}", s);

            // 数据竞争（data race）是一种特定类型的竞争状态，它可由这三个行为造成：
            // * 两个或更多指针同时访问同一数据。
            // * 至少有一个这样的指针被用来写入数据。
            // * 不存在同步数据访问的机制。

            // 下面的代码有问题，原因是，同时有两个变量拥有对s的[修改]权限
            // let mut s = String::from("hello");
            // let r1 = &mut s;
            // let r2 = &mut s;

            // 可以让其中一个位于{}内，这样两个就不会同时起作用
            let mut s = String::from("hello");
            {
                let r1 = &mut s;
            }
            let r2 = &mut s;

            // 可以让两个变量同时拥有对s的[访问]权限，因为任何一个都不会修改数据
            let mut s = String::from("hello");
            let r1 = &s;
            let r2 = &s;

            // 但是，不能同时一个可以读，另一个可以写，因为写的那个变量可能改变数据，导致读的那个变量也发生不可预知的变化
            // let mut s = String::from("hello");
            // let r1 = &s;
            // let r2 = &mut s;
        }

        // 悬垂引用（Dangling References）
        // 悬垂指针是其指向的内存可能已经被分配给其它持有者
        {

            // 下面这个函数会在函数内部创建一个变量，然后返回指向这个字符串的引用。但是在函数结束的时候，这个字符串就已经销毁了，所以这个引用是无效的
            // fn dangle() -> &String {
            //     let s = String::from("hello");
            //     &s
            // }

            // 应该直接返回字符串
            fn dangle() -> String {
                let s = String::from("hello");
                s
            }
            println!("dangle is {}",dangle());
        }

        // 引用的规则
        // * 在任意给定时间，只能 拥有如下中的一个：
        // * 一个可变引用。
        // * 任意数量的不可变引用。
        // * 引用必须总是有效的。
    }

    // slices
    // 另一个没有所有权的数据类型是 slice。slice 允许你引用集合中一段连续的元素序列，而不用引用整个集合。
    {

    }
}


fn takes_ownership(some_string: String) { // some_string comes into scope.
    println!("{}", some_string);
} // Here, some_string goes out of scope and `drop` is called. The backing
// memory is freed.

fn makes_copy(some_integer: i32) { // some_integer comes into scope.
    println!("{}", some_integer);
} // Here, some_integer goes out of scope. Nothing special happens.