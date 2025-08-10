import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfViewer extends StatefulWidget {
  final String pdfPath;

  const PdfViewer({super.key, required this.pdfPath});

  @override
  // ignore: library_private_types_in_public_api
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  int _currentPage = 0;
  late PDFViewController _pdfController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PDFView(
            filePath: widget.pdfPath,
            autoSpacing: false,
            pageSnap: false,
            fitPolicy: FitPolicy.WIDTH,
            // ignore: no_leading_underscores_for_local_identifiers
            onRender: (_pages) {
              setState(() {});
            },
            onViewCreated: (PDFViewController vc) {
              _pdfController = vc;
            },
            onPageChanged: (int? page, int? total) {
              setState(() {
                _currentPage = page ?? 0;
              });
            },
          ),
          Positioned(
            bottom: 10,
            left: 10,
            child: FloatingActionButton(
              onPressed: () async {
                int newPage = (_currentPage - 1).clamp(0, 100);
                await _pdfController.setPage(newPage);
                setState(() => _currentPage = newPage);
              },
              child: Icon(Icons.arrow_back),
            ),
          ),
          Positioned(
            bottom: 10,
            right: 10,
            child: FloatingActionButton(
              onPressed: () async {
                int newPage = (_currentPage + 1).clamp(0, 100);
                await _pdfController.setPage(newPage);
                setState(() => _currentPage = newPage);
              },
              child: Icon(Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}
