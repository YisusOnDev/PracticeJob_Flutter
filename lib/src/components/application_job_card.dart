import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/app_utils.dart';
import 'package:practicejob/src/models/jobapplication.dart';
import 'package:practicejob/src/models/joboffer.dart';
import 'package:practicejob/src/models/user.dart';

class ApplicationJobCard extends StatelessWidget {
  const ApplicationJobCard({Key? key, this.offer, this.student})
      : super(key: key);

  final JobOffer? offer;
  final User? student;

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
          getJobApplicationCardStatusText(offer!),
        ),
        trailing: const Icon(
          Icons.more_vert,
          color: cDarkColor,
        ),
      ),
    );
  }

  /// Method that returns bottom text with offer application status
  getJobApplicationCardStatusText(JobOffer offer) {
    int appId = -1;
    for (JobApplication app in offer.jobApplications!) {
      if (app.studentId == student!.id) {
        appId = app.id;
      }
    }
    if (appId != -1) {
      String status = Util.getApplicationStatus(offer.jobApplications!, appId);
      return "${offer.company!.name} • ${offer.company!.province!.name} \nEstado: $status";
    }
    return "${offer.company!.name} • ${offer.company!.province!.name} \nEstado: Desconocido";
  }
}
