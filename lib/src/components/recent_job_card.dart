import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/joboffer.dart';

class RecentJobCard extends StatelessWidget {
  const RecentJobCard({Key? key, this.offer}) : super(key: key);
  final JobOffer? offer;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.0,
      margin: const EdgeInsets.only(right: 18.0, top: 15.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        leading: Container(
          width: 50.0,
          height: 50.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            image: DecorationImage(
              image: NetworkImage(
                  getProfilePicture(offer!.company!.profileImage!, "company")),
              fit: BoxFit.cover,
            ),
          ),
        ),
        title: Text(offer!.name!, style: kTitleStyle),
        subtitle: Text(
          "${offer!.company!.name} • ${offer!.company!.province!.name}",
        ),
        trailing: const Icon(
          Icons.more_vert,
          color: cDarkColor,
        ),
      ),
    );
  }
}
