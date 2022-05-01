import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies_app/controllers/auth_controller.dart';
import 'package:movies_app/screens/login_screen.dart';
import 'package:movies_app/widgets/primary_btn_widget.dart';
import 'package:movies_app/widgets/text_field_widget.dart';

class RegisterScreen extends StatefulWidget {

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final authController = Get.find<AuthController>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmationController = TextEditingController();

  bool _hidePassword = true;
  bool _hidePasswordConfirmation = true;

  Map<String, dynamic> _registerData = {};

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
      color: Colors.green,
      child: Stack(
        children: [
          Center(child: Text('Register', style: TextStyle(fontSize: 25))),
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
                label: 'Name',
                keyboardType: TextInputType.name,
                controller: _nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'field'.tr + ' ' + 'name'.tr + ' ' + 'required'.tr;
                  }
                }),
            TextFieldWidget(
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'field'.tr + ' ' + 'email'.tr + ' ' + 'required'.tr;
                  }
                  if(!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)){
                    return 'please a valid email';
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
                if (value.length < 6) {
                  return 'the password must be at least 6 character';
                }
              },
            ),
            TextFieldWidget(
              label: 'Confirm password',
              keyboardType: TextInputType.text,
              controller: _passwordConfirmationController,
              obscureText: _hidePasswordConfirmation,
              suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      _hidePasswordConfirmation = !_hidePasswordConfirmation;
                    });
                  },
                  icon: _hidePassword == true ? Icon(Icons.visibility_off) : Icon(Icons.visibility)
              ),
              validator: (value) {
                if(value == null || value.isEmpty) {
                  return 'field'.tr + ' ' + 'password confirmation'.tr + ' ' + 'required'.tr;
                }
                if(_passwordController.text != _passwordConfirmationController.text) {
                  return 'password does not match'.tr;
                }
              },
            ),
            primaryBtnWidget(
              label: 'Register',
              onPressed: () {
                if(_formKey.currentState!.validate()) {
                  _registerData['name'] = _nameController.text;
                  _registerData['email'] = _emailController.text;
                  _registerData['password'] = _passwordController.text;
                  _registerData['password_confirmation'] = _passwordConfirmationController.text;

                  authController.register(registerData: _registerData);
                }
              },
            ),
            SizedBox(height: 10),
            TextButton(
              child: Text('Already have a account ?'),
              onPressed: () {
                Get.off(() => LoginScreen(), preventDuplicates: false);
              },
            ),
          ],
        ),
      ),
    );
  }

}
