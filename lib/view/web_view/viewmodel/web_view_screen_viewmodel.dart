import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewScreenViewModel extends ChangeNotifier {
  final String webUrl;
  late WebViewController _controller;
  bool isLoading = true;

  WebViewController get controller => _controller;

  WebViewScreenViewModel({required this.webUrl}) {
    initializeController();
  }

  void onPageStarted(String url) {
    isLoading = true;  // Set loading to true when the page starts.
    notifyListeners();
  }

  void onPageFinished(String url) {
    isLoading = false;  // Set loading to false when the page finishes.
    notifyListeners();
  }

  void initializeController() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)  // Allow JavaScript execution.
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // You can add logic to show progress based on loading.
            print("Loading progress: $progress%");
          },
          onPageStarted: (String url) {
            onPageStarted(url);  // Show loading indicator when the page starts.
          },
          onPageFinished: (String url) {
            onPageFinished(url);  // Hide loading indicator when the page finishes.
          },
          onHttpError: (HttpResponseError error) {
            print("HTTP Error: ${error.response}");  // Handle HTTP errors.
          },
          onWebResourceError: (WebResourceError error) {
            print("WebResourceError: ${error.description}");  // Handle resource errors.
          },
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://')) {
              return NavigationDecision.navigate;  // Allow navigation.
            }
            return NavigationDecision.prevent;  // Prevent navigation for non-https URLs.
          },
        ),
      )
      ..loadRequest(Uri.parse(webUrl));  // Load the provided URL.
  }
}