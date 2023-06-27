import 'dart:convert';
import 'dart:typed_data';
import 'package:hex/hex.dart';

class CVT {
  static String hexASCII(String hex) {
    List<String> splitted = [];
    for (int i = 0; i < hex.length; i = i + 2) {
      splitted.add(hex.substring(i, i + 2));
    }
    String ascii = List.generate(splitted.length, (index) =>
        String.fromCharCode(int.parse(splitted[index], radix: 16))
    ).join();
    return ascii;
  }

  static int hexInt(String hex) {
    return int.parse(hex, radix: 16);
  }

  static Uint8List hexByteArray(String hex) {
    return Uint8List.fromList(HEX.decode(hex));
  }

  static String byteArrayStrHex(List<int> hex) {
    return HEX.encode(hex).toUpperCase();
  }

  static List<int> int16LittleEndian(int value) {
    return Uint8List(2)..buffer.asByteData().setInt16(0, value, Endian.little);
  }

  static String base64toStringHex(String strbase64) {
    return CVT.byteArrayStrHex(base64.decode(strbase64));
  }

  static String stringHEXtoBase64(String strhex) {
    return base64.encode(CVT.hexByteArray(strhex));
  }

  static String byteArraytobase64(List<int> bytearray) {
    return base64.encode(bytearray);
  }

  static Uint8List base64tobyteArray(String b64) {
    return base64.decode(b64);
  }

}