import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kronos_app/features/auth/providers/auth_provider.dart';
import 'package:kronos_app/features/auth/screens/reset_password_screen.dart';
import 'package:url_launcher/url_launcher.dart';

class TelegramRecoveryScreen extends ConsumerStatefulWidget {
  const TelegramRecoveryScreen({super.key});

  @override
  ConsumerState<TelegramRecoveryScreen> createState() =>
      _TelegramRecoveryScreenState();
}

class _TelegramRecoveryScreenState
    extends ConsumerState<TelegramRecoveryScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
    super.dispose();
  }

  Future<void> _openTelegram() async {
    final telegramUrl = Uri.parse('https://t.me/kronos_recovery_bot');
    final playStoreUrl = Uri.parse(
      'https://play.google.com/store/apps/details?id=org.telegram.messenger',
    );

    final launched = await launchUrl(
      telegramUrl,
      mode: LaunchMode.externalApplication,
    );

    if (!launched) {
      await launchUrl(playStoreUrl, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _validateOtp() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      final authService = ref.read(authServiceProvider);

      await authService.validateOtp(
        email: _emailController.text,
        code: _codeController.text,
      );

      if (!mounted) return;

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              ResetPasswordScreen(email: _emailController.text),
        ),
      );
    } on DioException catch (err) {
      if (!mounted) return;

      final statusCode = err.response?.statusCode;
      String message;
      if (statusCode == 400) {
        message = err.response?.data['message'] ?? 'Código inválido.';
      } else {
        message = 'Erro ao validar código.';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
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
                    SizedBox(height: MediaQuery.of(context).size.height * 0.10),
                    Text(
                      'RECUPERAR VIA TELEGRAM',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 4,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      '1. Abra o bot do Telegram\n2. Envie seu número de telefone cadastrado\n3. Você receberá um código de 6 dígitos\n4. Preencha seu email e o código abaixo',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Color(0xFF9B9BB5),
                        height: 1.8,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    SizedBox(
                      width: double.infinity,
                      height: 56.h,
                      child: OutlinedButton.icon(
                        onPressed: _openTelegram,
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Color(0xFF2A2A4A)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                        icon: Icon(
                          Icons.telegram,
                          color: Color(0xFF4A90D9),
                        ),
                        label: Text(
                          'Abrir bot do Telegram',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    TextFormField(
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(hintText: 'Email'),
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
                    SizedBox(height: 16.h),
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
                    SizedBox(height: 24.h),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Color(0xFF4A90D9), Color(0xFF7B2FBE)],
                        ).createShader(bounds),
                        child: Text(
                          'Voltar',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
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