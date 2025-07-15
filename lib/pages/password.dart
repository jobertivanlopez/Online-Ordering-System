import 'package:flutter/material.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final TextEditingController currentPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool isObscureCurrent = true;
  bool isObscureNew = true;
  bool isObscureConfirm = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F5F5),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 30),
              _buildPasswordField(
                label: 'Current Password',
                controller: currentPasswordController,
                obscureText: isObscureCurrent,
                toggleVisibility: () {
                  setState(() {
                    isObscureCurrent = !isObscureCurrent;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildPasswordField(
                label: 'New Password',
                controller: newPasswordController,
                obscureText: isObscureNew,
                toggleVisibility: () {
                  setState(() {
                    isObscureNew = !isObscureNew;
                  });
                },
              ),
              const SizedBox(height: 20),
              _buildPasswordField(
                label: 'Confirm Password',
                controller: confirmPasswordController,
                obscureText: isObscureConfirm,
                toggleVisibility: () {
                  setState(() {
                    isObscureConfirm = !isObscureConfirm;
                  });
                },
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF3C95E),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Submit',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required String label,
    required TextEditingController controller,
    required bool obscureText,
    required VoidCallback toggleVisibility,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            obscureText ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: toggleVisibility,
        ),
      ),
    );
  }
}
