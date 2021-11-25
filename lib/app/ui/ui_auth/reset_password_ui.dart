// ignore_for_file: avoid_returning_null_for_void

import 'package:astup/app/controllers/controllers.dart';
import 'package:astup/app/helpers/helpers.dart';
import 'package:astup/app/ui/components/components.dart';
import 'package:astup/app/ui/ui_auth/ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';


class ResetPasswordUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  ResetPasswordUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(context),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  LogoGraphicHeader(),
                  const SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'auth.emailFormField'.tr,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.emailController.text = value as String,
                  ),
                  const FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'auth.resetPasswordButton'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          await authController.sendPasswordResetEmail(context);
                        }
                      }),
                  const FormVerticalSpace(),
                  signInLink(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  appBar(BuildContext context) {
    if (authController.emailController.text == '') {
      return null;
    }
    return AppBar(title: Text('auth.resetPasswordTitle'.tr));
  }

  signInLink(BuildContext context) {
    if (authController.emailController.text == '') {
      return LabelButton(
        labelText: 'auth.signInonResetPasswordLabelButton'.tr,
        onPressed: () => Get.offAll(SignInUI()),
      );
    }
    return const SizedBox(width: 0, height: 0);
  }
}