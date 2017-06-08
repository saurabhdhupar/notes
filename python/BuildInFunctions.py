# abs(x)
# If the argument is a complex number, its magnitude is returned.
"""
In [2]: abs(10)
Out[2]: 10

In [4]: abs(-10.4)
Out[4]: 10.4
"""

# all(iterable)
"""
In [7]: all([1, 2, 3])
Out[7]: True

In [8]: all([1, 2, True, {'a': 'a'}])
Out[8]: True

In [9]: all([1, 2, True, {'a': 'a'}, None])
Out[9]: False
"""

# any(iterable)
"""
In [13]: any([True, False])
Out[13]: True

In [14]: any({None: 'c'})
Out[14]: False
"""

# ascii(object)
"""
In [18]: ascii('编程')
Out[18]: "'\\u7f16\\u7a0b'"

In [19]: ascii('code')
Out[19]: "'code'"
"""

# bin(x)
# 将一个int变成一个二进制字符串，结果是一个合法的python表达式。
# 如果参数不是一个int，那么他应该定义一个__index__()方法来返回一个int
"""
In [21]: bin(10)
Out[21]: '0b1010'

In [22]: 0b1010
Out[22]: 10

In [28]: bin(CanBin())
Out[28]: '0b1010'
"""

"""
In [30]: class CanNotBin(object):
    ...:     pass
    ...:

In [31]: bin(CanNotBin())
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-31-bbc800b33295> in <module>()
----> 1 bin(CanNotBin())

TypeError: 'CanNotBin' object cannot be interpreted as an integer
"""

"""
In [32]: class CanBin(object):
    ...:     def __index__(self):
    ...:         return 10
    ...:

In [33]: bin(CanBin())
Out[33]: '0b1010'
"""

# class bool([x])
# bool是int的子类
# bool唯一的实例就是True或者False，不能进一步被继承
"""
In [34]: bool(1)
Out[34]: True

In [36]: bool(0)
Out[36]: False

In [37]: bool()
Out[37]: False
"""

"""
In [39]: class BoolFurther(bool):
    ...:     pass
    ...:
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-39-685387e5d4ab> in <module>()
----> 1 class BoolFurther(bool):
      2     pass

TypeError: type 'bool' is not an acceptable base type
"""

# class bytearray([source[, encoding[, errors]]])

# Without an argument, an array of size 0 is created.
"""
In [77]: bytearray()
Out[77]: bytearray(b'')
"""

# If it is a string, you must also give the encoding (and optionally, errors) parameters; bytearray() then converts the string to bytes using str.encode().
"""
In [75]: bytearray('code', encoding='utf-8')
Out[75]: bytearray(b'code')

In [76]: bytearray('代码', encoding='utf-8')
Out[76]: bytearray(b'\xe4\xbb\xa3\xe7\xa0\x81')
"""

# If it is an integer, the array will have that size and will be initialized with null bytes.
"""
In [63]: bytearray(0)
Out[63]: bytearray(b'')

In [64]: bytearray(2)
Out[64]: bytearray(b'\x00\x00')

In [65]: bytearray(12)
Out[65]: bytearray(b'\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00')
"""

# If it is an object conforming to the buffer interface, a read-only buffer of the object will be used to initialize the bytes array.
"""
In [66]: bytearray({0, 2, 12, 100, 255})
Out[66]: bytearray(b'\x00\x02d\x0c\xff')

In [68]: bytearray({256})
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
<ipython-input-68-864ea48aadd3> in <module>()
----> 1 bytearray({256})

ValueError: byte must be in range(0, 256)
"""

# If it is an iterable, it must be an iterable of integers in the range 0 <= x < 256, which are used as the initial contents of the array.
"""
In [70]: bytearray([0, 2, 12, 100, 255])
Out[70]: bytearray(b'\x00\x02\x0cd\xff')

In [71]: bytearray([256])
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
<ipython-input-71-803c67e950f7> in <module>()
----> 1 bytearray([256])

ValueError: byte must be in range(0, 256)
"""

# class bytes([source[, encoding[, errors]]])
# 和上面的一样，区别: bytes is an immutable version of bytearray – it has the same non-mutating methods and the same indexing and slicing behavior.


