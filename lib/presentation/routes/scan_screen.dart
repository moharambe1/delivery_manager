import 'dart:convert';
import 'dart:developer';
import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  String? resText;
  final controller = TextEditingController(text: "");
  // final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
/*  Barcode? result;
  String? resText;
  QRViewController? controller;*/

  // In order to get hot reload to work we need to pause the camera if the platform
  // is android, or resume the camera if the platform is iOS.
  /*
  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }
*/
  @override
  Widget build(BuildContext context) {
    /*return Scaffold(
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                      'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}')
                  : const Text('Scan a code'),
            ),
          )
        ],
      ),
    );*/
    /*FlutterBarcodeScanner.scanBarcode(
            Colors.red.toString(), "رجوع", false, ScanMode.QR)
        .then(
      (value) => resText = value,
    );*/
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        MobileScanner(
            allowDuplicates: false,
            controller: MobileScannerController(
                torchEnabled: false, formats: [BarcodeFormat.qrCode]),
            onDetect: (barcode, args) {
              if (barcode.rawValue == null) {
                debugPrint('Failed to scan Barcode');
              } else {
                try {
                  final String code = barcode.rawValue!;

                  final id = jsonDecode(jsonDecode(code)['package'])['id'];

                  if (id != null) {
                    Navigator.popAndPushNamed(context, '/details',
                        arguments: id);
                  }
                } catch (e) {
                  log(e.toString());
                }
              }
            }),
        SizedBox(
          width: 99.9.w,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                  controller: controller,
                  showCursor: true,
                  enabled: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    label: Text("رقـم الطرد :",
                        style: Theme.of(context).textTheme.headline4),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8)),
                    filled: true,
                    fillColor: Theme.of(context).colorScheme.background,
                  )),
              Container(
                width: 88.w,
                padding: EdgeInsets.only(top: 2.h, bottom: 2.h),
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(),
                    onPressed: () {
                      final id = int.tryParse(controller.text);
                      if (id != null) {
                        Navigator.popAndPushNamed(context, '/details',
                            arguments: id);
                      }
                    },
                    child: Center(
                        child: Text(
                      "عرض",
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .copyWith(color: Colors.white),
                    ))),
              ),
            ],
          ),
        )
      ],
    )));
  }
/*
  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      try {
        if (scanData.code != null) {
          final tMap = jsonDecode(scanData.code!);
          final id = int.tryParse(tMap['id']);
          if (id != null) {
            Navigator.popAndPushNamed(context, "/details", arguments: id);
          }
        }

        setState(() {
          result = scanData;
        });
      } catch (e) {}
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }*/
}
