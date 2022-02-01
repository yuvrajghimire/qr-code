import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCreate extends StatefulWidget {
  const QrCreate({Key? key}) : super(key: key);

  @override
  State<QrCreate> createState() => _QrCreateState();
}

class _QrCreateState extends State<QrCreate> {
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            QrImage(
              data: textController.text,
              backgroundColor: Colors.white,
              size: 200,
            ),
            const SizedBox(height: 80),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff2d496f)
                          .withOpacity(0.5), //color of shadow
                      spreadRadius: 5, //spread radius
                      blurRadius: 7, // blur radius
                      offset: const Offset(0, 0),
                    )
                  ],
                  color: const Color(0XFF2d496f),
                  borderRadius: BorderRadius.circular(20)),
              width: double.infinity,
              child: Center(
                child: TextField(
                  cursorColor: Colors.white,
                  cursorHeight: 25,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                  controller: textController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      fillColor: Color(0XFF2d496f),
                      filled: true),
                ),
              ),
            ),
            const SizedBox(height: 40),
            TextButton(
              onPressed: () {
                setState(() {});
              },
              child: Container(
                width: 150,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Create',
                      style: TextStyle(color: Color(0XFF2d496f), fontSize: 18),
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
