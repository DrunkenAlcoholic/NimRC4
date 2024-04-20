import std/strutils

#[
 RC4 Key Init
 Input[string]: Plain text Key string
 Output[Array]: Converted Key to array of Int
]#
proc rc4KeyInit(Key: string): array[0..255, int] =
  var
    i, j, intChar: int = 0
    arrKey: array[0..255, int]

  
  for i in low(arrKey)..high(arrKey):
    arrKey[i] = i


  for i in 0..255:
    intChar = ord(char(Key[i mod Key.len]))
    j = (j + arrKey[i] + intChar) mod 256
    swap(arrKey[i], arrKey[j])

  result = arrKey
  
  
#[
RC4 Encryption
Input[string]: Key to use for encrypting the plain text
Input[string]: String to be encrypted
Output[string]: Encrypted Hex string  
]#
proc rc4Encrypt*(Key, Text: string ): string =
  var
    i, j, y: int = 0
    arrKey: array[0..255, int]
    intChar: int
    strResult: string = ""

  arrKey = rc4KeyInit(Key)
 
 
  for y in 0..pred(Text.len):
    i = (succ(i)) mod 256
    j = (j + arrKey[i]) mod 256
    swap(arrKey[i], arrKey[j])

    intChar = ord(char(Text[y])) xor arrKey[(arrKey[i] + arrKey[j]) mod 256]

    strResult = strResult & toHex(intChar, 2)

  result = strResult

  
#[
RC4 Decryption
Input[string]: Key to use for decrypting the hex string
Input[string]: Encrypted Hex string
Output[string]: Decrypted Hex string to plain text
]#
proc rc4Decrypt*(Key, HexString: string): string =
  var
    i, j, y: int = 0
    arrKey: array[0..255, int]
    intChar: int
    strResult: string = ""

  arrKey = rc4KeyInit(Key)

  
  if ((HexString.len mod 2 == 0) and (HexString.len > 0)):
    while y < pred(HexString.len):
      i = (succ(i)) mod 256
      j = (j + arrKey[i]) mod 256
      swap(arrKey[i], arrKey[j])
    
      intChar = fromHex[int](HexString[y] & HexString[succ(y)] ) xor arrKey[(arrKey[i] + arrKey[j]) mod 256]

      strResult = strResult & (intChar).char

      inc(y, 2)

  result = strResult
  


when isMainModule:
#[
Testing Encryption / Decryption Examples  
]#
  var
   key, string, hexstring: string

  key = "MySuperSecretKey"
  string = "The quick brown fox jumps over the lazy dog!"
  hexstring = rc4Encrypt(key, string)

  echo "Key: " & key
  echo "String: " & string
  echo "RC4 Encrypted String: " & hexstring

  echo ""

  echo "Decrypting: " & hexstring
  echo "Key: " & key
  echo "Decrypted Plaion text: " & rc4Decrypt(key, hexstring)

    
    

  
