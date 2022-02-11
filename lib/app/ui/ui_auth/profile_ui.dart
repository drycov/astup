import 'package:astup/app/controllers/auth_controller.dart';
import 'package:astup/app/controllers/controllers.dart';

import 'package:astup/app/ui/components/logo_graphic_header.dart';
import 'package:astup/app/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileUI extends StatefulWidget {
  const ProfileUI({Key? key}) : super(key: key);

  @override
  _ProfileUIState createState() => _ProfileUIState();
}

class _ProfileUIState extends State<ProfileUI> {
  final AuthController authController = AuthController.to;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    authController.cnController.text =
        authController.firestoreUser.value!.cn.toString();
    authController.postController.text =
        authController.firestoreUser.value!.post.toString();
    authController.firstNameController.text =
        authController.firestoreUser.value!.firstName.toString();
    authController.middleNameController.text =
        authController.firestoreUser.value!.middleName.toString();
    authController.lastNameController.text =
        authController.firestoreUser.value!.lastName.toString();
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('/locations')
          .doc(authController.firestoreUser.value!.cn.toString())
          .get(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snpt) {
        if (snpt.hasError) {
          return const Text("Something went wrong");
        }

        if (snpt.hasData && !snpt.data!.exists) {
          return const Text("Document does not exist");
        }

        if (snpt.connectionState == ConnectionState.done) {
          Map<String, dynamic> data = snpt.data!.data() as Map<String, dynamic>;
          return Scaffold(
              appBar: AppBar(
                title: Text('auth.profileTitle'.tr),
                actionsIconTheme: const IconThemeData(
                  color: Colors.white,
                ),
                leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new_outlined),
                    onPressed: () {
                      Get.back();
                    }),
              ),
              body: StreamBuilder(
                // stream: locations.orderBy(locId).snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Text("Loading");
                    }
                    return _buildLayoutSection(context, snapshot, data);
                  }));
        }
        // return const Text("loading");
        return Scaffold(
            appBar: AppBar(
              title: Text('auth.profileTitle'.tr),
              actionsIconTheme: const IconThemeData(
                color: Colors.white,
              ),
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new_outlined),
                  onPressed: () {
                    Get.back();
                  }),
            ),
            body: StreamBuilder(
              // stream: locations.orderBy(locId).snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Text("Loading");
                  }
                  // return _buildLayoutSection(context, snapshot, data);
                  return const Center(child: CircularProgressIndicator());
                }));
      },
    );
  }

  Widget _buildLayoutSection(BuildContext context, snapshot,
      Map<String, dynamic> data) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 8.0),

                Align(
                    alignment: Alignment.bottomRight,
                    child: Container(
                      // margin: EdgeInsets.all(20),
                      // padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(
                            width: 2,
                            color: Theme
                                .of(context)
                                .colorScheme
                                .primary,
                          )),
                      child: CircleAvatar(
                        radius: 42,
                        child: LogoGraphicHeader(
                          avatar: authController.firestoreUser.value!.fileName,
                        ),
                      ),
                    )),
                // LogoGraphicHeader(
                //   avatar: authController.firestoreUser.value!.photoUrl,
                // ),
                const SizedBox(height: 16.0),
                Text(
                  authController.firestoreUser.value!.name.toString(),
                  style: const TextStyle(color: AppThemes.black, fontSize: 24),
                ),
                const SizedBox(height: 48.0),
              ],
            )
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'auth.emailFormField'.tr,
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
            Text(
              authController.firestoreUser.value!.email.toString(),
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'auth.cnFormField'.tr,
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
            Text(
              '${data['on']}',
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
          ],
        ),
        Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'auth.postFormField'.tr,
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
            Text(
              authController.firestoreUser.value!.post.toString(),
              style: const TextStyle(color: AppThemes.black, fontSize: 16),
            ),
          ],
        ),
      ],
    );
  }
}
