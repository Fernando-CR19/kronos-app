import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kronos_app/features/auth/providers/auth_provider.dart';

import 'package:kronos_app/features/auth/screens/reset_password_screen.dart';

class ValidateOtpScreen extends ConsumerStatefulWidget {
  final String email;
  const ValidateOtpScreen({super.key, required this.email});

  @override
  ConsumerState<ValidateOtpScreen> createState() => _ValidateOtpScreenState();
}

class _ValidateOtpScreenState extends ConsumerState<ValidateOtpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _validateOtp() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final authService = ref.read(authServiceProvider);

      await authService.validateOtp(
        email: widget.email, code: _codeController.text,
      );

      if(!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResetPasswordScreen(email: widget.email)
        ),
      );

    } on DioException catch (err) {
      if (!mounted) return;

      final statusCode = err.response?.statusCode;

      String message;
      if (statusCode == 400) {
        message = err.response?.data['message'] ?? 'Código inválido';
      } else {
        message = 'Erro ao validar código';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.30),
                    Text(
                      'VERIFICAR CÓDIGO',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Digite o código enviado para ${widget.email}',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 14.sp, color: Color(0xFF9B9BB5)),
                    ),
                    SizedBox(height: 40.h),
                    TextFormField(
                      controller: _codeController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Código de 6 dígitos',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Código é obrigatório';
                        }
                        if (value.length != 6) {
                          return 'O código deve ter 6 dígitos';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 32.h),
                    Container(
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [Color(0xFF4A90D9), Color(0xFF7B2FBE)],
                        ),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: ElevatedButton(
                        onPressed: _validateOtp,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16.r),
                          ),
                        ),
                        child: Text(
                          'Verificar código',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
