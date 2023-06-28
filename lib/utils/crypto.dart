import 'dart:convert';

import 'package:citchat/utils/cvt.dart';
import 'package:encrypt/encrypt.dart';

String encrypt(String plain) {
  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(16);

  try {
    final encrypt = Encrypter(AES(Key(CVT.stringHEXtobytearray("64656e6761726c6172616b757375726168617469696e696d656d616e6767696c")),
        mode: AESMode.ctr,
        padding: null));
    String finData = plain.isEmpty ? "-" : plain;
    final encrypted = encrypt.encryptBytes(utf8.encode(finData),
        iv: IV(CVT.stringHEXtobytearray("6b6172656e6173656c75727568616b75")));
    return CVT.byteArraytoStringHEX(encrypted.bytes);
  } catch (e) {
    print(e.toString());
    return '';
  }
}

String decrypt(String cipher) {
  final key = Key.fromSecureRandom(32);
  final iv = IV.fromSecureRandom(16);

  try {
    final decrypt = Encrypter(AES(
        Key(CVT.stringHEXtobytearray("64656e6761726c6172616b757375726168617469696e696d656d616e6767696c")),
      mode: AESMode.ctr,
      padding: null
    ));
    String finData = cipher.isEmpty ? "-" : cipher;
    final decrypted = decrypt.decryptBytes(
      Encrypted(CVT.stringHEXtobytearray(finData)),
      iv: IV(CVT.stringHEXtobytearray("6b6172656e6173656c75727568616b75"))
    );

    return utf8.decode(decrypted);
  } catch (e) {
    print(e.toString());
    return '';
  }
}