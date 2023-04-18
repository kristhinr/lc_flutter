import 'dart:convert';
import 'package:encrypt/encrypt.dart';
import 'package:pointycastle/pointycastle.dart';
import 'package:pointycastle/export.dart';


String encryptAes(String plainText, String keyStr) {
  final keyBytes = utf8.encode(keyStr);
  final key = KeyParameter(keyBytes);
  final iv = IV.fromLength(16);


  final encrypter = BlockCipher('AES')..init(true, key);

  final paddedPlainText = _pad(plainText);
  final plainTextBytes = utf8.encode(paddedPlainText);

  final cipherText = encrypter.process(plainTextBytes);

  final encodedCipherText = base64.encode(cipherText);

  return encodedCipherText;
}

String decryptAes(String cipherText, String keyStr) {
  final keyBytes = utf8.encode(keyStr);
  final key = KeyParameter(keyBytes);
  final iv = IV.fromLength(16);

  final encrypter = BlockCipher('AES')..init(false, key);

  final cipherTextBytes = base64.decode(cipherText);

  final paddedPlainTextBytes = encrypter.process(cipherTextBytes);

  final paddedPlainText = utf8.decode(paddedPlainTextBytes);

  final plainText = _unpad(paddedPlainText);

  return plainText;
}

String _pad(String plainText) {
  final blockSize = 16;
  final paddingChar = ' ';
  final padLength = blockSize - (plainText.length % blockSize);
  final pad = paddingChar * padLength;
  return plainText + pad;
}

String _unpad(String paddedPlainText) {
  final paddingChar = ' ';
  final lastNonPaddingCharIndex = paddedPlainText.lastIndexOf(RegExp('[^$paddingChar]'));
  final plainText = paddedPlainText.substring(0, lastNonPaddingCharIndex + 1);
  return plainText;
}
