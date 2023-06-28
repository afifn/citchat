import 'dart:convert';
import 'dart:typed_data';
import 'package:hex/hex.dart';

class CVT {
  static String stringHEXtostringASCII(String strhex) {
    String hexString = strhex;
    List<String> splitted = [];
    for (int i = 0; i < hexString.length; i = i + 2) {
      splitted.add(hexString.substring(i, i + 2));
    }
    String ascii = List.generate(splitted.length,
            (i) => String.fromCharCode(int.parse(splitted[i], radix: 16))).join();
    return ascii;
  }

  static int stringHEXtoInt(String strhex) {
    return int.parse(strhex, radix: 16);
  }

  static Uint8List stringHEXtobytearray(String strhex) {
    return Uint8List.fromList(HEX.decode(strhex));
  }

  static String byteArraytoStringHEX(List<int> strhex) {
    return HEX.encode(strhex).toUpperCase();
  }

  static List<int> int16LitteEndian(int value) =>
      Uint8List(2)..buffer.asByteData().setInt16(0, value, Endian.little);

  static String base64toStringHex(String strbase64) {
    return CVT.byteArraytoStringHEX(base64.decode(strbase64));
  }

  static String stringHEXtoBase64(String strhex) {
    return base64.encode(CVT.stringHEXtobytearray(strhex));
  }

  static String byteArraytobase64(List<int> bytearray) {
    return base64.encode(bytearray);
  }

  static Uint8List base64tobyteArray(String b64) {
    return base64.decode(b64);
  }

}