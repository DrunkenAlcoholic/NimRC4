import std/strutils

proc rc4KeyInit(Key: string): array[0..255, int] =
  var result: array[0..255, int]
  for i in 0..255:
    result[i] = i
  for i in 0..255:
    let intChar = ord(char(Key[i mod Key.len]))
    var j = 0
    j = (j + result[i] + intChar) mod 256
    swap(result[i], result[j])

proc rc4CryptDecrypt*(Key, Text: string, encrypt: bool): string =
  ## Encrypts or decrypts the given `Text` using the RC4 algorithm with the provided `Key`.
  ## If `encrypt` is true, the function performs encryption; otherwise, it performs decryption.
  ## Returns the encrypted/decrypted string.
  if Key.len == 0:
    raise newException(ValueError, "Key cannot be empty")

  var
    i, j, y: int = 0
    arrKey: array[0..255, int]
    intChar: int
    strResult: string = ""

  arrKey = rc4KeyInit(Key)

  if encrypt:
    for y in 0..pred(Text.len):
      i = (succ(i)) mod 256
      j = (j + arrKey[i]) mod 256
      swap(arrKey[i], arrKey[j])
      intChar = ord(char(Text[y])) xor arrKey[(arrKey[i] + arrKey[j]) mod 256]
      strResult = strResult & toHex(intChar, 2)
  else:
    if Text.len mod 2 != 0 or Text.len == 0:
      raise newException(ValueError, "Encrypted text must be a non-empty hexadecimal string with an even length")

    y = 0
    while y < pred(Text.len):
      i = (succ(i)) mod 256
      j = (j + arrKey[i]) mod 256
      swap(arrKey[i], arrKey[j])
      intChar = fromHex[int](Text[y] & Text[succ(y)]) xor arrKey[(arrKey[i] + arrKey[j]) mod 256]
      strResult = strResult & intChar.char
      inc(y, 2)

  result = strResult

# Unit tests
when isMainModule:
  block:
    let
      key = "MySecretKey"
      plaintext = "Hello, World!"
      ciphertext = rc4CryptDecrypt(key, plaintext, true)
      decrypted = rc4CryptDecrypt(key, ciphertext, false)
    doAssert decrypted == plaintext, "Encryption/Decryption failed"
    echo "Encryption/Decryption successful!"
