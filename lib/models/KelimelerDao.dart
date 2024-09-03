import 'package:flutter_sozluk_uygulamasi/models/Kelimeler.dart';
import 'package:flutter_sozluk_uygulamasi/models/VeritabaniYardimcisi.dart';

class Kelimelerdao {
  Future<List<Kelimeler>> tumKelimeler() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps =
        await db.rawQuery("SELECT * FROM kelimeler");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kelimeler(
          kelime_id: satir["kelime_id"],
          ingilizce: satir["ingilizce"],
          turkce: satir["turkce"]);
    });
  }

  Future<List<Kelimeler>> kelimeAra(String aramaKelimesi) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();
    List<Map<String, dynamic>> maps = await db.rawQuery(
        "SELECT * FROM kelimeler WHERE ingilizce AND turkce LIKE '%$aramaKelimesi%'");
    return List.generate(maps.length, (i) {
      var satir = maps[i];
      return Kelimeler(
          kelime_id: satir["kelime_id"],
          ingilizce: satir["ingilizce"],
          turkce: satir["turkce"]);
    });
  }
}
