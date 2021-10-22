import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({ Key? key }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  
  //key for the form
  final _loginFormKey = GlobalKey<FormState>();

  //controllers for the TextFormFields
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLogged = false;

  bool _validateForm() {
    return _loginFormKey.currentState!.validate();
  }

  // validateRequest is in utils/services/rest_api_service
  _checkLogin(String email, String password) async {
    var response = await validateRequest(email, password);
    if (response[1] == '0') {
      isLogged = false;
    } else {
      //await setUser('email');
      isLogged = true;
    }
    print(response);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed. (Could lead to memory leaks)
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter your email',
                  ),
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    } else if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: true,
                  enableSuggestions: false,
                  autocorrect: false,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Enter your password',
                  ),
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (_validateForm()) {
                        FocusScope.of(context).requestFocus(FocusNode());
                        await _checkLogin(
                            emailController.text, passwordController.text);
                        if (isLogged) {
                          Navigator.pushNamed(context, eventManagerScreenRoute);
                        }
                      }
                    },
                    child: Text('Login'), 
                ),
              ],
            ),
          ),
          key: _loginFormKey,
        ),
      ),
    );
  }
}
