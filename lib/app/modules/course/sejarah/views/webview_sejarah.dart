import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SejarahWebView extends StatelessWidget {
  final String url; // URL yang akan ditampilkan di WebView

  const SejarahWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sejerah Indonesia"),
      ),
      body: WebView(
        initialUrl:
            'https://id.wikipedia.org/wiki/Sejarah_Indonesia', // Memuat URL resep
        javascriptMode: JavascriptMode.unrestricted, // Mengizinkan Javascript
      ),
    );
  }
}
