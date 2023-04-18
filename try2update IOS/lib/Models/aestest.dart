import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;

void main() {
  // 加密目标字符串
  const s = '加密目标字符串';
  // Key
  final key = encrypt.Key.fromUtf8('12345678901234561234567890123456');
  // IV
  final iv = encrypt.IV.fromUtf8('1234567890123456');

  final encryptor = encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

  final encrypted = encryptor.encrypt(s, iv: iv);

  final decrypted = encryptor.decrypt(encrypted, iv: iv);

  String a;
  var b;
  a = encrypted.base64;//转换为list int
 //转换回来
  final de2 = encryptor.decrypt64(a, iv: iv);
  print(de2);
  print(decrypted);
  //print();
}
