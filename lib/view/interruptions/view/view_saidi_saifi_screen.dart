import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/app_helper.dart';
import 'package:tsnpdcl_employee/utils/url_constants.dart';
import 'package:tsnpdcl_employee/view/web_view/viewmodel/web_view_screen_viewmodel.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/common_colors.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/global_constants.dart';
import '../../../widget/month_year_selector.dart';

class ViewSaidiSaifiScreen extends StatefulWidget {
  static const id = Routes.viewSaidiSaifiScreen;

  const ViewSaidiSaifiScreen({super.key});

  @override
  State<ViewSaidiSaifiScreen> createState() => _ViewSaidiSaifiScreenState();
}

class _ViewSaidiSaifiScreenState extends State<ViewSaidiSaifiScreen> {
  String? _selectedMonthYear;
  bool _isWebViewLoading = false;
  bool _showWebView = false; // Add this to control WebView visibility

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => WebViewScreenViewModel(webUrl: UrlConstants.viewSaidiUrl),
      child: Consumer<WebViewScreenViewModel>(
        builder: (context, viewmodel, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: CommonColors.colorPrimary,
              title: Text(
                GlobalConstants.saidiSaifiReport.toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Stack(
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text("Select Month",
                              style: TextStyle(fontSize: titleSize)),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 50,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () async {
                                final result = await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                    const MonthYearSelector(),
                                  ),
                                );

                                if (result != null && result is Map) {
                                  setState(() {
                                    _selectedMonthYear =
                                    '${result['month']} ${result['year']}';
                                    _isWebViewLoading = true;
                                    _showWebView = false; // Hide WebView initially
                                  });

                                  // Construct the URL
                                  final url =
                                      'http://210.212.223.83:7000/NpdclEmployeeWebApi/viewSaidiSaifiv2.jsp?'
                                      'token=${SharedPreferenceHelper.getStringValue(LoginSdkPrefs.tokenPrefKey)}&'
                                      'monthYear=$_selectedMonthYear';

                                  // Add navigation delegate to handle page loading
                                  viewmodel.controller.setNavigationDelegate(
                                    NavigationDelegate(
                                      onPageStarted: (url) {
                                        setState(() {
                                          _isWebViewLoading = true;
                                          _showWebView = false;
                                        });
                                      },
                                      onPageFinished: (url) {
                                        setState(() {
                                          _isWebViewLoading = false;
                                          _showWebView = true; // Only show after loading
                                        });
                                      },
                                    ),
                                  );

                                  // Load the URL
                                  await viewmodel.controller.loadRequest(Uri.parse(url));
                                }
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    CommonColors.textFieldColor),
                                shape: WidgetStateProperty.all(
                                  const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                ),
                              ),
                              child: _selectedMonthYear != null
                                  ? Text(
                                _selectedMonthYear!,
                                style: const TextStyle(color: Colors.black),
                              )
                                  : const Text(
                                'TAP HERE',
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (_selectedMonthYear != null)
                      Expanded(
                        child: Stack(
                          children: [
                            if (_showWebView) // Only show WebView when content is ready
                              WebViewWidget(controller: viewmodel.controller),
                            if (_isWebViewLoading || viewmodel.isLoading)
                              const Center(
                                child: CircularProgressIndicator(),
                              ),
                          ],
                        ),
                      ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}