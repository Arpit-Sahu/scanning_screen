import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

  class BuildView extends StatefulWidget {

  @override
  _BuildViewState createState() => _BuildViewState();
}

class _BuildViewState extends State<BuildView> {
    final qrKey = GlobalKey(debugLabel: 'QR');
    QRViewController? controller;

    @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

    @override
    Widget build(BuildContext context) {
      void onQRViewCreated(QRViewController controller){
        setState(() {
          this.controller = controller;
        });
      }
      return QRView(key: qrKey, onQRViewCreated: onQRViewCreated, overlay: QrScannerOverlayShape(
        // cutOutSize: MediaQuery.of(context).size.width,
        borderWidth: 10,
        borderColor: Colors.greenAccent,
      ),);
      
    }
}