# callable(object)
# 在python3.0中移除，又在3.2加回来了
# 如果可调用，返回True，否则是False
# 即使是True，也不能保证每次都成功，但如果是False，那么必然失败
# class是可调用的，调用class返回一个实例；如果这个class有__call__，那么这个实力也是可调用的
"""
In [29]: class IsCallable(object):
    ...:     pass
    ...:

In [30]: callable(IsCallable)
Out[30]: True

In [31]: callable(IsCallable())
Out[31]: False

In [32]: class AndInstanceIsCallable(object):
    ...:     def __call__(self):
    ...:         pass
    ...:

In [33]: callable(AndInstanceIsCallable)
Out[33]: True

In [34]: callable(AndInstanceIsCallable())
Out[34]: True
"""

# chr(i)
# Return the string representing a character whose Unicode code point is the integer i.
# i的参数范围是0 - 1,114,111 (0x10FFFF in base 16).
"""
In [39]: chr(97)
Out[39]: 'a'

In [36]: chr(8364)
Out[36]: '€'

In [37]: chr(1114111)
Out[37]: '\U0010ffff'

In [38]: chr(1114112)
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
<ipython-input-38-59208660f350> in <module>()
----> 1 chr(1114112)

ValueError: chr() arg not in range(0x110000)
"""

# classmethod(function)
# 是一个函数修饰器
"""
In [42]: class B:
    ...:     @classmethod
    ...:     def f(cls):
    ...:         print(B.f)
    ...:

In [43]: B.f()
<bound method B.f of <class '__main__.B'>>
"""

# compile(source, filename, mode, flags=0, dont_inherit=False, optimize=-1)
# TODO


# class complex([real[, imag]])
# 第二个参数永远不能是string，
# 第一个参数如果是一个字符串，被解析为复数，这个时候，第二个参数不能赋值
"""
In [52]: complex('123+456j')
Out[52]: (123+456j)

In [53]: complex('123+456j', 0)
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-53-46a74c5496e6> in <module>()
----> 1 complex('123+456j', 0)

TypeError: complex() can't take second arg if first is a string
"""

# 每一个参数都是numeric type（包括复数）
# 如果第二个参数省略，默认是实数+0j，如果第一个参数省略，那么返回0j
"""
In [54]: complex()
Out[54]: 0j

In [55]: complex(123)
Out[55]: (123+0j)

In [56]: complex(123,456)
Out[56]: (123+456j)

In [61]: complex(4, complex(6, 7))
Out[61]: (-3+6j)

In [62]: complex(complex(2, 3), complex(6, 7))
Out[62]: (-5+9j)
"""

# delattr(object, name)
# TODO


# class dict(**kwarg)
# class dict(mapping, **kwarg)
# class dict(iterable, **kwarg)
# (**kwarg)
"""
In [72]: dict(k1='v1', k2='v2')
Out[72]: {'k1': 'v1', 'k2': 'v2'}

In [73]: data = {
    ...:     'k1': 'v1',
    ...:     'k2': 'v2'
    ...: }
    ...: dict(**data)
    ...:
Out[73]: {'k1': 'v1', 'k2': 'v2'}
"""
# (mapping, **kwarg)
# TODO
# (iterable, **kwarg)
# TODO


# dir([object])
# 如果没有参数，返回current local scope（当前本地命令？）的列表
# 有参数的话，试图返回那个参数的合法属性的列表
# 对于__dir__和__dict__的一段描述，见文档
# 对于不同的types of objects，dir的行为是不一样的
"""
In [1]: import struct

In [2]: dir()
Out[2]:
['In',
 'Out',
 '_',
 '__',
 '___',
 '__builtin__',
 '__builtins__',
 '__doc__',
 '__loader__',
 '__name__',
 '__package__',
 '__spec__',
 '_dh',
 '_i',
 '_i1',
 '_i2',
 '_ih',
 '_ii',
 '_iii',
 '_oh',
 '_sh',
 'exit',
 'get_ipython',
 'quit',
 'struct']

In [3]: dir(struct)
Out[3]:
['Struct',
 '__all__',
 '__builtins__',
 '__cached__',
 '__doc__',
 '__file__',
 '__loader__',
 '__name__',
 '__package__',
 '__spec__',
 '_clearcache',
 'calcsize',
 'error',
 'iter_unpack',
 'pack',
 'pack_into',
 'unpack',
 'unpack_from']

In [4]: class B(object):
   ...:     def __dir__(self):
   ...:         return ['run']
   ...:

In [5]: dir(B())
Out[5]: ['run']
"""

