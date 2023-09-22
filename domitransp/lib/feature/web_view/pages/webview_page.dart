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
    // Habilita JavaScript en el WebView (opcional, según tus necesidades)
    WebView.platform = SurfaceAndroidWebView(); // Si estás en Android
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Domitransp'),
      ),
      body: WebView(
        initialUrl: 'https://156b-186-82-87-153.ngrok-free.app/', // URL de la página web a cargar
        javascriptMode: JavascriptMode.unrestricted, // Habilita JavaScript (opcional)
      ),
    );
  }
}
