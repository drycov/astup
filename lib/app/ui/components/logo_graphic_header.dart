import 'package:astup/app/controllers/controllers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class LogoGraphicHeader extends StatelessWidget {
  LogoGraphicHeader({Key? key,   this.avatar, this.onTapas,
  }) : super(key: key);
  final ThemeController themeController = ThemeController.to;
  final Function()? onTapas;
  final String? avatar;
  @override
  Widget build(BuildContext context) {
    if (avatar == '') {
      String _imageLogo = 'assets/images/default.png';
      if (themeController.isDarkModeOn == true) {
        _imageLogo = 'assets/images/defaultDark.png';
      }
      return Hero(
        tag: 'App Logo',
          child: InkWell(
          onTap: onTapas,
        child: CircleAvatar(
            foregroundColor: Colors.blue,
            backgroundColor: Colors.transparent,
            radius: 60.0,
            child: ClipOval(
              child: Image.asset(
                _imageLogo,
                fit: BoxFit.cover,
                width: 120.0,
                height: 120.0,
              ),
            )),
      ));
    } else {
      return Hero(
        tag: 'User Avatar Image',
        child: CircleAvatar(
            backgroundColor: Colors.white,
            radius: 70.0,
            child: ClipOval(
              child: CachedNetworkImage(
                imageUrl: avatar.toString(),
                width: 160,
                height: 160,
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
              // Image.network(
              //   user.photoUrl,
              //   fit: BoxFit.cover,
              //   width: 120.0,
              //   height: 120.0,
              // ),
            )),
      );
    }
  }
}
