import '../../../common/widgets/custom_button.dart';
import '../../../common/widgets/custom_text_field.dart';
import '../../../constants/global_variables.dart';
import '../services/auth_service.dart';
import 'package:flutter/material.dart';

//? enum for auth
enum Auth {
  signup,
  signin,
}

class AuthScreen extends StatefulWidget {
  //? route for auth screen
  static const String routeName = '/auth_screen';

  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //? auth enum
  Auth _auth = Auth.signin;
  //? form key state
  final GlobalKey<FormState> _signUpFromKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _signInFromKey = GlobalKey<FormState>();
  //? auth api servises
  final AuthServiceImp authService = AuthServiceImp();
  //? text form controller
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  //? sign up function
  void signUp() {
    authService.signUp(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
      name: _nameController.text,
    );
  }

  void signIn() {
    authService.signIn(
      context: context,
      email: _emailController.text,
      password: _passwordController.text,
    );
  }

  //? on dispose function
  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: GlobalVariables.greyBackgroundCOlor,
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            //? welcom Text
            const Text(
              'Welcome',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 15),
            //! sign up part
            ListTile(
              tileColor: _auth == Auth.signup
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Create An Account.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signup,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            //? sign up form
            if (_auth == Auth.signup)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signUpFromKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        CustomTextField(
                          myController: _nameController,
                          hintText: 'name',
                        ),
                        CustomTextField(
                          myController: _emailController,
                          hintText: 'email',
                        ),
                        CustomTextField(
                          myController: _passwordController,
                          hintText: 'password',
                        ),
                        CustomButton(
                          title: 'Sign Up',
                          onPressed: () {
                            if (_signUpFromKey.currentState!.validate()) {
                              signUp();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            //! sign in part

            ListTile(
              tileColor: _auth == Auth.signin
                  ? GlobalVariables.backgroundColor
                  : GlobalVariables.greyBackgroundCOlor,
              title: const Text(
                'Sign In.',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              leading: Radio(
                activeColor: GlobalVariables.secondaryColor,
                value: Auth.signin,
                groupValue: _auth,
                onChanged: (Auth? value) {
                  setState(() {
                    _auth = value!;
                  });
                },
              ),
            ),
            //? sign in form
            if (_auth == Auth.signin)
              Container(
                padding: const EdgeInsets.symmetric(vertical: 5),
                color: GlobalVariables.backgroundColor,
                child: Form(
                  key: _signInFromKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      children: [
                        CustomTextField(
                          myController: _emailController,
                          hintText: 'email',
                        ),
                        CustomTextField(
                          myController: _passwordController,
                          hintText: 'password',
                        ),
                        CustomButton(
                          title: 'Sign In',
                          onPressed: () {
                            if (_signInFromKey.currentState!.validate()) {
                              signIn();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
