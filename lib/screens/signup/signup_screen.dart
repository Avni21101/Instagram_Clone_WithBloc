import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:instagram_clone/blocs/signup-cubit/sign_up_cubit.dart';
import 'package:instagram_clone/repository/authentication_repository/authentication_repository.dart';
import 'package:instagram_clone/screens/home_page.dart';
import 'package:instagram_clone/screens/login/login_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignUpCubit(AuthenticationRepository()),
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SafeArea(
              child: SingleChildScrollView(
                child: BlocListener<SignUpCubit, SignUpState>(
                  listenWhen: (previous, current) =>
                      previous.status != current.status,
                  listener: (context, state) {
                    if (state.status.isSuccess) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return const HomePage();
                          },
                        ),
                      );
                    } else if (state.status.isFailure) {
                      ScaffoldMessenger.of(context)
                        ..hideCurrentSnackBar
                        ..showSnackBar(
                          SnackBar(
                            content:
                                Text(state.errorMessage ?? 'Sign In failed'),
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
                      const SizedBox(height: 20),
                      Center(
                        child: Stack(
                          children: [
                            // _image != null
                            //     ? CircleAvatar(
                            //   radius: 64,
                            //   backgroundImage: MemoryImage(_image!),
                            // )
                            //     :
                            const CircleAvatar(
                              radius: 64,
                              backgroundImage:
                                  AssetImage('assets/defaultProfilePic.jpg'),
                            ),
                            Positioned(
                                bottom: -10,
                                left: 85,
                                child: IconButton(
                                  onPressed: () {}, //selectImage,
                                  icon: const Icon(Icons.add_a_photo),
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      const EmailTextField(),
                      const SizedBox(height: 20),
                      const PasswordTextField(),
                      const SizedBox(height: 20),
                      const SignUpButton(),
                      const SizedBox(
                        height: 30,
                      ),
                      Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              const TextSpan(
                                  text: 'Already have an account?  ',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 20)),
                              TextSpan(
                                text: 'Login.',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (BuildContext context) {
                                          return const LoginScreen();
                                        },
                                      ),
                                    );
                                  },
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
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
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) => context.read<SignUpCubit>().emailChanged(value),
          decoration: InputDecoration(
              hintText: 'Enter Your Email',
              filled: true,
              fillColor: Colors.black12,
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(),
              errorText:
                  state.email.displayError != null ? 'Invalid Email' : null),
        );
      },
    );
  }
}

class PasswordTextField extends StatelessWidget {
  const PasswordTextField({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return TextFormField(
          onChanged: (value) =>
              context.read<SignUpCubit>().passwordChanged(value),
          obscureText: true,
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.black12,
              hintText: 'Create Password',
              border: const OutlineInputBorder(),
              enabledBorder: const OutlineInputBorder(),
              errorText: state.password.displayError != null
                  ? 'Password must contain small, capital letters and numbers'
                  : null),
        );
      },
    );
  }
}

class SignUpButton extends StatelessWidget {
  const SignUpButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () async {
                  if (state.isValid) {
                    await context.read<SignUpCubit>().onSignUp();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const HomePage(),
                      ),
                    );
                  } else {
                    null;
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                child: const Text(
                  'Sign up',
                  style: TextStyle(color: Colors.black, fontSize: 20),
                ),
              );
      },
    );
  }
}
