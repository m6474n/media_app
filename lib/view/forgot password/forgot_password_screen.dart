import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tech_media/res/color.dart';
import 'package:tech_media/res/components/input_Text.dart';
import 'package:tech_media/res/components/round_button.dart';
import 'package:tech_media/utils/routes/route_name.dart';
import 'package:provider/provider.dart';
import '../../view models/forgot password/forgot_controller.dart';
import '../../view models/login/login_controller.dart';
class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPassScreen> createState() => _ForgotPassScreenState();
}

class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final emailController = TextEditingController();

  final emailFocusedNode = FocusNode();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailController.dispose();
    emailFocusedNode.dispose();

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
                  'Forgot Password?',
                  style: Theme.of(context).textTheme.headline4,
                ),
                SizedBox(
                  height: height * 0.01,
                ),
                Text(
                  'Enter your email address \n to recover your password.',
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

                        ],
                      ),
                    )),

                const SizedBox(
                  height: 40,
                ),
                ChangeNotifierProvider(
                  create: (_) => ForgotPassController(),
                  child: Consumer<ForgotPassController>(
                    builder: (context, provider, child) {
                      return RoundedButton(
                        title: 'recover',
                        onPress: () {
                          if (_formKey.currentState!.validate()) {
                            provider.forgotPassword(context, emailController.text,
                               );
                          }
                        },
                        loading: provider.loading,
                      );
                    },
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
