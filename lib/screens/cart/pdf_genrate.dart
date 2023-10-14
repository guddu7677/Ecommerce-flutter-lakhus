import 'dart:io';

import 'package:ecommerce_app/widget/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/get_cart_model.dart';
import '../../service/cart_provider.dart';

class PdfPreviewPage extends StatefulWidget {
  List<GetCartModel> pdfData = [];
  double total;

  PdfPreviewPage({Key? key, required this.pdfData, required this.total})
      : super(key: key);

  @override
  State<PdfPreviewPage> createState() => _PdfPreviewPageState();
}

class _PdfPreviewPageState extends State<PdfPreviewPage> {
  void shareOnWhatsApp(BuildContext) async {
    final pdf = await makePdf();

    // Get the app's temporary directory path
    final outputDir = await getTemporaryDirectory();

    // Generate the PDF file path
    final pdfPath = '${outputDir.path}/example.pdf';

    // Save the PDF bytes to a file
    final file = File(pdfPath);
    await file.writeAsBytes(pdf);

    // Share the PDF file via WhatsApp
    await FlutterShare.shareFile(
      title: 'Share PDF',
      text: 'Please find the attached PDF.',
      filePath: pdfPath,
      // mimeType: 'application/pdf',
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // shareOnWhatsApp(context);
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Order'),
      ),
      body: PdfPreview(
        pdfFileName: "order.pdf",
        allowSharing: true,
        // onShared: shareOnWhatsApp,
        allowPrinting: true,
        build: (context) => makePdf(),
      ),
    );
  }

  Future<Uint8List> makePdf() async {
    final pdf = pw.Document();
    final ByteData bytes = await rootBundle.load('assets/e1.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(pw.Page(
        margin: const pw.EdgeInsets.all(10),
        pageFormat: PdfPageFormat.a4,
        build: (context) {
          return pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Header(
                    level: 1,
                    child: pw.Column(
                        crossAxisAlignment: pw.CrossAxisAlignment.start,
                        children: [
                          pw.SizedBox(width: 40),
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Row(children: [
                                  pw.Text("Order Id: ",
                                      style: const pw.TextStyle(
                                        fontSize: 15,
                                      )),
                                  pw.Text("2521454415544",
                                      style: const pw.TextStyle(
                                        fontSize: 15,
                                      )),
                                ]),
                                pw.Text("Order Details",
                                    style: const pw.TextStyle(
                                      fontSize: 28,
                                    )),
                                pw.Row(children: [
                                  pw.Text("Date: ",
                                      style: const pw.TextStyle(
                                        fontSize: 15,
                                      )),
                                  pw.Text("21/05/2021",
                                      style: const pw.TextStyle(
                                        fontSize: 15,
                                      )),
                                ]),
                              ]),
                          pw.SizedBox(
                            height: 10.0,
                          ),
                          pw.Padding(
                            padding:
                                const pw.EdgeInsets.symmetric(horizontal: 10),
                            child: pw.Row(
                                mainAxisAlignment:
                                    pw.MainAxisAlignment.spaceBetween,
                                children: [
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.start,
                                      children: [
                                        pw.Row(children: [
                                          pw.Text("User Details",
                                              style: const pw.TextStyle(
                                                fontSize: 24,
                                              )),
                                        ]),
                                        pw.SizedBox(
                                          height: 6.0,
                                        ),
                                        pw.Row(children: [
                                          pw.Text("Name: ",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                          pw.Text("Sushil",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                        ]),
                                        pw.SizedBox(
                                          height: 6.0,
                                        ),
                                        pw.Row(children: [
                                          pw.Text("Phone No: ",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                          pw.Text("9447858445",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                        ]),
                                        pw.SizedBox(
                                          height: 6.0,
                                        ),
                                        pw.Row(children: [
                                          pw.Text("Address: ",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                          pw.Text(
                                              "new delhi lajapt nagar - 110043",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                        ]),
                                      ]),
                                  pw.Column(
                                      crossAxisAlignment:
                                          pw.CrossAxisAlignment.end,
                                      children: [
                                        pw.Text("Company Details",
                                            style: const pw.TextStyle(
                                              fontSize: 24,
                                            )),
                                        pw.SizedBox(height: 6.0),
                                        pw.Row(children: [
                                          pw.Text("Company Name: ",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                          pw.Text("Lekhus",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                        ]),
                                        pw.SizedBox(
                                          height: 6.0,
                                        ),
                                        pw.Row(children: [
                                          pw.Text("Phone No: ",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                          pw.Text("9447858445",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                        ]),
                                        pw.SizedBox(
                                          height: 6.0,
                                        ),
                                        pw.Row(children: [
                                          pw.Text("GST No: ",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                          pw.Text("2521454415544",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                        ]),
                                        pw.SizedBox(
                                          height: 6.0,
                                        ),
                                        pw.Row(children: [
                                          pw.Text("Email: ",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                          pw.Text("lekhus@gmail.com",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                        ]),
                                        pw.SizedBox(
                                          height: 6.0,
                                        ),
                                        pw.Row(children: [
                                          pw.Text("Address: ",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                          pw.Text("New Delhi , delhi -110043",
                                              style: const pw.TextStyle(
                                                fontSize: 15,
                                              )),
                                        ]),
                                        pw.SizedBox(
                                          height: 6.0,
                                        ),
                                      ])
                                ]),
                          ),
                          pw.SizedBox(height: 10.0),
                        ])),
                pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 18),
                  child: pw.Text("Product details",
                      style: const pw.TextStyle(fontSize: 20)),
                ),
                pw.SizedBox(
                  height: 15.0,
                ),
                pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                    children: [
                      pw.ListView.builder(
                          itemBuilder: (context, index) {
                            return pw.Padding(
                                padding: const pw.EdgeInsets.symmetric(
                                    horizontal: 18),
                                child: pw.Row(
                                    mainAxisAlignment:
                                        pw.MainAxisAlignment.spaceBetween,
                                    children: [
                                      pw.Row(children: [
                                        pw.Text("${index + 1}"),
                                        pw.Container(
                                            width: 76,
                                            height: 89,
                                            padding:
                                                const pw.EdgeInsets.all(10),
                                            decoration: pw.BoxDecoration(
                                                borderRadius:
                                                    pw.BorderRadius.circular(
                                                        12)),
                                            child: pw.Image(
                                                pw.MemoryImage(byteList),
                                                fit: pw.BoxFit.cover)),
                                        pw.Column(
                                            crossAxisAlignment:
                                                pw.CrossAxisAlignment.start,
                                            children: [
                                              pw.Text(
                                                  widget.pdfData[index]
                                                      .productTitle
                                                      .toString(),
                                                  style: const pw.TextStyle(
                                                      fontSize: 16)),
                                              pw.SizedBox(
                                                height: 10.0,
                                              ),
                                              pw.Row(children: [
                                                pw.Row(children: [
                                                  pw.Text("Size: ",
                                                      style: const pw.TextStyle(
                                                          fontSize: 16)),
                                                  pw.Text(
                                                      widget.pdfData[index]
                                                          .productSize
                                                          .toString(),
                                                      style: const pw.TextStyle(
                                                          fontSize: 16)),
                                                ]),
                                                pw.SizedBox(
                                                  width: 40,
                                                ),
                                                pw.Row(children: [
                                                  pw.Row(children: [
                                                    pw.Text("Color: ",
                                                        style:
                                                            const pw.TextStyle(
                                                                fontSize: 16)),
                                                    pw.Text(
                                                        widget.pdfData[index]
                                                            .productColor
                                                            .toString(),
                                                        style:
                                                            const pw.TextStyle(
                                                                fontSize: 16)),
                                                  ]),
                                                  pw.SizedBox(
                                                    width: 5.0,
                                                  ),
                                                  pw.Container(
                                                      width: 20,
                                                      height: 20,
                                                      decoration:
                                                          pw.BoxDecoration(
                                                              color: PdfColor
                                                                  .fromHex(
                                                                      "#FFFFFF"),
                                                              borderRadius:
                                                                  pw.BorderRadius
                                                                      .circular(
                                                                          4)))
                                                ])
                                              ])
                                            ]),
                                      ]),
                                      pw.Column(
                                          crossAxisAlignment:
                                              pw.CrossAxisAlignment.end,
                                          children: [
                                            pw.Text(
                                                "${widget.pdfData[index].product.toString()} Set-No. of Piece",
                                                style: const pw.TextStyle(
                                                    fontSize: 16)),
                                            pw.Text(
                                                "${widget.pdfData[index].product} Qty",
                                                style: const pw.TextStyle(
                                                    fontSize: 16)),
                                            pw.Row(children: [
                                              pw.Text("Amount: ",
                                                  style: const pw.TextStyle(
                                                      fontSize: 16)),
                                              pw.Text(
                                                  widget.pdfData[index]
                                                      .productPrice
                                                      .toString(),
                                                  style: const pw.TextStyle(
                                                      fontSize: 16))
                                            ])
                                          ])
                                    ]));
                          },
                          itemCount: widget.pdfData.length)
                    ]),
                pw.Divider(borderStyle: pw.BorderStyle.dashed),
                pw.SizedBox(height: 5.0),
              ]);
        }));
    final ByteData bytesss = await rootBundle.load('assets/sign.jpg');

    final Uint8List byteLisst = bytesss.buffer.asUint8List();
    pdf.addPage(
      pw.Page(
        build: (context) => pw.Center(
            child: pw.Row(
                mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                children: [
              pw.Padding(
                  padding: const pw.EdgeInsets.symmetric(horizontal: 10),
                  child: pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.end,
                      children: [
                        pw.Row(children: [
                          pw.Row(
                              mainAxisAlignment:
                                  pw.MainAxisAlignment.spaceBetween,
                              children: [
                                pw.Column(children: [
                                  pw.Text(
                                      "Order on Lekhus For New and Unique Products.\ndgwd wdhfgwd dwqhfd "),
                                ]),
                                pw.SizedBox(
                                  width: 45,
                                ),
                                pw.Text("SubTotal: ",
                                    style: const pw.TextStyle(fontSize: 14)),
                              ]),
                          pw.Text("1950.00",
                              style: const pw.TextStyle(fontSize: 14)),
                        ]),
                        pw.SizedBox(
                          height: 2.0,
                        ),
                        pw.Row(children: [
                          pw.Text("GST: ",
                              style: const pw.TextStyle(fontSize: 14)),
                          pw.Text("49.00",
                              style: const pw.TextStyle(fontSize: 14)),
                        ]),
                        pw.SizedBox(
                          height: 2.0,
                        ),
                        pw.Row(children: [
                          pw.Text("Total: ",
                              style: const pw.TextStyle(fontSize: 22)),
                          pw.Text("${widget.total.toString()}",
                              style: const pw.TextStyle(fontSize: 20)),
                        ])
                      ])),
            ])),
      ),
    );

    return pdf.save();
  }
}
