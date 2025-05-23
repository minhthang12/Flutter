import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shop/constants.dart';
import 'package:shop/route/route_constants.dart';
import 'package:shop/services/api_service.dart';
import 'package:shop/tokenStorage/token_storage.dart';

import 'components/login_form.dart';

//man hinh dang nhap
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    phoneController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    checkTokenExpired();
  }

// check token còn thời hạn hay không
  void checkTokenExpired() async {
    final token = await TokenStorage.getToken();
    final isExpired = await TokenStorage.isTokenExpired(token!);
    if (!isExpired) {
      Navigator.pushNamedAndRemoveUntil(context, entryPointScreenRoute,
          ModalRoute.withName(logInScreenRoute));
    } else {
      print("Token đã hết hạn vui lòng đăng nhập lại");
    }
  }

// api login : check thông tin nếu không đúng thì không được đăng nhập
  void handleLogin() async {
    final response = await ApiService.loginUser(
        int.parse(phoneController.text), passwordController.text);
    if (response.statusCode == 200) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', response.body);
      Navigator.pushNamedAndRemoveUntil(context, entryPointScreenRoute,
          ModalRoute.withName(logInScreenRoute));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login thất bại. Vui lòng kiểm tra lại")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset(
              "assets/images/login_dark.png",
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Chào mừng bạn đã đến với cửa hàng",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: defaultPadding / 2),
                  const Text("Đăng nhập bằng thông tin bạn đã đăng kí"),
                  const SizedBox(height: defaultPadding),
                  LogInForm(
                    formKey: _formKey,
                    phoneController: phoneController,
                    passwordController: passwordController,
                  ),
                  Align(
                    child: TextButton(
                      child: const Text("Quên mật khẩu"),
                      onPressed: () {
                        // Navigator.pushNamed(
                        //     context, passwordRecoveryScreenRoute);
                      },
                    ),
                  ),
                  SizedBox(
                    height:
                        size.height > 700 ? size.height * 0.1 : defaultPadding,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      //   Navigator.pushNamedAndRemoveUntil(
                      //       context,
                      //       entryPointScreenRoute,
                      //       ModalRoute.withName(logInScreenRoute));
                      // }
                      if (_formKey.currentState!.validate()) {
                        handleLogin();
                      }
                    },
                    child: const Text("Đăng nhập"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Chưa có tài khoản?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, signUpScreenRoute);
                        },
                        child: const Text("Đăng kí"),
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
