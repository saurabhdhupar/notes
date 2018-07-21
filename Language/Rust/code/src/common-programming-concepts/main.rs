fn main() {
    // variables-and-mutability 变量和可变性
    {
        println!("\nmutable variable and immutable variable");
        {
            let x = 5;
            // x = 6; error: immutable variable
            println!("x is : {}", x);

            let mut y = 6;
            println!("y is : {}", y);
            y = 7;
            println!("y is : {}", y);
        }

        println!("\nconst");
        {
            const MAX_POINT: u32 = 1000000;
            println!("max point is {}", MAX_POINT);
            println!("区别：\n\
        \t * 不允许对常量使用mut\n\
        \t * 使用const关键字\n\
        \t * 必须标准类型（常量后的:表示是指定类型的数据）\n\
        \t * 只能用作常量表达式，不能作为函数返回值")
        }

        println!("\nshadowing");
        {
            let x1 = 1;
            println!("new x is {}", x1);
            let x1 = 2;
            println!("new x is {}", x1);
            let x1 = 3;
            println!("new x is {}", x1);
            println!("\t 只有显示使用let关键词才可以对x重新赋值，实际上是创建了一个新的变量（所以甚至可以改变x的类型）");
            let x1 = "string";
            println!("new x is {}", x1);
        }
    }

    // data-types 数据类型
    {
        println!("\nscalar 标量");
        {
            println!("标量是一个单独的值");
            println!("Rust 有四种基本的标量类型：整型、浮点型、布尔类型和字符类型");
            let x = 123;
            println!("rust 有8种整形，默认i32: {}", x);
            let x = 1.1;
            println!("rust 有2种浮点形，默认f64: {}", x);
            let x = false;
            println!("rust 有2种布尔的值:分别是 {} {}", x, true);
            let heart_eyed_cat = '😻';
            println!("字符类型的： {}", heart_eyed_cat);
            println!("Rust 的 char 类型代表了一个 Unicode 标量值（Unicode Scalar Value，Unicode 标量值包含从 U+0000 到 U+D7FF 和 U+E000 到 U+10FFFF 在内的值");
        }

        println!("\nCompound 复合");
        {
            println!("复合类型（Compound types）可以将多个其他类型的值组合成一个类型。Rust 有两个原生的复合类型：元组（tuple）和数组（array）");
            println!("我们使用一个括号中的逗号分隔的值列表来创建一个元组");
            let tup: (i32, f64, u8) = (500, 6.4, 1);
            println!("\tlet tup: (i32, f64, u8) = (500, 6.4, 1);");
            println!("可以使用模式匹配（pattern matching）来解构（destructure）元组");
            let (x, y, z) = tup;
            println!("\tlet (x, y, z) = tup;");
            println!("\tx is {}, y is{}, z is {}", x, y, z);
            println!("除了使用模式匹配解构之外，也可以使用点号（.）后跟值的索引来直接访问它们");
            println!("\ttup.0, tup.1, tup.2");
            println!("\tx is {}, y is{}, z is {}", tup.0, tup.1, tup.2);

            println!("数组中的每个元素的类型必须相同。数组是固定长度的：一旦声明，它们的长度不能增长或缩小。");
            println!("当你想要在栈（stack）而不是在堆（heap）上为数据分配空间，或者是想要确保总是有固定数量的元素时，数组非常有用");
            let a = [1, 2, 3, 4, 5];
            println!("\tlet a = [1, 2, 3, 4, 5];");
            println!("数组是一整块分配在栈上的内存。可以使用索引来访问数组的元素");
            println!("\t0 is {}, 4 is {}", a[0], a[4]);
        }
    }

    // how-functions-work 函数如何工作
    {
        println!("Rust 代码使用 snake case 作为函数和变量名称的规范风格");

        println!("\n参数（parameters）");
        {
            fn another_function(x: i32) {
                println!("The value of x is: {}", x);
            }

            fn another_function2(x: i32, y: &str) {
                println!("The value of x is: {}, y is {}", x, y);
            }

            another_function(10);
            another_function2(1, "string");
        }

        println!("\n语句（Statements）是执行一些操作但不返回值的指令。表达式（Expressions）计算并产生一个值");
        {
            println!("Rust 是一个基于表达式（expression-based）的语言，这是一个需要理解的（不同于其他语言）重要区别");
            println!("ley x = 1; 是语句");
            println!("1 + 2 是表达式");
            println!("函数调用是一个表达式。宏调用是一个表达式。我们用来创建新作用域的大括号（代码块），{}，也是一个表达式", "{}");

            // 下面这个有值
            let x = {
                let y = 1;
                y + 1
            };
            println!("x is: {}", x);
            // 下面这个没有值
            let x = {
                let y = 1;
                y + 1;
            };
        }

        println!("\n函数的返回值");
        {
            fn five() -> i32 {
                5
            }
            println!("five() is: {}", five());
        }
    }


    // comments 注释
    {
        // Rust 还有另一种注释，称为文档注释，我们将在 14 章讨论它
    }

    // control-flow 控制流
    {
        // if
        {
            let x = 4;
            if x > 5 {
                println!("x 大于 5");
            } else if x == 5 {
                println!("x 等于 5");
            } else {
                println!("x 小于等于 5");
            }
        }

        // 在 let 语句中使用 if
        // 如果 if 分支和 else 分支的结果的类型不匹配，则会出现一个错误
        {
            let number = if true {
                5
            } else {
                6
            };
            println!("number is {}", number);
        }

        // Rust 有三种循环类型：loop、while 和 for

        // loop
        {
            let mut index = 0;
            loop {
                println!("loop is running!");
                index += 1;
                if index > 10 {
                    break;
                }
            }
        }

        // while
        {
            let mut index = 0;
            while index <= 10 {
                println!("while is running!");
                index += 1;
            }
        }

        // for
        {
            let a = [1, 20, 300, 4, 3245234];
            for x in a.iter() {
                println!("ele of a is {}", x);
            }
        }
        // for x in (a..b)
        {
            for x in (0..4).rev() {
                println!("x is {}", x);
            }
        }
    }
}