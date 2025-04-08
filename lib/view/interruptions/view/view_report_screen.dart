import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import 'package:tsnpdcl_employee/utils/url_constants.dart';
import 'package:tsnpdcl_employee/view/web_view/viewmodel/web_view_screen_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewReportScreen extends StatefulWidget {
  static const id = Routes.viewReportScreen;
  static const String viewReportUrl = UrlConstants.viewReportUrl;
  const ViewReportScreen({super.key});

  @override
  State<ViewReportScreen> createState() => _ViewReportScreenState();
}

class _ViewReportScreenState extends State<ViewReportScreen> {
  bool _isLoading = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<WebViewScreenViewModel>(
      create: (_) => WebViewScreenViewModel(webUrl: ViewReportScreen.viewReportUrl),
      child: Consumer<WebViewScreenViewModel>(
        builder: (context, viewModel, _) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.interruptions.toUpperCase(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w500),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Stack(
              children: [
                WebViewWidget(
                  controller: viewModel.controller,
                ),
                if (_isLoading)
                  const Center(child: CircularProgressIndicator()),
              ],
            ),
          );
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    // Add a small delay to ensure the WebView is initialized
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    });
  }
}
