import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFView extends StatefulWidget
{
  final prescriptionUrl;
  const PDFView({super.key, required this.prescriptionUrl});

  @override
  State<PDFView> createState() => _PDFViewState();
}

class _PDFViewState extends State<PDFView>
{
  PdfViewerController? _pdfViewerController;

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Viewer"),
      ),
      body: SfPdfViewer.network(widget.prescriptionUrl),
    );
  }
}
