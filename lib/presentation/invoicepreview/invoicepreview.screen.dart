import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:loyverspos/infrastructure/navigation/routes.dart';
import 'package:printing/printing.dart';

import 'controllers/invoicepreview.controller.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class InvoicepreviewScreen extends GetView<InvoicepreviewController> {
  // const InvoicepreviewScreen({Key? key}) : super(key: key);

  // final DouserInvoicepreviewController controller =
  //     Get.put(DouserInvoicepreviewController());
  final pw.Document? doc;
  final String? pdfname;

  InvoicepreviewScreen({
    Key? key,
    this.doc,
    this.pdfname,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.offAllNamed(Routes.RECEIPTS),
          icon: Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        title: Text("Invoice"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: InteractiveViewer(
                boundaryMargin: EdgeInsets.all(20.r),
                minScale: 0.5,
                maxScale: 3.5,
                child: PdfPreview(
                  build: (format) => doc!.save(),
                  allowSharing: true,
                  allowPrinting: false,
                  dynamicLayout: false,
                  useActions: true,
                  canChangeOrientation: false,
                  canChangePageFormat: false,
                  canDebug: true,
                  shouldRepaint: true,
                  enableScrollToPage: true,
                  initialPageFormat: PdfPageFormat.a4,
                  pdfFileName: "$pdfname.pdf",
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
