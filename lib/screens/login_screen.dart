import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 20,right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Center(
              child: Text(
                'Instagram',
                style: TextStyle(
                    fontSize: 45,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Satisfy'),
              ),
            ),
            const SizedBox(height: 40),
            TextFormField(
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                hintText: 'Phone number, email or username',
                enabledBorder: OutlineInputBorder(),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              onChanged: (_){},
              obscureText: true,
              decoration: const InputDecoration(
                filled: true,
                fillColor: Colors.black12,
                hintText: 'Password',
                enabledBorder: OutlineInputBorder(),
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.only(left: 10),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              onPressed: () {},
              child: const Text(
                'Log in',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                      text: 'Forget your login details?  ',
                      style: TextStyle(color: Colors.black,fontSize: 20),
                    ),
                    TextSpan(
                      text: 'get help loggin in.',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold,fontSize: 20),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {},
                    )
                  ],
                ),
              ),
            ),
            Row(
              children: [
                const Expanded(
                  child: Divider(height: 70, thickness: 3),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  child: const Text(
                    'OR',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const Expanded(
                  child: Divider(height: 70, thickness: 3),
                ),
              ],
            ),
            Center(
              child: RichText(
                text: TextSpan(
                  text: 'Log in with Facebook',
                  style: const TextStyle(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () {},
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    const TextSpan(
                        text: 'Don\'t have an account?  ',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                      text: 'Sign up.',
                      style: const TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) {
                                return const SignupScreen();
                              },
                            ),
                          );
                        },
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


