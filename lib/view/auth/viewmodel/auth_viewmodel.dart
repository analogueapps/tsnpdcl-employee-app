import 'package:flutter/material.dart';

class AuthViewmodel extends ChangeNotifier {
  // Current View Context
  final BuildContext context;

  // Controllers for Employee ID and Password
  final TextEditingController empIdController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // State variables
  bool isChecked = false; // For the checkbox
  bool isLoading = false; // For showing progress indicator

  AuthViewmodel({required this.context,});

  // Validation method
  String? validate() {
    if (empIdController.text.length < 5) {
      return "Please enter a valid employee ID";
    } else if (passwordController.text.isEmpty) {
      return "Password cannot be left blank";
    }
    return null;
  }

  // API call simulation
  Future<void> authenticateUser(BuildContext context) async {
    final validationMessage = validate();
    if (validationMessage != null) {
      // Show validation error
      showErrorToast(validationMessage);
      return;
    }

    // Simulate API call
    isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    // Simulating success/failure
    isLoading = false;
    notifyListeners();

    const isSuccess = true; // Change based on API response
    if (isSuccess) {
      showSuccessToast("Success!");
      if(context.mounted) {
        Navigator.pop(context); // Close auth screen
      }
    } else {
      if(context.mounted) {
        showErrorDialog(context, "Unable to authenticate. Try again.");
      }
    }
  }

  // Helper functions for showing UI feedback
  void showErrorToast(String message) {
    // Show a toast message for errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.red),
    );
  }

  void showSuccessToast(String message) {
    // Show a toast message for success
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message), backgroundColor: Colors.green),
    );
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
