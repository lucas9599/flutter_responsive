import 'package:encrypt/encrypt.dart';

///Criptografia para dados privados
abstract class Criptografia {
//static const key = "23467908765339787373665252425678893";
  static List<String> keys = [
    "5937470639580656",
    "7968356426523143",
    "8111928590837676",
    "8795307176759202",
    "9141738467091106",
    "1051156208710217",
    "6466423100930813",
    "9826640904009078",
    "7918339824754844",
    "8004023355670145",
    "5251978580838831",
    "3047368192163905",
    "5325264673470155",
    "3826158657601846",
    "2710664989557474",
    "5342299083668947",
    "0946662044951099",
    "8543085933933877",
    "8744304807635129",
    "3730249034949925"
  ];

  static Map<String, String> _getKey(String codigo) {
    Map<String, String> res = {};
    String pos = codigo.substring(codigo.length - 1, codigo.length);
    res.addAll({'key': keys[int.parse(pos)]});
    res.addAll({'texto': codigo.substring(0, codigo.length - 2)});
    return res;
  }

  ///Descriptografa dados
  static String descriptografar(String texto) {
    Map<String, String> chavevalor = _getKey(texto);
    texto = chavevalor['texto']!;
    String keyselecionada = chavevalor['key']!;

    final key = Key.fromUtf8(keyselecionada);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

    return encrypter.decrypt16(texto, iv: iv);

    /*String c = "";
    String result = "";
    int i;
    int pos;
    for (i = 0; i <= (texto.length / 2).truncate() - 1; i++) {
      pos = (i * 2);
      List<int> hexa = HEX.decode(texto.substring(pos, pos + 2));
      c = utf8.decode(hexa);

      if (key.length > 0) {
        pos = 1 + (i % key.length);
        c = utf8.decode([
          utf8.encode(key.substring(pos - 1, pos)).last ^ (utf8.encode(c).last)
        ]);
      }
      result = result + c;
    }
*/
    //return result;
  }

  ///criptografa dados
  static String criptografar(String texto) {
    return texto;
    /*
    String a1 = Random().nextInt(1).toString();
    String b2 = Random().nextInt(9).toString();
    int pos = int.parse((a1 + b2));
    String keyselecionada = keys[pos];
    final key = Key.fromUtf8(keyselecionada);
    final iv = IV.fromLength(16);

    final encrypter = Encrypter(AES(key, mode: AESMode.ecb));

    final res = encrypter.encrypt(texto, iv: iv);
    final a = res.base16 + a1 + b2;
    return a;

    /*int a, b, c, i;
    int numero;
    String result = "";
    List<int> bytetexto = utf8.encode(removeDiacritics(texto));
    List<int> bytekey = utf8.encode(key);

    for (i = 1; i <= texto.length; i++) {
      if (key.length > 0) {
        numero = 1 + ((i - 1) % key.length);
        a = bytekey[numero - 1];
        b = bytetexto[i - 1];
        c = a ^ (b);
      } else {
        c = bytetexto[i];
      }

      result = result + HEX.encode([c]);
    }
    result = result + a1 + b2;
    return result;
  */
  */
  }
}
