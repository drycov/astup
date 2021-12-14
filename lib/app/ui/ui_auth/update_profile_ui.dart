// ignore_for_file: avoid_returning_null_for_void

import 'package:astup/app/controllers/controllers.dart';
import 'package:astup/app/helpers/helpers.dart';
import 'package:astup/app/models/index.dart';
import 'package:astup/app/ui/components/components.dart';
import 'package:astup/app/ui/ui_auth/ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';


class UpdateProfileUI extends StatelessWidget {
  final AuthController authController = AuthController.to;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // String? deviceId = await PlatformDeviceId.getDeviceId;

  Future<String?> getUid() async {
    String? deviceId = await PlatformDeviceId.getDeviceId;
    return deviceId;
  }

  UpdateProfileUI({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String uDevID = getUid().toString();
    //print('user.name: ' + user?.value?.name);
    authController.nameController.text =
        authController.firestoreUser.value!.name;
    authController.emailController.text =
        authController.firestoreUser.value!.email;
    authController.cnController.text = authController.firestoreUser.value!.cn;
    authController.postController.text =
        authController.firestoreUser.value!.post;
    authController.firstNameController.text =
        authController.firestoreUser.value!.firstName;
    authController.middleNameController.text =
        authController.firestoreUser.value!.middleName;
    authController.lastNameController.text =
        authController.firestoreUser.value!.lastName;
    return Scaffold(
      appBar: AppBar(title: Text('auth.updateProfileTitle'.tr)),
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
                  const FormVerticalSpace(),
                  LogoGraphicHeader(
                    avatar: authController.firestoreUser.value!.photoUrl,
                  ),
                  // const SizedBox(height: 48.0),
                  FormInputFieldWithIcon(
                    controller: authController.nameController,
                    iconPrefix: Icons.person,
                    labelText: 'auth.nameFormField'.tr,
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.nameController.text = value!,
                  ),
                  const FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.firstNameController,
                    iconPrefix: Icons.person,
                    labelText: 'auth.firstNameFormField'.tr,
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.firstNameController.text = value!,
                  ),
                  const FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.middleNameController,
                    iconPrefix: Icons.person,
                    labelText: 'auth.middleNameFormField'.tr,
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                    authController.middleNameController.text = value!,
                  ),
                  const FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.lastNameController,
                    iconPrefix: Icons.person,
                    labelText: 'auth.lastNameFormField'.tr,
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.lastNameController.text = value!,
                  ),
                  const FormVerticalSpace(),

                  FormInputFieldWithIcon(
                    controller: authController.emailController,
                    iconPrefix: Icons.email,
                    labelText: 'auth.emailFormField'.tr,
                    validator: Validator().email,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.emailController.text = value!,
                  ),
                  const FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.cnController,
                    iconPrefix: Icons.person,
                    labelText: 'auth.cnFormField'.tr,
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.cnController.text = value!,
                  ),
                  const FormVerticalSpace(),
                  FormInputFieldWithIcon(
                    controller: authController.postController,
                    iconPrefix: Icons.person,
                    labelText: 'auth.postFormField'.tr,
                    validator: Validator().name,
                    onChanged: (value) => null,
                    onSaved: (value) =>
                        authController.postController.text = value!,
                  ),
                  const FormVerticalSpace(),
                  PrimaryButton(
                      labelText: 'auth.updateUser'.tr,
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          SystemChannels.textInput
                              .invokeMethod('TextInput.hide');
                          UserModel _updatedUser = UserModel(
                              uid: authController.firestoreUser.value!.uid,
                              name: authController.firstNameController.text +
                                  ' ' +
                                  authController.middleNameController.text
                                      .substring(
                                          0,
                                          authController.middleNameController
                                                  .text.length +
                                              1) +
                                  '. ' +
                                  authController.lastNameController.text,
                              email: authController.emailController.text,
                              photoUrl:
                                  authController.firestoreUser.value!.photoUrl,
                              post: authController.postController.text,
                              cn: authController.cnController.text,
                              middleName:
                                  authController.middleNameController.text,
                              lastName: authController.lastNameController.text,
                              firstName:
                                  authController.firstNameController.text,
                              devID:uDevID);
                          _updateUserConfirm(context, _updatedUser,
                              authController.firestoreUser.value!.email);
                        }
                      }),
                  const FormVerticalSpace(),
                  LabelButton(
                    labelText: 'auth.resetPasswordLabelButton'.tr,
                    onPressed: () => Get.to(ResetPasswordUI()),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _updateUserConfirm(
      BuildContext context, UserModel updatedUser, String oldEmail) async {
    final AuthController authController = AuthController.to;
    final TextEditingController _password = TextEditingController();
    return Get.dialog(
      AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0))),
        title: Text(
          'auth.enterPassword'.tr,
        ),
        content: FormInputFieldWithIcon(
          controller: _password,
          iconPrefix: Icons.lock,
          labelText: 'auth.passwordFormField'.tr,
          validator: (value) {
            String pattern = r'^.{6,}$';
            RegExp regex = RegExp(pattern);
            if (!regex.hasMatch(value!)) {
              return 'validator.password'.tr;
            } else {
              return null;
            }
          },
          obscureText: true,
          onChanged: (value) => null,
          onSaved: (value) => _password.text = value!,
          maxLines: 1,
        ),
        actions: <Widget>[
          TextButton(
            child: Text('auth.cancel'.tr.toUpperCase()),
            onPressed: () {
              Get.back();
            },
          ),
          TextButton(
            child: Text('auth.submit'.tr.toUpperCase()),
            onPressed: () async {
              Get.back();
              await authController.updateUser(
                  context, updatedUser, oldEmail, _password.text);
            },
          )
        ],
      ),
    );
  }
}
