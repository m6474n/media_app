import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/input_Text.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:provider/provider.dart';
import '../../view models/login/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final emailFocusedNode = FocusNode();
  final passFocusedNode = FocusNode();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusedNode.dispose();

    passController.dispose();
    passFocusedNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height * 1;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: height * 0.1,
                ),
                Text(
                  'WELCOME BACK!',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Enter your email address \n to connect to your account',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Form(
                    key: _formKey,
                    child: Padding(
                      padding:
                          EdgeInsets.only(top: height * 0.06, bottom: 0.01),
                      child: Column(
                        children: [
                          InputTextField(
                              myController: emailController,
                              focusNode: emailFocusedNode,
                              onFiledSubmittedValue: (value) {},
                              onValidator: (value) {
                                return value.isEmpty ? 'Enter Email' : null;
                              },
                              keyboardType: TextInputType.emailAddress,
                              hint: 'Email',
                              obscureText: false),
                          SizedBox(
                            height: height * 0.01,
                          ),
                          InputTextField(
                              myController: passController,
                              focusNode: passFocusedNode,
                              onFiledSubmittedValue: (value) {},
                              onValidator: (value) {
                                return value.isEmpty ? 'Enter Password' : null;
                              },
                              keyboardType: TextInputType.visiblePassword,
                              hint: 'Password',
                              obscureText: true),
                        ],
                      ),
                    )),
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: (){
                     Navigator.pushNamed(context, RouteName.forgotPassView);
                    },
                    child: Text(
                      'Forgot Password?',
                      style: Theme.of(context).textTheme.headline2!.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ChangeNotifierProvider(
                  create: (_) => LoginController(),
                  child: Consumer<LoginController>(
                    builder: (context, provider, child) {
                      return RoundedButton(
                        title: 'login',
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.login(context, emailController.text,
                                passController.text);
                          }
                        },
                        loading: provider.loading,
                      );
                    },
                  ),
                ),
                SizedBox(
                  height: height * 0.03,
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, RouteName.signupView);
                  },
                  child: Text.rich(TextSpan(
                      text: "Don't have an account? ",
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontSize: 15),
                      children: [
                        TextSpan(
                          text: 'Sign Up',
                          style: Theme.of(context)
                              .textTheme
                              .headline2!
                              .copyWith(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.mainAppColor,
                                  decoration: TextDecoration.underline),
                        )
                      ])),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
