# NimRC4


## Description
Simple and fast RC4 Cipher coded in Nim language. Learning Nim language small project.


## Installation
Can be imported into your Nim projects or run stand alone with examples.
```nim
import Nimrc4 
```

## Usage
Encryption takes a plain text Key and plain text string to be encrypted, the result is a Encrypted Hex String
```nim
# Encrypt
 rc4Encrypt("MySuperSecretKey", "The quick brown fox jumps over the lazy dog!") # Result = "CBF52617FE0B5A2DD794A6D3A6F4EC16BC267B87A80258417BE24975CFFDBE2899D697420301E74D2065D728"

```

Decryption takes a plain text Key and a Encrypted Hex string to be decrypted, the result is a decrypted Hex string to plain text
```nim
# Decryption
rc4Decrypt("MySuperSecretKey", "CBF52617FE0B5A2DD794A6D3A6F4EC16BC267B87A80258417BE24975CFFDBE2899D697420301E74D2065D728") # Result = "Plain Text String"

```

