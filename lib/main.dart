import 'package:flutter/material.dart';
import 'package:flutter_sozluk_uygulamasi/DetaySayfa.dart';
import 'package:flutter_sozluk_uygulamasi/models/Kelimeler.dart';
import 'package:flutter_sozluk_uygulamasi/models/KelimelerDao.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sözlük Uygulaması',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const Anasayfa(),
    );
  }
}

class Anasayfa extends StatefulWidget {
  const Anasayfa({super.key});

  @override
  State<Anasayfa> createState() => _AnasayfaState();
}

class _AnasayfaState extends State<Anasayfa> {
  bool aramaYapiliyorMu = false;
  String aramaKelimesi = '';
  Future<List<Kelimeler>> tumKelimelerGoster() async {
    var kelimelerListesi = await Kelimelerdao().tumKelimeler();
    return kelimelerListesi;
  }

  Future<List<Kelimeler>> aramaYap(String aramaKelimesi) async {
    var kelimelerListesi = await Kelimelerdao().kelimeAra(aramaKelimesi);
    return kelimelerListesi;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: aramaYapiliyorMu
            ? TextField(
                decoration: const InputDecoration(
                  hintText: "ARA",
                  hintStyle: TextStyle(color: Colors.white),
                ),
                onChanged: (araSonucu) {
                  print("Arama Sonucu : $araSonucu");
                  setState(() {
                    aramaKelimesi = araSonucu;
                  });
                },
              )
            : const Text(
                "Sözlük Uygulaması",
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
        actions: [
          aramaYapiliyorMu
              ? IconButton(
                  icon: const Icon(
                    Icons.cancel,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = false;
                      aramaKelimesi = "";
                    });
                  },
                )
              : IconButton(
                  icon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      aramaYapiliyorMu = true;
                    });
                  },
                ),
        ],
      ),
      body: FutureBuilder<List<Kelimeler>>(
        future:
            aramaYapiliyorMu ? aramaYap(aramaKelimesi) : tumKelimelerGoster(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            var kelimelerListesi = snapshot.data;
            return ListView.builder(
              itemCount: kelimelerListesi!.length,
              itemBuilder: (context, indeks) {
                var kelime = kelimelerListesi[indeks];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Detaysayfa(
                                  kelime: kelime,
                                )));
                  },
                  child: SizedBox(
                    height: 80,
                    child: Card(
                      shadowColor: Colors.amber,
                      elevation: 10,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            kelime.ingilizce,
                            style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue),
                          ),
                          const Icon(Icons.arrow_right),
                          Text(
                            kelime.turkce,
                            style: const TextStyle(
                                fontSize: 18, color: Colors.lightGreen),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center();
          }
        },
      ),
    );
  }
}
