import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kronos_app/features/auth/providers/auth_provider.dart';

import 'package:kronos_app/features/auth/screens/validate_otp_screen.dart';
import 'package:kronos_app/features/auth/screens/telegram_recovery_screen.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _forgotPassword() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final authSerice = ref.read(authServiceProvider);

      await authSerice.forgotPassword(email: _emailController.text);

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ValidateOtpScreen(email: _emailController.text),
        ),
      );
    } on DioException catch (err) {
      if (!mounted) return;

      final message = err.response?.data['message'] ?? 'Erro ao enviar código';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
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
                      'RECUPERAR SENHA',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Digite seu email para receber o código',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFF9B9BB5),
                      ),
                    ),
                    SizedBox(height: 40.h),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: "Email"),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email é obrigatório';
                        }
                        if (!value.contains('@') || !value.contains('.')) {
                          return 'Email inválido';
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
                        onPressed: _forgotPassword,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(16.r),
                          ),
                        ),
                        child: Text(
                          'Enviar Código',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TelegramRecoveryScreen(),
                          ),
                        );
                      },
                      child: Text(
                        'Recuperar via Telegram? Clique aqui',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF9B9BB5),
                          fontSize: 13.sp,
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Lembrou a senha? ',
                          style: TextStyle(
                            color: Color(0xFF9B9BB5),
                            fontSize: 14.sp,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: ShaderMask(
                            shaderCallback: (bounds) => LinearGradient(
                              colors: [Color(0xFF4A90D9), Color(0xFF7B2FBE)],
                            ).createShader(bounds),
                            child: Text(
                              'Voltar ao login',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
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
