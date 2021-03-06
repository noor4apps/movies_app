import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/constants/m_colors.dart';
import 'package:movies_app/constants/sizes.dart';
import 'package:movies_app/controllers/auth_controller.dart';
import 'package:movies_app/screens/register_screen.dart';
import 'package:movies_app/widgets/primary_btn_widget.dart';
import 'package:movies_app/widgets/text_field_widget.dart';

class LoginScreen extends StatefulWidget {

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final authController = Get.find<AuthController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _hidePassword = true;
  Map<String, dynamic> _loginData = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          buildTopBanner(),
          buildForm(),
        ],
      )
    );
  }

  Widget buildTopBanner() {
    return Container(
      height: Get.height/3.5,
      color: MColors.primary,
      child: Stack(
        children: [
          Center(child: Text('Login', style: TextStyle(fontSize: Sizes.screen))),
          IconButton(
            padding: EdgeInsets.all(15),
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back, size: 30),
          )
        ],
      ),
    );
  }

  Widget buildForm() {
    return Container(
      padding: const EdgeInsets.all(12),
      child: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.always,
        child: Column(
          children: [
            TextFieldWidget(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'field'.tr + ' ' + 'email'.tr + ' ' + 'required'.tr;
                  }
                }),
            TextFieldWidget(
              label: 'Password',
              keyboardType: TextInputType.text,
              controller: _passwordController,
              obscureText: _hidePassword,
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    _hidePassword = !_hidePassword;
                  });
                },
                icon: _hidePassword == true ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
              ),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'field'.tr + ' ' + 'password'.tr + ' ' + 'required'.tr;
                }
              },
            ),
            primaryBtnWidget(
              label: 'Login',
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                  _loginData['email'] = _emailController.text;
                  _loginData['password'] = _passwordController.text;
                  authController.login(loginData: _loginData);
                }
              },
            ),
            SizedBox(height: 10),
            TextButton(
              child: Text('Create new account'),
              onPressed: () {
                Get.off(() => RegisterScreen(), preventDuplicates: false);
              },
            ),
          ],
        ),
      ),
    );
  }

}
