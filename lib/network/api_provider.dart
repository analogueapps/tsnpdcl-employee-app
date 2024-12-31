import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tsnpdcl_employee/network/api_client.dart';
import 'package:tsnpdcl_employee/network/network_utils.dart';
import 'package:tsnpdcl_employee/preference/shared_preference.dart';
import 'package:tsnpdcl_employee/utils/alerts.dart';
import 'package:tsnpdcl_employee/utils/app_constants.dart';
import 'package:tsnpdcl_employee/utils/general_routes.dart';
import 'package:tsnpdcl_employee/utils/navigation_service.dart';

class ApiProvider {
  final ApiClient _apiClient;

  ApiProvider({required String baseUrl}) : _apiClient = ApiClient(baseUrl: baseUrl);

  /// Handles unauthorized errors
  Future<void> _handleUnauthorizedError(
      Response response, BuildContext context) async {
    final errorBody = response.data is Map<String, dynamic>
        ? response.data
        : json.decode(response.data);
    final displayMessage =
        errorBody[resMessage] ?? errorBody[resError] ?? unAuthorizedAccess;

    AlertUtils.showSnackBar(context, displayMessage, isTrue);
    Navigation.instance.pushAndRemoveUntil(Routes.employeeIdLoginScreen);
    SharedPreferenceHelper.clearData();
  }

  /// Handle DioException separately for cleaner error handling
  Future<Response?> handleDioException(
      BuildContext context, DioException e) async {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        AlertUtils.showSnackBar(context, resTimeOutMessage, isTrue);
        break;
      case DioExceptionType.badResponse:
        if (e.response != null) {
          switch (e.response!.statusCode) {
            case unAuthorizedResponseCode:
              await _handleUnauthorizedError(e.response!, context);
              break;
            default:
              // Check if the response contains JSON or plain text/HTML
              if (e.response!.data is Map<String, dynamic>) {
                // Proper JSON response, return it
                return e.response;
              } else {
                // HTML response or plain text, show a toast
                AlertUtils.responseToast(context, e.response!.statusCode!);
              }
          }
        } else {
          AlertUtils.responseToast(context, e.response!.statusCode!);
        }
        break;
      case DioExceptionType.connectionError:
        AlertUtils.showSnackBar(context, resConnectionMessage, isTrue);
        break;
      default:
        AlertUtils.showSnackBar(context, resErrorMessage, isTrue);
        break;
    }
    return null;
  }

  /// POST API Call
  Future<Response?> postApiCall(
    BuildContext context,
    String endpoint,
    Map<String, dynamic>? payload,
  ) async {
    try {
      if (!(await NetworkUtils.isNetworkAvailable())) {
        if (context.mounted) {
          AlertUtils.showSnackBar(context, noInternetMessage, isTrue);
        }
        return null;
      }

      Dio dio = _apiClient.dio;
      var response = await dio.post(
        endpoint,
        data: payload,
      );
      return response;
    } on DioException catch (e) {
      if (context.mounted) {
        return await handleDioException(context, e);
      }
    } catch (e) {
      if (context.mounted) {
        AlertUtils.showSnackBar(context, resSomethingMessage, isTrue);
      }
    }
    return null;
  }
}
