// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_sozluk_uygulamasi/models/Kelimeler.dart';

class Detaysayfa extends StatefulWidget {
  Kelimeler kelime;
  Detaysayfa({
    super.key,
    required this.kelime,
  });

  @override
  State<Detaysayfa> createState() => _DetaysayfaState();
}

class _DetaysayfaState extends State<Detaysayfa> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: const Text("Detay Sayfası"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 250,
              width: 250,
              child: Card(
                shadowColor: Colors.amber,
                elevation: 10,
                color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.kelime.ingilizce,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.lightBlue),
                    ),
                  ],
                ),
              ),
            ),
            const Icon(
              Icons.arrow_drop_down,
              size: 55,
            ),
            SizedBox(
              height: 250,
              width: 250,
              child: Card(
                shadowColor: Colors.amber,
                elevation: 10,
                color: Colors.amber,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.kelime.turkce,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 40,
                          color: Colors.lightGreen),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
