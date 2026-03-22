import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kronos_app/features/auth/providers/auth_provider.dart';

import 'package:kronos_app/features/auth/screens/login_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('As senhas não coincidem.')));

      return;
    }

    try {
      final authService = ref.read(authServiceProvider);

      await authService.register(
        name: _nameController.text,
        username: _usernameController.text,
        email: _emailController.text,
        password: _passwordController.text,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            'Conta criada com sucesso'
          )
        )
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => LoginScreen()
        ),
      );
    } on DioException catch (err) {
      final message = err.response?.data['message'] ?? 'Erro ao criar a conta';
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(
        SnackBar(
          content: Text(
            message
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: SizedBox(
              width: double.infinity,
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 60),
                        Text(
                          'CADASTRO',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 4,
                          ),
                        ),

                        SizedBox(height: 40),
                        TextFormField(
                          controller: _nameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(hintText: 'Seu nome'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nome é obrigatório';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16),
                        TextFormField(
                          controller: _usernameController,
                          keyboardType: TextInputType.name,
                          decoration: InputDecoration(
                            hintText: 'Nome de usuário',
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Nome de usuário é obrigatório';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16),
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

                        SizedBox(height: 16),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: !_showPassword,
                          decoration: InputDecoration(
                            hintText: 'Senha',
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                () => _showPassword = !_showPassword,
                              ),
                              icon: Icon(
                                _showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xFF9B9BB5),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Senha é obrigatória';
                            }
                            if (value.length < 6) {
                              return 'A senha deve ter no mínimo 6 caracteres';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 16),
                        TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: !_showConfirmPassword,
                          decoration: InputDecoration(
                            hintText: 'Confirmar senha',
                            suffixIcon: IconButton(
                              onPressed: () => setState(
                                () => _showConfirmPassword =
                                    !_showConfirmPassword,
                              ),
                              icon: Icon(
                                _showConfirmPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Color(0xFF9B9BB5),
                              ),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Confirmação de senha é obrigatória';
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 32),
                        Container(
                          width: double.infinity,
                          height: 56,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [Color(0xFF4A90D9), Color(0xFF7B2FBE)],
                            ),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: ElevatedButton(
                            onPressed: _register,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadiusGeometry.circular(16),
                              ),
                            ),
                            child: Text(
                              'Criar conta',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 24),

                        Row(
                          children: [
                            Expanded(child: Divider(color: Color(0xFF2A2A4A))),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'ou',
                                style: TextStyle(
                                  color: Color(0xFF9B9BB5),
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Expanded(child: Divider(color: Color(0xFF2A2A4A))),
                          ],
                        ),

                        SizedBox(height: 24),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Já tem uma conta? ',
                              style: TextStyle(
                                color: Color(0xFF9B9BB5),
                                fontSize: 14,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: ShaderMask(
                                shaderCallback: (bounds) => LinearGradient(
                                  colors: [
                                    Color(0xFF4A90D9),
                                    Color(0xFF7B2FBE),
                                  ],
                                ).createShader(bounds),
                                child: Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
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
