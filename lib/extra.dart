import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:share/share.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';

class Extra extends StatefulWidget {
  final String? textQrCode12;
  const Extra({super.key, this.textQrCode12});

  @override
  State<Extra> createState() => _ExtraState();
}

class _ExtraState extends State<Extra> {
  GlobalKey globalKey = GlobalKey();
  Future<void> converQrCodeToImage1() async {
    RenderRepaintBoundary boundary =
        globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
    ui.Image image = await boundary.toImage();
    final directory = (await getApplicationDocumentsDirectory()).path;
    ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    Uint8List pngBytes = byteData!.buffer.asUint8List();
    File imgFile = File("$directory/qrCode.png");
    await imgFile.writeAsBytes(pngBytes);
    await Share.shareFiles([imgFile.path], text: "Your text share");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Qr code scrren"),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Color.fromARGB(255, 5, 42, 110),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
                child: RepaintBoundary(
              key: globalKey,
              child: QrImage(
                data: "${widget.textQrCode12}",
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
                gapless: true,
                errorStateBuilder: (cxt, err) {
                  return const Center(
                    child: Text("Error"),
                  );
                },
              ),
            )),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () => converQrCodeToImage1(),
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.red, width: 4)),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share_outlined,
                          color: Theme.of(context).primaryColor),
                      const SizedBox(width: 10),
                      Text(
                        "Convert QR code to image and Share",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      )
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
