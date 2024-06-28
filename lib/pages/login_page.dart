import 'package:facultad/providers/user_provider.dart';
import 'package:facultad/service/auth_service.dart';
import 'package:facultad/utils/navigation.dart';
import 'package:facultad/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthService _authService = AuthService();
  String? _errorMessage;

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    final user = await _authService.login(username, password);

    // navigateToHome(context);

    if (user != null) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.setUser(user);
      // await userProvider.saveUserToPreferences();
      navigateToHome(context);
    } else {
      setState(() {
        _errorMessage = 'Credenciales incorrectos';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(),
      body: Column(
        children: [
          Image.asset(
            'lib/images/sierra.png',
            width: 250.0, // Set image width
            height: 200.0, // Set image height
            // fit: BoxFit.cover, // Control image scaling
          ),
          CustomTextField(
              controllerEdit: _usernameController, labelText: 'Usuario'),
          CustomTextField(
            controllerEdit: _passwordController,
            labelText: 'Password',
            oscureText: true,
          ),
          if (_errorMessage != null)
            Text(
              _errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(onPressed: _login, child: const Text('Login'))
        ],
      ),
    );
  }
}
