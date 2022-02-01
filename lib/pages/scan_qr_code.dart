import 'dart:developer';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QrScan extends StatefulWidget {
  const QrScan({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _QrScanState();
}

class _QrScanState extends State<QrScan> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  void dispose() {
    super.dispose();
    controller?.dispose();
  }

  snackBar(context) => const SnackBar(
        backgroundColor: Colors.grey,
        elevation: 10,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.only(bottom: 15, top: 10, left: 10, right: 10),
        content: Text('Text Copied!'),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(flex: 4, child: _buildQrView(context)),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                if (result != null)
                  Column(
                    children: [
                      const SizedBox(height: 10),
                      Text(
                        '${result!.code}',
                        style:
                            const TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      TextButton(
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: "${result!.code}"));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(snackBar(context));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                                color: const Color(0XFF476499),
                                borderRadius: BorderRadius.circular(10)),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Text('Copy to clipboard',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 16)),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Icon(Icons.copy_outlined,
                                      color: Colors.white, size: 15)
                                ],
                              ),
                            ),
                          ))
                    ],
                  )
                else
                  const Text('Scan a code',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: IconButton(
                          onPressed: () async {
                            await controller?.toggleFlash();
                            setState(() {});
                          },
                          icon: FutureBuilder(
                            future: controller?.getFlashStatus(),
                            builder: (context, snapshot) {
                              return snapshot.data == false
                                  ? const Icon(Icons.flash_off_outlined,
                                      color: Colors.white, size: 25)
                                  : const Icon(Icons.flash_on_outlined,
                                      color: Colors.white, size: 25);
                            },
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: IconButton(
                          onPressed: () async {
                            await controller?.flipCamera();
                            setState(() {});
                          },
                          icon: FutureBuilder(
                            future: controller?.getCameraInfo(),
                            builder: (context, snapshot) {
                              if (snapshot.data != null) {
                                return const Icon(Icons.switch_camera_outlined,
                                    color: Colors.white, size: 25);
                              } else {
                                return const Icon(Icons.camera,
                                    color: Colors.white, size: 25);
                              }
                            },
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: IconButton(
                        onPressed: () async {
                          await controller?.pauseCamera();
                        },
                        icon: const Icon(Icons.pause,
                            color: Colors.white, size: 25),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(8),
                      child: IconButton(
                        onPressed: () async {
                          await controller?.resumeCamera();
                        },
                        icon: const Icon(Icons.play_arrow,
                            color: Colors.white, size: 25),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildQrView(BuildContext context) {
    // For this example we check how width or tall the device is and change the scanArea and overlay accordingly.
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 280.0;
    // To ensure the Scanner view is properly sizes after rotation
    // we need to listen for Flutter SizeChanged notification and update controller
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 30,
          borderWidth: 10,
          cutOutSize: scanArea),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }
}
