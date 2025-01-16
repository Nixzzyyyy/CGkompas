import 'package:flutter/material.dart';
import 'BlankScreen.dart';

class LoginScreen extends StatefulWidget{
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  bool isRememberMe = false;
  bool isPasswordHidden = true;
  String email = '';
  String emailError = '';
  String password = '';
  String passwordError = '';

  final _emailController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body:Container(
        padding: const EdgeInsets.all(16.0),
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.white, Color(0xFFf4f4f8) ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
             crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(''), 
                  ),
            const SizedBox(height: 20),
            const Text(
              "Log in",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email),
                hintText: 'abc@email.com',
                errorText: emailError.isEmpty ? null : emailError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  email = value;
                  emailError = isValidEmail(email) ? '' : 'Please enter a valid email';
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: isPasswordHidden,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Your password',
                 errorText: passwordError.isEmpty ? null : passwordError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    isPasswordHidden ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                    setState(() {
                      isPasswordHidden = !isPasswordHidden;
                    });
                  }, 
                ),
              ),
               onChanged: (value) {
                setState(() {
                password = value;
                passwordError = password.isEmpty ? 'Password can not be empty' : '';
                });
              },
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Switch(
                      value: isRememberMe, 
                      onChanged: (val){
                        setState(() {
                          isRememberMe = val;
                        });
                      },
                      ),
                    const Text("Remember Me"),
                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/forgotPassword');
                  },
                  child: const Text("Forgot Password?"),
                ),
              ],
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if(password.isEmpty){
                  setState(() {
                    passwordError = 'Password can not be empty';
                  });
                }else if (emailError.isEmpty && passwordError.isEmpty){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const BlankScreen()),
                    );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 0, 119, 255),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)
                ),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 48),
              ),
               child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      "Log in",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                  ),
                    ),
                  ),
                Icon(
                  Icons.arrow_forward,  
                  color: Colors.white,   
                ),
              ],
              ),
            ),
            const SizedBox(height: 40),
            const Text(
              "OR",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                ),
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Padding
              (padding: const EdgeInsets.all(8.0),
               child: Image.asset(
                'assets/images/google.png',
                height: 30,
                width: 30,
              ),
              ),
              label: const Text("Login with Google"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton.icon(
              onPressed: () {},
              icon: Padding
              (padding: const EdgeInsets.all(8.0),
               child: Image.asset(
                'assets/images/facebook.png',
                height: 30,
                width: 30,
              ),
              ),
              label: const Text("Login with Facebook"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.grey),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, '/signup');
              },
              child: const Text("Don't have an account? Sign up"),
               ),
             ],
           ),
         ),
        ),
      ),
    );
  }
}
