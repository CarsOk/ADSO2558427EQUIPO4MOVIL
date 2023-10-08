import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {
  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF4E0096),
        title: Text('Domitransp'),
      ),
      body: WebView(
        initialUrl: 'https://fd31-2803-1800-500e-2b97-a325-40da-515c-e6a4.ngrok-free.app',
        javascriptMode: JavascriptMode.unrestricted,
      ),
    );
  }
}
