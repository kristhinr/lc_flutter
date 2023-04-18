import 'dart:convert';

import 'package:encrypt/encrypt.dart' as encrypt;
import '../Common/Global.dart';



final key = encrypt.Key.fromUtf8('12345678901234561234567890123456');//可以用对话id?实现?//32位
// IV
final iv = encrypt.IV.fromUtf8('1234567890123456');//16位向量

final encryptor = encrypt.Encrypter(
    encrypt.AES(key, mode: encrypt.AESMode.cbc, padding: 'PKCS7'));

class funcEncrypt {
  String Encryption(String string) {
    if (Global.encryptionValue == true) {
      string = base64.encode(utf8.encode(string)); //前置base64封包
      //TODO:

      final encrypted = encryptor.encrypt(string, iv: iv);
      string = encrypted.base64;
      //encode = string;
    }

    return string;
  }

  String Decryption(String string) {
    String decode = '';

    if (Global.decryptionValue == true) {
      try {
        final decrypted = encryptor.decrypt64(string, iv: iv);
        decode = decrypted;
        //TODO:先解密string
        string = utf8.decode(base64.decode(decode));
      }catch (e){
        print(e);
      } finally {
        string = string;
      }
    }
    //print(">>> Global.encryptionValue:"+Global.encryptionValue.toString());
    return string;
  }

  String DecryptionMan(String string) {
    String decode = ''; //

    try {
      final decrypted = encryptor.decrypt64(string, iv: iv);
      decode = decrypted;
      //TODO:先解密string
      string = utf8.decode(base64.decode(decode));
    } finally {
      return string;
    }
  }
}
