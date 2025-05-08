import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shop/screens/auth/views/components/sign_up_form.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/services/api_service.dart';

import '../../../constants.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void handleSignUp() async {
    final response = await ApiService.signUpUser(
        int.parse(phoneController.text),
        passwordController.text,
        emailController.text,
        nameController.text);
    if (response.statusCode == 200) {
      Navigator.pushNamed(context, logInScreenRoute);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đăng kí thành công")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Đăng kí thất bại")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/signUp_dark.png",
              height: MediaQuery.of(context).size.height * 0.35,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bắt đầu đăng kí tài khoản",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text(
                    "Vui lòng nhập dữ liệu hợp lệ để đăng kí tài khoản",
                  ),
                  const SizedBox(height: defaultPadding),
                  SignUpForm(
                      formKey: _formKey,
                      nameController: nameController,
                      emailController: emailController,
                      phoneController: phoneController,
                      passwordController: passwordController),
                  const SizedBox(height: defaultPadding),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       onChanged: (value) {},
                  //       value: false,
                  //     ),
                  //     Expanded(
                  //       child: Text.rich(
                  //         TextSpan(
                  //           text: "I agree with the",
                  //           children: [
                  //             TextSpan(
                  //               recognizer: TapGestureRecognizer()
                  //                 ..onTap = () {
                  //                   Navigator.pushNamed(
                  //                       context, termsOfServicesScreenRoute);
                  //                 },
                  //               text: " Terms of service ",
                  //               style: const TextStyle(
                  //                 color: primaryColor,
                  //                 fontWeight: FontWeight.w500,
                  //               ),
                  //             ),
                  //             const TextSpan(
                  //               text: "& privacy policy.",
                  //             ),
                  //           ],
                  //         ),
                  //       ),
                  //     )
                  //   ],
                  // ),
                  const SizedBox(height: defaultPadding * 2),
                  ElevatedButton(
                    onPressed: () {
                      // There is 2 more screens while user complete their profile
                      // afre sign up, it's available on the pro version get it now
                      // 🔗 https://theflutterway.gumroad.com/l/fluttershop
                      if (_formKey.currentState!.validate()) {
                        handleSignUp();
                      }
                    },
                    child: const Text("Tiếp tục"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Bạn đã có tài khoản"),
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            handleSignUp();
                          }
                          Navigator.pushNamed(context, logInScreenRoute);
                        },
                        child: const Text("Đăng nhập"),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
