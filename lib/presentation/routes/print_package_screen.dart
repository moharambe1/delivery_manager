// ignore_for_file: unused_import

import 'dart:convert';

import 'package:delivery_manager/models/package_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PringPackagePage extends StatelessWidget {
  const PringPackagePage(
      {super.key, required this.senderPhone, required this.data});
  final PackageModel data;
  final String senderPhone;

  static const cPrimaryColor = PdfColor.fromInt(0xFF22BB9C);

  @override
  Widget build(BuildContext context) {
    _generatePdf(PdfPageFormat.a4, "title");
    Navigator.pop(context);
    return Scaffold(body: Container());
  }

  pw.Widget _printText(String title, String text) {
    return pw.RichText(
        textDirection: pw.TextDirection.rtl,
        text: pw.TextSpan(children: [
          pw.TextSpan(text: title),
          pw.TextSpan(
              text: text, style: const pw.TextStyle(color: cPrimaryColor))
        ]));
  }

  Future<bool> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final img =
        (await rootBundle.load('assets/image/logo.png')).buffer.asUint8List();
    //final font =
    //    pw.Font.ttf(await rootBundle.load("assets/fonts/caire/Cairo.ttf"));
    final font = await PdfGoogleFonts.iBMPlexSansArabicMedium();
    final jsonData = const JsonEncoder().convert({"package": data.toJson()});
    pdf.addPage(
      pw.Page(
        textDirection: pw.TextDirection.rtl,
        theme: pw.ThemeData.withFont(base: font),
        pageFormat: format,
        build: (context) {
          return pw.Container(
              child: pw.Stack(children: [
            pw.Image(pw.MemoryImage(img),
                fit: pw.BoxFit.fill, width: 150, height: 150),
            pw.Container(
                height: 300,
                decoration: pw.BoxDecoration(border: pw.Border.all(width: 2)),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.end,
                  children: [
                    pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.SizedBox(height: 10),
                          _printText(
                              "اسم المرسل: ", data.fullName ?? "............"),
                          pw.SizedBox(height: 10),
                          _printText("رقـم هـاتـف المرسل: ", senderPhone),
                          pw.SizedBox(height: 10),
                          _printText(
                              "مبـلغ الطردع: ", data.moneyPackage.toString()),
                          pw.SizedBox(height: 10),
                          _printText("رسوم التوصيل : ",
                              data.moneyDelivring.toString()),
                          pw.SizedBox(height: 13),
                          pw.SizedBox(width: 170, child: pw.Divider()),
                          pw.SizedBox(height: 10),
                          _printText("اسم المستـلم: ",
                              data.fullName ?? "............"),
                          pw.SizedBox(height: 10),
                          _printText("رقـم الهـاتـف: ", data.phoneNumber),
                          pw.SizedBox(height: 10),
                          _printText("الولايـة: ", data.getWilayaText()),
                          pw.SizedBox(height: 10),
                          _printText("البـلديـة: ", data.getCityText()),
                          pw.SizedBox(height: 10),
                          _printText(
                              "العنـوان: ", data.address ?? "............"),
                        ]),
                    pw.SizedBox(width: 10),
                    pw.SizedBox(height: 300, child: pw.VerticalDivider()),
                    pw.SizedBox(width: 10),
                    pw.Container(
                        height: 290,
                        padding: const pw.EdgeInsets.only(right: 20),
                        alignment: pw.Alignment.center,
                        child: pw.Column(
                            mainAxisAlignment: pw.MainAxisAlignment.center,
                            children: [
                              _printText("رقـم هاتـف الشـركة: ", "0770223465"),
                              pw.SizedBox(height: 5),
                              _printText(
                                  "مواقـع التـواصل الاجتـماعي: ", "MD express"),
                              pw.SizedBox(height: 10),
                              pw.BarcodeWidget(
                                  drawText: true,
                                  data: jsonData,
                                  barcode: pw.Barcode.qrCode(),
                                  decoration: pw.BoxDecoration(
                                      border: pw.Border.all(
                                          width: 2, color: cPrimaryColor)),
                                  width: 160,
                                  height: 160,
                                  padding: const pw.EdgeInsets.all(6)),
                              pw.SizedBox(height: 4),
                              pw.RichText(
                                  textDirection: pw.TextDirection.ltr,
                                  text: pw.TextSpan(children: [
                                    const pw.TextSpan(text: "id: "),
                                    pw.TextSpan(
                                        text: data.id.toString(),
                                        style: const pw.TextStyle(
                                            color: cPrimaryColor))
                                  ]))
                            ])),
                  ],
                ))
          ]));
        },
      ),
    );
    return await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => pdf.save());
    //return pdf.save();
  }
}
