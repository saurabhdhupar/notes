fn main() {
    // 枚举和模式匹配
    // 枚举是一个很多语言都有的功能，不过不同语言中其功能各不相同。
    // Rust 的枚举与 F#、OCaml 和 Haskell 这样的函数式编程语言中的 代数数据类型（algebraic data types）最为相似

    // 定义枚举 defining-an-enum
    {
        // 定义枚举类型
        enum IpAddrKind {
            V4,
            V6,
        }

        // 枚举值，都是IpAddrKind类型的
        let four = IpAddrKind::V4;
        let six = IpAddrKind::V6;
    }
}