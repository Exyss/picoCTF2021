# enc = ''.join([chr((ord(flag[i]) << 8) + ord(flag[i + 1])) for i in range(0, len(flag), 2)])

with open("enc", "r") as f:
    enc = f.read()

enc_lenght = len(enc)

print(f"Encrypted: {enc}")
print(f"Enc lenght: {enc_lenght}")

flag = ""
for i in range(len(enc)):
    firstchar = chr(ord(enc[i]) >> 8)
    secondchar = chr((ord(enc[i]) - (ord(firstchar) << 8)))

    flag += firstchar
    flag += secondchar

print(f"Flag: {flag}")