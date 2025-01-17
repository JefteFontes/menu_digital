import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  //validação do e-mail
  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira o e-mail';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Por favor, insira um e-mail válido';
    }
    return null;
  }


  //validação para a senha
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }
    return null;
  }

  //confirmar a senha
  String? _validateConfirmPassword(String? value) {
    if (value != _passwordController.text) {
      return 'As senhas não coincidem';
    }
    return null;
  }

  void _register() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registro efetuado com sucesso!')),
        );

        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Erro ao realizar o registro')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Registro'),
        backgroundColor: const Color.fromARGB(255, 245, 102, 6),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 350,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_add, color: Colors.orange, size: 64.0),
                SizedBox(height: 8.0),
                Text(
                  'Registro',
                  style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                  ),
                ),
                SizedBox(height: 24.0),
                //email
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: 'E-mail',
                    labelStyle: TextStyle(color: Colors.orange),
                    prefixIcon: Icon(Icons.email, color: Colors.orange),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: _validateEmail,
                ),
                SizedBox(height: 16.0),
                //senha
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    labelStyle: TextStyle(color: Colors.orange),
                    prefixIcon: Icon(Icons.lock, color: Colors.orange),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: _validatePassword,
                ),
                SizedBox(height: 16.0),
                //confirmar senha
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirmar Senha',
                    labelStyle: TextStyle(color: Colors.orange),
                    prefixIcon: Icon(Icons.lock, color: Colors.orange),
                    filled: true,
                    fillColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.orange),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                  validator: _validateConfirmPassword,
                ),
                SizedBox(height: 24.0),
                //botão de registro
                ElevatedButton(
                  onPressed: _register,
                  child: Text('Registrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 102, 6),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
