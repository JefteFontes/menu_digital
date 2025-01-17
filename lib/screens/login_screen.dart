import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'register_screen.dart'; 
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: '631618245831-kqpckllqjhegktdl2j0lc4b70iun669u.apps.googleusercontent.com',
  );

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

  //validação da senha
  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira a senha';
    }
    if (value.length < 6) {
      return 'A senha deve ter no mínimo 6 caracteres';
    }
    return null;
  }

  // aqui eu não sei se presta, não roda no meu faz o teste.
  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        final UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: _emailController.text,
                password: _passwordController.text);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login efetuado com sucesso!')),
        );
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.message ?? 'Erro ao realizar login')),
        );
      }
    }
  }

  void _loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        return;
      }

      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login efetuado com sucesso!')),
        );
      }
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.message ?? 'Erro ao realizar login')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: const Color.fromARGB(255, 245, 102, 6),
        centerTitle: true,
        elevation: 0,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          width: 350, // Largura fixa para o container
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
                Icon(Icons.login, color: Colors.orange, size: 64.0),
                SizedBox(height: 8.0),
                Text(
                  'Login',
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
                SizedBox(height: 24.0),
                //botão de entrar
                ElevatedButton(
                  onPressed: _login,
                  child: Text('Entrar'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 245, 102, 6),
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                //botão de entrar com google
                ElevatedButton(
                  onPressed: _loginWithGoogle,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.login, color: Colors.white),
                      SizedBox(width: 8.0),
                      Text('Entrar com Google'),
                    ],
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
                //botão de registro
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => RegisterScreen()),
                    );
                  },
                  child: Text('Não tem uma conta? Registre-se aqui'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
