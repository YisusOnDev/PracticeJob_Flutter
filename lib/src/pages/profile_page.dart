import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/components/profile_image.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/app_utils.dart';
import 'package:practicejob/src/routes/app_routes.dart';
import 'package:practicejob/src/services/auth_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final AuthService _authService = AuthService();
  late User user;
  String _imagePath = getProfilePicture("default.png", "student");
  bool isBusy = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _authService.readUserFromStorage(),
      initialData: null,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          user = snapshot.data;
          if (user.profileImage != null) {
            _imagePath = getProfilePicture(user.profileImage!, "student");
          }
          return Builder(
            builder: (context) => Scaffold(
              body: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  const SizedBox(height: 24),
                  ProfileWidget(
                    imagePath: _imagePath,
                    onClicked: () {
                      if (!isBusy) {
                        context.router.push(CompleteProfilePageRoute(
                            title: 'Editar perfil', userData: user));
                      }
                    },
                  ),
                  const SizedBox(height: 24),
                  buildName(user),
                  const SizedBox(height: 24),
                  buildAbout(user),
                ],
              ),
            ),
          );
        } else {
          return uFullSpinner;
        }
      },
    );
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name!,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email!,
            style: const TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildAbout(User user) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Formación: ' +
                  user.fp!.name +
                  ' (' +
                  user.fpCalification.toString() +
                  ')',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              'De: ' + user.city! + ', ' + user.province!.name,
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
            const SizedBox(height: 16),
            Text(
              'Edad: ' + Util.getAgeFromDate(user.birthDate!).toString(),
              style: const TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