# divmod(a, b)
# 参数是两个不是复数的数字类型
# 如果是两个整数，那么返回商和余数
"""
In [6]: divmod(12, 5)
Out[6]: (2, 2)

In [8]: divmod(12, 4.9)
Out[8]: (2.0, 2.1999999999999993)

In [9]: divmod(12, 4)
Out[9]: (3, 0)
"""

# enumerate(iterable, start=0)
# 接受一个可迭代的参数，返回一个枚举对象
# __next__()返回一个元组，第一项是index，第二项是数据，start参数是index的开始值
# 所以list可以拿到list
"""
In [27]: list(enumerate(seasons))
Out[27]: [(0, 'Spring'), (1, 'Summer'), (2, 'Fall'), (3, 'Winter')]

In [28]: list(enumerate(seasons, start=2))
Out[28]: [(2, 'Spring'), (3, 'Summer'), (4, 'Fall'), (5, 'Winter')]
"""

# eval(expression, globals=None, locals=None)
# globals参数是可选的，如果提供，那么是一个dictionary
# locals参数是可选的，如果提供，那么可以是任何mapping object
"""
In [1]: eval('1+1')
Out[1]: 2

In [2]: eval(bin(10))
Out[2]: 10
"""

# exec(object[, globals[, locals]])
"""
In [7]: exec('print("1234567890")')
1234567890
"""

# filter(function, iterable)
"""
In [19]: a = [1, 2, -1, 0, 4, -2]
    ...: list(filter(lambda i: i > 0, a))
    ...:
Out[19]: [1, 2, 4]
"""

# class float([x])
"""
sign           ::=  "+" | "-"
infinity       ::=  "Infinity" | "inf"
nan            ::=  "nan"
numeric_value  ::=  floatnumber | infinity | nan
numeric_string ::=  [sign] numeric_value
"""
"""
In [22]: float('+1.23')
Out[22]: 1.23

In [23]: float('   -12345\n')
Out[23]: -12345.0

In [24]: float('1e-003')
Out[24]: 0.001

In [25]: float('+1E6')
Out[25]: 1000000.0

In [26]: float('-Infinity')
Out[26]: -inf
"""
# 3.6中使用下划线分组可以识别了
"""
In [35]: float('11_22.99')
Out[35]: 1122.99
"""

# format(value[, format_spec])
# TODO

# class frozenset([iterable])
"""
In [38]: a = [1, 2, -1, 0, 4, -2]
    ...: frozenset(a)
    ...:
Out[38]: frozenset({-2, -1, 0, 1, 2, 4})
"""

# getattr(object, name[, default])
"""
In [44]: class A(object):
    ...:     def a(self):
    ...:         pass
    ...: getattr(A, 'a')
    ...:
Out[44]: <function __main__.A.a>

In [48]: getattr(A, 'b', 'default b')
Out[48]: 'default b'
"""

# globals()
# 返回当前全局符号标志表的字典，
# 返回的是被定义的地方的xx，而不是被called的xx

# hasattr(object, name)
"""
In [44]: class A(object):
    ...:     def a(self):
    ...:         pass

In [50]: hasattr(A, 'a')
Out[50]: True

In [51]: hasattr(A, 'b')
Out[51]: False
"""

# hash(object)
"""
In [52]: hash(A)
Out[52]: -9223363274321361268

In [56]: a = [1]

In [57]: hash(a)
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-57-fe724719d9a1> in <module>()
----> 1 hash(a)

TypeError: unhashable type: 'list'
"""

# help([object])
# 交互式的函数
"""
In [60]: help(help)

Help on _Helper in module _sitebuiltins object:

class _Helper(builtins.object)
 |  Define the builtin 'help'.
 |
 |  This is a wrapper around pydoc.help that provides a helpful message
 |  when 'help' is typed at the Python interactive prompt.
 |
 |  Calling help() at the Python prompt starts an interactive help session.
 |  Calling help(thing) prints help for the python object 'thing'.
 |
 |  Methods defined here:
 |
 |  __call__(self, *args, **kwds)
 |      Call self as a function.
 |
 |  __repr__(self)
 |      Return repr(self).
 |
 |  ----------------------------------------------------------------------
 |  Data descriptors defined here:
 |
 |  __dict__
 |      dictionary for instance variables (if defined)
 |
 |  __weakref__
 |      list of weak references to the object (if defined)
(END)
"""

