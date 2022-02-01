import 'package:flutter/material.dart';
import 'package:qr_code/pages/generate_qr_code.dart';
import 'package:qr_code/pages/scan_qr_code.dart';

class QrHomePage extends StatefulWidget {
  const QrHomePage({Key? key}) : super(key: key);

  @override
  State<QrHomePage> createState() => _QrHomePageState();
}

class _QrHomePageState extends State<QrHomePage> {
  int _currentIndex = 0;
  var pages = [
    const QrCreate(),
    const QrScan(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: pages[_currentIndex]),
      bottomNavigationBar: Container(
        height: 60,
        margin: const EdgeInsets.only(bottom: 10, left: 10, right: 10),
        decoration: BoxDecoration(
          color: const Color(0XFF476499),
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 0;
                  });
                },
                child: Column(
                  children: const [
                    Expanded(child: Icon(Icons.qr_code, color: Colors.white)),
                    Text('Create QR code',
                        style: TextStyle(color: Colors.white)),
                  ],
                ),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(bottom: 10, top: 10),
                width: 1,
                height: double.infinity,
                decoration: const BoxDecoration(color: Colors.white)),
            Expanded(
              child: TextButton(
                onPressed: () {
                  setState(() {
                    _currentIndex = 1;
                  });
                },
                child: Column(
                  children: const [
                    Expanded(child: Icon(Icons.qr_code_2, color: Colors.white)),
                    Text('Scan QR code', style: TextStyle(color: Colors.white)),
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
