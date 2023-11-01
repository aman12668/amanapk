import 'dart:io';

import 'package:ENEB_HUB/core/Controllers/Models/book_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class PdfView extends StatefulWidget {
  PdfView({Key? key, required this.chapter}) : super(key: key);

  final Chapter chapter;

  @override
  State<PdfView> createState() => _PdfViewState();
}

class _PdfViewState extends State<PdfView> {
  PDFViewController? controller;
  int pages = 0;
  int indexPage = 0;

  File? pdfFile;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadPdf();
  }

  @override
  void dispose() {
    // Perform cleanup tasks, such as deleting the file
    deleteFile();

    // Call the super dispose method
    super.dispose();
  }

  // Method to delete the file
  Future<void> deleteFile() async {
    if (pdfFile != null && pdfFile!.existsSync()) {
      try {
        await pdfFile!.delete();
      } catch (e) {
        throw Exception('File couldn\'t Delete');
      }
    }
  }

  Future<void> loadPdf() async {
    try {
      final result = await PDFApi.loadNetwork(widget.chapter.pdf);
      setState(() {
        pdfFile = result;
        loading = false;
      });
    } catch (error) {
      // Handle the error, e.g., show an error message to the user.
      print('Error loading PDF: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    final pageCount = '${indexPage + 1} of $pages';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.chapter.title),
      ),
      body: pdfFile != null && pdfFile!.path.isNotEmpty
          ? PDFView(
              filePath: pdfFile!.path,
              autoSpacing: false,
              swipeHorizontal: false,
              pageSnap: true,
              pageFling: false,
              onRender: (renderedPages) {
                setState(() {
                  pages = renderedPages!;
                });
              },
              onViewCreated: (pdfController) {
                setState(() {
                  controller = pdfController;
                });
              },
              onPageChanged: (pageIndex, _) {
                setState(() {
                  indexPage = pageIndex!;
                });
              },
            )
          : Center(
              child: loading
                  ? const CircularProgressIndicator.adaptive()
                  : const Text('PDF Not found!'),
            ),
      floatingActionButton: buildFAB(pageCount),
    );
  }

  Widget buildFAB(String pageCount) {
    return pdfFile != null && pdfFile!.path.isNotEmpty
        ? Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.black45,
              borderRadius: BorderRadius.circular(25),
            ),
            constraints: const BoxConstraints(minWidth: 150),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              runAlignment: WrapAlignment.center,
              children: [
                Text(
                  pageCount,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    final page = indexPage == 0 ? pages : indexPage - 1;
                    controller?.setPage(page);
                  },
                ),
                IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    size: 24,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    final page = indexPage == pages - 1 ? 0 : indexPage + 1;
                    controller?.setPage(page);
                  },
                ),
              ],
            ),
          )
        : Container();
  }

  void navigateToPage(int page) {
    controller?.setPage(page);
  }
}

class PDFApi {
  static Future<File> loadNetwork(String url) async {
    final response = await http.get(Uri.parse(url));
    final bytes = response.bodyBytes;
    return _storeFile(url, bytes);
  }

  static Future<File> _storeFile(String url, List<int> bytes) async {
    final filename = basename(url);
    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$filename');
    await file.writeAsBytes(bytes, flush: true);
    return file;
  }
}
