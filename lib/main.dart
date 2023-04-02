import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
  String TextGenerateQRScan = "";

  Future<void> qrScannner() async {
    setState(() {});
    try {
      TextGenerateQRScan = "";
      final qrcode12 = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "cancel", true, ScanMode.QR);
      if (qrcode12 != "-1" && qrcode12.isNotEmpty) {
        TextGenerateQRScan = qrcode12;
        setState(() {});
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(98, 98, 105, 245),
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
                //color: Colors.amber,
                child: Center(
                    child: Text(
                  "Scan Qr/Bar Code",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                )),
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 242, 103, 103),
                    borderRadius: BorderRadius.circular(10)),
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
                      builder: (context) => CreateQRCode(),
                    ));
              },
              child: Container(
                child: Center(
                  child: Text(
                    "Generate QR Code",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
                height: 60,
                width: 300,
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 242, 103, 103),
                    borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            if (TextGenerateQRScan.isNotEmpty)
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                          width: 3, color: Color.fromARGB(255, 73, 236, 236))),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 25, right: 25),
                    child: Column(
                      children: [
                        SelectableText(
                          TextGenerateQRScan,
                          style: const TextStyle(
                              fontSize: 16, color: Colors.white),
                        ),
                        ElevatedButton(
                            onPressed: () {
                              Clipboard.setData(
                                  ClipboardData(text: TextGenerateQRScan));
                            },
                            child: Text("Copy Link")),
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
