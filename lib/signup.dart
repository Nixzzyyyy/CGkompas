import 'package:flutter/material.dart';
import 'interestsScreen.dart';


class SignUpScreen extends StatefulWidget{
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  
  bool isPasswordHidden = true;
  bool isPassword2Hidden = true;
  String email = '';
  String emailError = '';
  String password= '';
  String confirmPassword = '';
  String passwordError = '';
  String name = '';
  String nameError = '';

  final _emailController = TextEditingController();

  bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  void validatePasswords() {
    if (password != confirmPassword){
      setState(() {
        passwordError = 'Passwords do not match';
      });
    } else {
      setState(() {
        passwordError = '';
      });
    }
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
            const SizedBox(height: 30),
            const Text(
              "Sign up",
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person),
                hintText: 'Full name',
                errorText: nameError.isEmpty ? null : nameError,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onChanged: (value) {
                setState(() {
                   name = value;
                nameError = name.isEmpty ? 'Name can not be empty' : '';
                });
              },
            ),
            const SizedBox(height: 16),
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
              obscureText: isPassword2Hidden,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Your password',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                 suffixIcon: IconButton(
                  icon: Icon(
                    isPassword2Hidden ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: () {
                    setState(() {
                      isPassword2Hidden = !isPassword2Hidden;
                    });
                  }, 
                ),
              ),
              onChanged: (value) {
                setState(() {
                  password = value;
                });
              },
            ),
            const SizedBox(height: 16),
            TextField(
              obscureText: isPasswordHidden,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock),
                hintText: 'Confirm password',
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
                  confirmPassword = value;
                });
                validatePasswords();
              },
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                if(name.isEmpty){
                  setState(() {
                    nameError = 'Name can not be empty';
                  });
                }else if (emailError.isEmpty && passwordError.isEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && name.isNotEmpty){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const InterestsScreen()),
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
                      "Sign up",
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
                Navigator.pushNamed(context, '/login');
              },
              child: const Text("Already have an account? Log in"),
                 ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
