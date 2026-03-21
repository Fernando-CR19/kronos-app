import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Text('name'),
                    Text('username'),
                    Text('email'),
                    Text('password'),
                    Text('celular'),
                    Text('password'),
                    Text('corfim password'),
                    Text('Botaão Criar'),
                    Text('ou'),
                    Text('Já tem uma conta? Faça o Login'),
                  ],
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
