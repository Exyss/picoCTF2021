from pwn import *

KEY_LEN = 50000

r = remote("mercury.picoctf.net", 41934)
r.recvuntil("This is the encrypted flag!\n")

#read the encrypted flag
enc_flag = r.recvlineS(keepends = False)
log.info(f"Ecrypted Flag: {enc_flag}")

bin_enc_flag = unhex(enc_flag)
to_send = KEY_LEN - len(bin_enc_flag)

#send N chars to loop to 0 the key_location value
r.sendlineafter("What data would you like to encrypt? ", "a"*to_send)

#send XORed flag to get the original flag due to XOR properties 
r.sendlineafter("What data would you like to encrypt? ", bin_enc_flag)

r.recvlineS()   #skip "Here ya go!" line
flag = unhex(r.recvlineS()).decode('utf-8') #decode to utf-8 to read as string

log.success("The flag: picoCTF{"+flag+"}")