# id(object)
# 返回一个object的identity，在不重叠的周期内，两个id可能相同

# input([prompt])
"""
In [74]: s = input('--> ')
--> hello world

In [75]: s
Out[75]: 'hello world'
"""

# class int(x=0)
# class int(x, base=10)
# 没有参数没有默认值0
# 如果参数是一个数字(非复数)，那么将其向0靠拢截断为整数
"""
In [76]: int()
Out[76]: 0

In [78]: int(1.1)
Out[78]: 1

In [79]: int(1.8)
Out[79]: 1
"""
# 在3.6中，支持下划线作为分隔符
"""
In [81]: int(1_1.8)
Out[81]: 11
"""
# 如果第一个参数是字符串，那么将使用第二个参数作为进制数解析第一个参数
"""
In [89]: int('010', 8)
Out[89]: 8

In [92]: int('010', 0)
---------------------------------------------------------------------------
ValueError                                Traceback (most recent call last)
<ipython-input-92-1fdf06fb8fa4> in <module>()
----> 1 int('010', 0)

ValueError: invalid literal for int() with base 0: '010'

In [93]: int('111', 2)
Out[93]: 7
"""

# isinstance(object, classinfo)
"""
In [101]: isinstance([], list)
Out[101]: True

In [102]: isinstance([], list())
---------------------------------------------------------------------------
TypeError                                 Traceback (most recent call last)
<ipython-input-102-a1225406137a> in <module>()
----> 1 isinstance([], list())

TypeError: isinstance() arg 2 must be a type or tuple of types
"""
# 第二个参数可以是type object的元组或者可递归的
"""
In [104]: isinstance([], (list, str))
Out[104]: True

In [105]: isinstance({}, (list, str))
Out[105]: False
"""

# issubclass(class, classinfo)
# 判断一个第一个参数是不是第二个参数的子类
# 一个类是他自己的子类
# 第二个参数可以是type object的元组或者可递归的
"""
In [109]: class A(object):
     ...:     pass
     ...: class B(A):
     ...:     pass

In [110]: issubclass(A, object)
Out[110]: True

In [113]: issubclass(A, B)
Out[113]: False

In [112]: issubclass(A, (B, object))
Out[112]: True
"""

# iter(object[, sentinel])
# TODO


# len(s)
# The argument may be a sequence (such as a string, bytes, tuple, list, or range) or a collection (such as a dictionary, set, or frozen set).
"""
In [1]: len('aaaa')
Out[1]: 4

In [2]: len([1, 2, 3])
Out[2]: 3

In [3]: len({'a': 'a', 'b': 'b'})
Out[3]: 2
"""

# class list([iterable])
# TODO

# locals()
# TODO



# map(function, iterable, ...)
"""
In [6]: list(map(lambda n: n * 2, [1, 2, 3]))
Out[6]: [2, 4, 6]
"""

# max(iterable, *[, key, default])
# max(arg1, arg2, *args[, key])
# 如果提供一个参数，返回其最大的；如果是两个，返回那个值最大的所在的项
"""
In [7]: max([2, 4, 6])
Out[7]: 6

In [12]: max([2, 4, 6], [10, 1])
Out[12]: [10, 1]
"""

# memoryview(obj)
# TODO


# min(arg1, arg2, *args[, key])
"""
In [14]: min([1, 2, 3])
Out[14]: 1

In [15]: min([1, 2, 3], [4])
Out[15]: [1, 2, 3]
"""

# next(iterator[, default])
# TODO


# class object
# 是所有class的base。


# oct(x)
# 将一个整数变成一个八进制python合法的表达式
# 如果不是一个整数，那么__index__方法应该返回一个整数
"""
In [35]: oct(10)
Out[35]: '0o12'

In [36]: 0o12
Out[36]: 10

In [37]: class A(object):
    ...:     def __index__(self):
    ...:         return 10

In [39]: oct(A())
Out[39]: '0o12'
"""

# open(file, mode='r', buffering=-1, encoding=None, errors=None, newline=None, closefd=True, opener=None)
"""
In [51]: f = open('BinaryData.py')

In [52]: f
Out[52]: <_io.TextIOWrapper name='BinaryData.py' mode='r' encoding='UTF-8'>

In [53]: f.closed
Out[53]: False

In [54]: f.close()

In [55]: f.closed
Out[55]: True
"""
"""
Character	Meaning
'r'	读文件（默认）
'w'	open for writing, truncating the file first
'x'	open for exclusive creation, failing if the file already exists
'a'	追加文件
'b'	binary mode
't'	text mode (default)
'+'	open a disk file for updating (reading and writing)
'U'	universal newlines mode (deprecated)
"""
# TODO

