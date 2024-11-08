import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class BahasaWebView extends StatelessWidget {
  final String url; // URL yang akan ditampilkan di WebView

  const BahasaWebView({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bahasa Indonesia"),
      ),
      body: WebView(
        initialUrl:
            'https://id.wikipedia.org/wiki/Bahasa_Indonesia', // Memuat URL resep
        javascriptMode: JavascriptMode.unrestricted, // Mengizinkan Javascript
      ),
    );
  }
}
