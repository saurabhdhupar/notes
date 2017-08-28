import codecs

obj = '学编程，hello, world.'
obj_encode = codecs.encode(obj, encoding='utf-8', errors='strict')
# b'\xe5\xad\xa6\xe7\xbc\x96\xe7\xa8\x8b\xef\xbc\x8chello, world.'

obj_decode = codecs.decode(obj_encode, encoding='utf-8', errors='strict')
# 学编程，hello, world.

codec_info = codecs.lookup('utf-8')
# <codecs.CodecInfo object for encoding utf-8 at 0x10f2114c8>

# TODO
