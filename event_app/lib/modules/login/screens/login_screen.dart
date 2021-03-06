import 'package:event_app/config/routes/routes.dart';
import 'package:event_app/config/theme/colors.dart';
import 'package:event_app/models/logged_user.dart';
import 'package:event_app/models/user.dart';
import 'package:event_app/modules/login/widgets/rounded_input_field.dart';
import 'package:event_app/modules/login/widgets/rounded_password_field.dart';
import 'package:event_app/widgets/primary_button_widget.dart';
import 'package:event_app/utils/services/local_storage_service.dart';
import 'package:event_app/utils/services/rest_api_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
  _checkLogin(String email, String password, LoggedUser loggedUser) async {
    var response = await validateRequest(email, password);
    if (response[1] == '0') {
      isLogged = false;
    } else {
      User user = User.fromJson(response[3]);
      loggedUser.logUser(user);
      if (loggedUser.user != null) {
        await setUser(loggedUser.user!.mail);
        isLogged = true;
      }

    }
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
    // emailController.text = 'ykhonyak@email.com';
    // passwordController.text = 'ykhonyak';
    final LoggedUser loggedUser = Provider.of<LoggedUser>(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: primary_background,
        body: Form(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RoundedInputField(
                  controller: emailController,
                  hintText: 'Your Email',
                ),
                RoundedPasswordField(
                  controller: passwordController,
                  hintText: 'Password',
                ),
                SizedBox(height: 30),
                PrimaryButton('Login', primary_blue, onPressed: () async {
                  if (_validateForm()) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await _checkLogin(
                        emailController.text, passwordController.text, loggedUser);
                    if (isLogged) {
                      Navigator.pushNamed(context, eventManagerScreenRoute);
                      // Code test pour Sam - crowd games
                      // Navigator.pushNamed(context, appFeaturesMainScreenRoute);
                    }
                  }
                }),
              ],
            ),
          ),
          key: _loginFormKey,
        ),
      ),
    );
  }
}
