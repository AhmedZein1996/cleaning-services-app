import 'package:clean_services_app/screens/Home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class PaymentWebView extends StatefulWidget {
  static const String routeName = 'payment-webView';

  const PaymentWebView({Key? key}) : super(key: key);

  @override
  State<PaymentWebView> createState() => _PaymentWebViewState();
}

class _PaymentWebViewState extends State<PaymentWebView> {
  @override
  Widget build(BuildContext context) {
    final Map<String, String> data =
        ModalRoute.of(context)!.settings.arguments as Map<String, String>;
    String? url = data['url'];
    String? pageNamed = data['pageNamed'];
    WebViewController controller;
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
            },
          ),
          title: Text(pageNamed! == "STRIPE" ? "Pay with card" : "Paypal"),
        ),
        body: WebView(
          onWebViewCreated: (WebViewController c) {
            controller = c;
          },
          initialUrl: url,
          zoomEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
