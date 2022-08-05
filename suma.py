import ctypes
import mmap

buf = mmap.mmap(-1, mmap.PAGESIZE, prot=mmap.PROT_READ |
                mmap.PROT_WRITE | mmap.PROT_EXEC)

ftype = ctypes.CFUNCTYPE(ctypes.c_int, ctypes.c_int)
fpointer = ctypes.c_void_p.from_buffer(buf)

f = ftype(ctypes.addressof(fpointer))

buf.write(
    b'x8bxc7'  # mov eax, edi
    b'x83xc0x01'  # add eax, 1
    b'xc3'  # ret
)

r = f(42)
print(r)

del fpointer
buf.close()