# ord(c)
# 和 chr()相反
# 返回一个字符的Unicode code
"""
In [59]: ord('a')
Out[59]: 97

In [60]: ord('€')
Out[60]: 8364

In [61]: ord('\U0010ffff')
Out[61]: 1114111
"""

# pow(x, y[, z])
# pow(a, b) ---> a**b， 幂运算
# pow(a, b, c) ---> (a**b) % c ，幂运算然后取模
"""
In [66]: pow(2, 3)
Out[66]: 8

In [67]: pow(2, 3, 3)
Out[67]: 2
"""

# print(*objects, sep=' ', end='\n', file=sys.stdout, flush=False)
# print() ---> print(end='\n')
"""
In [9]: print()


In [10]: print(1, 2, 3)
1 2 3

In [11]: print(1, 2, 3, sep='==')
1==2==3

In [12]: print(1, 2, 3, end='--')
1 2 3--
"""

# class property(fget=None, fset=None, fdel=None, doc=None)
"""
In [1]: class A(object):
   ...:     _x = None
   ...:
   ...:     @property
   ...:     def x(self):
   ...:         return self._x
   ...:
   ...:     @x.setter
   ...:     def x(self, v):
   ...:         self._x = v
   ...:
   ...:     @x.deleter
   ...:     def x(self):
   ...:         del self._x
   ...:
   ...: a = A()

In [3]: a.x

In [5]: a.x = 1

In [6]: a.x
Out[6]: 1

In [7]: del a.x

In [8]: a.x
"""

# range(stop)
# range(start, stop[, step])
"""
In [11]: list(range(10))
Out[11]: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]

In [12]: list(range(2, 10))
Out[12]: [2, 3, 4, 5, 6, 7, 8, 9]

In [14]: list(range(2, 10, 3))
Out[14]: [2, 5, 8]
"""

# repr(object)
"""
In [17]: class A(object):
    ...:     def __repr__(self):
    ...:         return 'this is repr.'
    ...:
    ...: repr(A())

Out[17]: 'this is repr.'
"""

# reversed(seq)
# 返回一个逆序的iterator
# seq必须是一个实现了 __reversed__() 的 object
# 或者支持 sequence protocol ( the __len__() method and the __getitem__() method with integer arguments starting at 0 )


# round(number[, ndigits])
# 参考资料 https://docs.python.org/3.6/tutorial/floatingpoint.html#tut-fp-issues

# class set([iterable])

# setattr(object, name, value)
"""
In [22]: class A(object):
    ...:     pass

In [25]: setattr(A, 'a', '2')

In [26]: A.a
Out[26]: '2'
"""

# class slice(stop)
# class slice(start, stop[, step])
# See itertools.islice() for an alternate version that returns an iterator.

# sorted(iterable[, key][, reverse])

# staticmethod(function)
"""
In [28]: class A(object):
    ...:     @staticmethod
    ...:     def f():
    ...:         print('A.f or A().f')

In [29]: A.f()
A.f or A().f

In [30]: A().f()
A.f or A().f
"""

# class str(object='')
# class str(object=b'', encoding='utf-8', errors='strict')

# sum(iterable[, start])

# super([type[, object-or-type]])

# tuple([iterable])
# 一个 immutable sequence type ，不可变序列类型？

# class type(object)
# class type(name, bases, dict)
# 一个参数，检测类型。isinstance() 推荐类测试 the type of an object
# With three arguments, return a new type object. This is essentially a dynamic form of the class statement

# vars([object])
# return __dict__
# Without an argument, vars() acts like locals(). Note, the locals dictionary is only useful for reads since updates to the locals dictionary are ignored.

# zip(*iterables)
"""
In [40]: list(zip('ABCD', 'xy'))
Out[40]: [('A', 'x'), ('B', 'y')]

In [43]: list(itertools.zip_longest('ABCD', 'xy'))
Out[43]: [('A', 'x'), ('B', 'y'), ('C', None), ('D', None)]
"""

# __import__(name, globals=None, locals=None, fromlist=(), level=0)
