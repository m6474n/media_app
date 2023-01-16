import 'package:flutter/material.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:tech_media/view%20models/signup/signup_controller.dart';

import '../../res/color.dart';
import '../../res/components/input_Text.dart';
import '../../utils/utils.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passController = TextEditingController();
  final emailFocusedNode = FocusNode();
  final passFocusedNode = FocusNode();
  final usernameFocusedNode = FocusNode();
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
        appBar: AppBar(
          elevation: 0,
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: ChangeNotifierProvider(
              create: (_) => SignUpController(),
              child: Consumer<SignUpController>(
                builder: (context, provider, child) {
                  return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          'WELCOME TO APP',
                          style: Theme.of(context).textTheme.headline4,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Text(
                          'Enter your email address \n to register to your account',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        Form(
                            key: _formKey,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: height * 0.06, bottom: 0.01),
                              child: Column(
                                children: [
                                  InputTextField(
                                      myController: usernameController,
                                      focusNode: usernameFocusedNode,
                                      onFiledSubmittedValue: (value) {},
                                      onValidator: (value) {
                                        return value.isEmpty
                                            ? 'Enter Username'
                                            : null;
                                      },
                                      keyboardType: TextInputType.text,
                                      hint: 'Username',
                                      obscureText: false),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  InputTextField(
                                      myController: emailController,
                                      focusNode: emailFocusedNode,
                                      onFiledSubmittedValue: (value) {
                                        Utils.fieldFocus(context,
                                            emailFocusedNode, passFocusedNode);
                                      },
                                      onValidator: (value) {
                                        return value.isEmpty
                                            ? 'Enter Email'
                                            : null;
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
                                        return value.isEmpty
                                            ? 'Enter Password'
                                            : null;
                                      },
                                      keyboardType:
                                          TextInputType.visiblePassword,
                                      hint: 'Password',
                                      obscureText: true),
                                ],
                              ),
                            )),
                       const  SizedBox(
                          height: 40,
                        ),
                        RoundedButton(
                          title: 'Create Account',
                          onPress: () {
                            if (_formKey.currentState!.validate()) {
                              provider.signup(context,usernameController.text,
                                  emailController.text, passController.text);
                            }
                          },
                          loading: provider.loading,
                        ),
                        SizedBox(
                          height: height * 0.01,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, RouteName.loginScreenView);
                          },
                          child: Text.rich(TextSpan(
                              text: "Already have an account? ",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1!
                                  .copyWith(fontSize: 15),
                              children: [
                                TextSpan(
                                  text: 'Login',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2!
                                      .copyWith(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.primaryMaterialColor,
                                          decoration: TextDecoration.underline),
                                )
                              ])),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )),
      ),
    );
  }
}
