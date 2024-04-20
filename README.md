# RC4 Encryption/Decryption in Nim

This repository contains an implementation of the RC4 stream cipher algorithm in the Nim programming language. The RC4 algorithm is used for encryption and decryption of data.

**Note:** The RC4 algorithm is considered insecure and should not be used for cryptographic purposes in modern applications. It's recommended to use more secure algorithms like AES or ChaCha20-Poly1305 for encryption and decryption tasks.

## Usage

The implementation provides two procedures:

1. `rc4CryptDecrypt(Key, Text: string, encrypt: bool): string`
   - This procedure takes a `Key` string, a `Text` string (plaintext or encrypted hexadecimal string), and a `bool` flag `encrypt` to indicate whether to perform encryption or decryption.
   - If `encrypt` is `true`, the function encrypts the `Text` using the RC4 algorithm with the provided `Key` and returns the encrypted string as a hexadecimal string.
   - If `encrypt` is `false`, the function decrypts the `Text` (which should be a hexadecimal string) using the RC4 algorithm with the provided `Key` and returns the decrypted plaintext string.

2. `rc4KeyInit(Key: string): array[0..255, int]`
   - This is a helper procedure that initializes the key array used by the RC4 algorithm based on the provided `Key` string.

Example usage:

```nim
import Nimrc4

let
  key = "MySecretKey"
  plaintext = "Hello, World!"
  ciphertext = rc4CryptDecrypt(key, plaintext, true)
  decrypted = rc4CryptDecrypt(key, ciphertext, false)

echo "Plaintext: ", plaintext
echo "Encrypted: ", ciphertext
echo "Decrypted: ", decrypted
```

This code will output:

```bash
Plaintext: Hello, World!
Encrypted: 76638EF2A5F58619672564776F6E69F36B3F336524D7D361
Decrypted: Hello, World!
```

## Unit Tests

The implementation includes a unit test block that tests the encryption and decryption functionality. To run the tests, compile and run the code:

```bash
nim c -r rc4.nim
```

If the tests pass, you should see the output "Encryption/Decryption successful!".

## Limitations

The RC4 implementation in this repository is for educational purposes only and should not be used in production environments due to the insecure nature of the RC4 algorithm.
The code does not include error handling for all possible edge cases or input validations beyond the basic checks.

