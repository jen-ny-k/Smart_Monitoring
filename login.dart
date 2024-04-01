import 'package:flutter/material.dart';
import 'signup.dart'; // Import the SignUpPage
import 'auth.dart'; // Import the AuthService
import 'device.dart'; // Import the DevicePage
import 'package:firebase_auth/firebase_auth.dart'
    as FirebaseAuth; // Add this line

// Define the User class here
class User {
  final String username;
  final String email;
  final String password;

  User(this.username, this.email, this.password);
}

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Intelli-farm Login',
      theme: ThemeData(
        primaryColor: Colors.green.shade700,
        appBarTheme: AppBarTheme(
          color: Colors.green.shade800,
        ),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.green.shade200,
          ),
          subtitle1: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('Intelli-farm'),
        ),
        body: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void _signIn(BuildContext context) async {
    String usernameOrEmail = _usernameController.text;
    String password = _passwordController.text;

    try {
      // Call the signInWithEmailAndPassword function from AuthService
      FirebaseAuth.User? user = await AuthService()
          .signInWithEmailAndPassword(usernameOrEmail, password);
      if (user != null) {
        // Navigate to DevicePage if login is successful
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DevicesPage()),
        );
      } else {
        // Navigate to SignUpPage if user does not have an account
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignupPage()),
        );
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      color: Colors.green.shade700,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.agriculture,
            size: 200,
            color: Colors.orange,
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20.0),
          TextField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              _signIn(context);
            },
            child: Text('Log In'),
          ),
        ],
      ),
    );
  }
}
