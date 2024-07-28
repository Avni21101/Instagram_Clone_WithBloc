import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone/blocs/login-cubit/login_cubit.dart';
import 'package:instagram_clone/repository/authentication_repository/authentication_repository.dart';
import 'package:instagram_clone/screens/home_page.dart';
import 'package:instagram_clone/screens/signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(AuthenticationRepository()),
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: BlocListener<LoginCubit, LoginState>(
            listenWhen: (previous, current) => previous.status != current.status,
            listener: (context, state) {
               if (state.status.isFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar
                  ..showSnackBar(
                    SnackBar(
                      content:
                      Text(state.errorMessage ?? 'Authentication failed'),
                    ),
                  );
              }
            },
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
                const EmailTextField(),
                const SizedBox(height: 10),
                const PasswordTextField(),
                const SizedBox(height: 20),
                const LoginButton(),
                const SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      children: [
                        const TextSpan(
                          text: 'Forget your login details?  ',
                          style: TextStyle(color: Colors.black),
                        ),
                        TextSpan(
                          text: 'get help loggin in.',
                          style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
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
        ),
      ),
    );
  }
}

class EmailTextField extends StatelessWidget {
  const EmailTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          onChanged:(value) => context.read<LoginCubit>().emailChanged(value),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            hintText: 'Phone number, email or username',
            enabledBorder: const OutlineInputBorder(),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 10),
              errorText:
              state.email.displayError != null ? 'Invalid Email' : null
          ),
        );
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) => context.read<LoginCubit>().passwordChanged(value),
          obscureText: true,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.black12,
            hintText: 'Password',
            enabledBorder: const OutlineInputBorder(),
            border: const OutlineInputBorder(),
            contentPadding: const EdgeInsets.only(left: 10),
              errorText: state.password.displayError != null
                  ? 'Password must contain small, capital letters and numbers'
                  : null
          ),
        );
      },
    );
  }
}

class LoginButton extends StatelessWidget {
  const LoginButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
          ? const CircularProgressIndicator()
          : ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          onPressed: () async{
            if (state.isValid) {
              await context.read<LoginCubit>().onLogin();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return const HomePage();
                  },
                ),
              );
            } else {
              null;
            }
          },
          child: const Text(
            'Log in',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}

