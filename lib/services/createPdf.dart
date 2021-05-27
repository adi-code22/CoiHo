import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

class PdfLabPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final pdf = pw.Document();
    pdf.addPage(pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Text('Hello World'),
          );
        }));

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                final bytes = await pdf.save();
                final blob = html.Blob([bytes], 'application/pdf');
                final url = html.Url.createObjectUrlFromBlob(blob);
                html.window.open(url, '_blank');
                html.Url.revokeObjectUrl(url);
              },
              child: Text('Open'),
            ),
            ElevatedButton(
              onPressed: () async {
                final bytes = await pdf.save();
                final blob = html.Blob([bytes], 'application/pdf');
                final url = html.Url.createObjectUrlFromBlob(blob);
                final anchor = html.AnchorElement()
                  ..href = url
                  ..style.display = 'none'
                  ..download = 'some_name.pdf';
                html.document.body?.children.add(anchor);
                anchor.click();
                html.document.body?.children.remove(anchor);
                html.Url.revokeObjectUrl(url);
              },
              child: Text('Download'),
            ),
          ],
        ),
      ),
    );
  }
}
