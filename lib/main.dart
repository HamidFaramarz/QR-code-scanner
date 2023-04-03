import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'create.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String textGenerateQRScan = "";

  Future<void> qrScannner() async {
    setState(() {});
    try {
      textGenerateQRScan = "";
      final qrcode12 = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", true, ScanMode.QR);
      if (qrcode12 != "-1" && qrcode12.isNotEmpty) {
        textGenerateQRScan = qrcode12;
        setState(() {});
      }
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(98, 98, 105, 245),
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              "assets/qrCode.png",
              height: 300,
            ),
            const SizedBox(
              height: 60,
            ),
            GestureDetector(
              onTap: () => qrScannner(),
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                    child: Text(
                  "Scan Qr/Bar Code",
                  style: TextStyle(fontSize: 20, color: Colors.black),
                )),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CreateQRCode(),
                    ));
              },
              child: Container(
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(10)),
                child: const Center(
                  child: Text(
                    "Generate QR Code",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            if (textGenerateQRScan.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 3,
                          color: const Color.fromARGB(255, 73, 236, 236))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        SelectableText(
                          textGenerateQRScan,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: textGenerateQRScan));
                            },
                            child: const Text("Copy Link")),
                      ],
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
