import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

typedef StringCallback = void Function(String);

class ScanCode extends StatelessWidget {
  const ScanCode({Key? key, required this.callback}) : super(key: key);

  final StringCallback callback;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Scan QR Code"),
      ),
      body: MobileScanner(
          allowDuplicates: false,
          controller: MobileScannerController(
            facing: CameraFacing.front,
            torchEnabled: true,
          ),
          onDetect: (barcode, args) {
            if (barcode.rawValue == null) {
              debugPrint('Failed to scan Barcode');
            } else {
              final String code = barcode.rawValue!;
              callback(code);
              Navigator.of(context).pop();
            }
          }),
    );
  }
}
