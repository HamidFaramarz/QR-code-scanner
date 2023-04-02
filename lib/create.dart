import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'dart:typed_data';
import 'package:share/share.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'dart:ui' as ui;
import 'package:path_provider/path_provider.dart';
import 'extra.dart';

class CreateQRCode extends StatefulWidget {
  const CreateQRCode({super.key});

  @override
  State<CreateQRCode> createState() => _CreateQRCodeState();
}

class _CreateQRCodeState extends State<CreateQRCode> {
  final TextEditingController TextQRCode12 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(98, 98, 105, 245),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: TextQRCode12,
                style: TextStyle(color: Colors.white, fontSize: 18),
                maxLines: 10,
                maxLength: 200,
                decoration: InputDecoration(
                  fillColor: Color.fromARGB(255, 242, 103, 103),
                  filled: true,
                  hintText: "Enter text to generate a QR code....",
                  hintStyle: TextStyle(color: Colors.white, fontSize: 18),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.redAccent)),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Extra(textQrCode12: TextQRCode12.text.trim()),
                  ));
                },
                child: Container(
                  height: 60,
                  width: 300,
                  child: Center(
                    child: Text(
                      "Generate QR Code",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 242, 103, 103),
                      borderRadius: BorderRadius.circular(10)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
