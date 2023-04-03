import 'package:flutter/material.dart';
import 'generateCode.dart';

class CreateQRCode extends StatefulWidget {
  const CreateQRCode({super.key});

  @override
  State<CreateQRCode> createState() => _CreateQRCodeState();
}

class _CreateQRCodeState extends State<CreateQRCode> {
  final TextEditingController textQRCode12 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 28, right: 28),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: textQRCode12,
                style: const TextStyle(color: Colors.black, fontSize: 18),
                maxLines: 10,
                maxLength: 200,
                decoration: InputDecoration(
                  fillColor: Colors.amberAccent,
                  filled: true,
                  hintText: "Enter text to generate a QR code....",
                  hintStyle: const TextStyle(color: Colors.grey, fontSize: 18),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.redAccent)),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.deepPurple),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        Extra(textQrCode12: textQRCode12.text.trim()),
                  ));
                },
                child: Container(
                  height: 60,
                  width: 300,
                  // ignore: sort_child_properties_last
                  child: const Center(
                    child: Text(
                      "Generate QR Code",
                      style: TextStyle(fontSize: 20, color: Colors.black),
                    ),
                  ),
                  decoration: BoxDecoration(
                      color: Colors.amberAccent,
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
