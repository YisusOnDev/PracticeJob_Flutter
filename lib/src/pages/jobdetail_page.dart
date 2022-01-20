import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/app_utils.dart';
import 'package:practicejob/src/components/description_tab.dart';
import 'package:practicejob/src/models/jobapplication.dart';
import 'package:practicejob/src/models/joboffer.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:practicejob/src/services/jobapplication_service.dart';

class JobDetailPage extends StatefulWidget {
  const JobDetailPage({Key? key, this.offer}) : super(key: key);
  final JobOffer? offer;

  @override
  State<JobDetailPage> createState() => _JobDetailPageState();
}

class _JobDetailPageState extends State<JobDetailPage> {
  JobOffer? offer;
  User? currentStudent;

  final AuthService _authService = AuthService();
  final JobApplicationService _jobApplicationService = JobApplicationService();

  Future<void> setStudentData() async {
    currentStudent = await _authService.readUserFromStorage();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setStudentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: cSilver,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: cDarkColor,
          ),
          onPressed: () => context.router.pop(),
        ),
        title: Text(
          widget.offer!.company!.name.toString(),
          style: kTitleStyle,
        ),
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 15.0),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40.0),
              topRight: Radius.circular(40.0),
            ),
          ),
          child: Column(
            children: <Widget>[
              Container(
                constraints: const BoxConstraints(maxHeight: 250.0),
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        width: 70.0,
                        height: 70.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          image: const DecorationImage(
                            image: AssetImage(defaultCompanyLogo),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      widget.offer!.name!,
                      style: kTitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      getOfferSubtitle(widget.offer!),
                      style: kSubtitleStyle,
                    ),
                    const SizedBox(height: 10.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: widget.offer!.fPs!
                            .map(
                              (e) => Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                  vertical: 5.0,
                                ),
                                decoration: BoxDecoration(
                                  color: cPrimaryLightColor,
                                  borderRadius: BorderRadius.circular(8.0),
                                  border: Border.all(
                                      color: cDarkColor.withOpacity(.2)),
                                ),
                                child: Text(
                                  e.name,
                                  style: kSubtitleStyle,
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Material(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                        side: BorderSide(
                          color: cDarkColor.withOpacity(.2),
                        ),
                      ),
                      child: TabBar(
                        unselectedLabelColor: cDarkColor,
                        indicator: BoxDecoration(
                          color: cPrimaryColor,
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        tabs: const [
                          Tab(text: "Descripción"),
                          Tab(text: "Empresa"),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              Expanded(
                child: TabBarView(
                  children: [
                    DescriptionTab(offer: widget.offer, type: "description"),
                    DescriptionTab(offer: widget.offer, type: "company"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: PreferredSize(
        preferredSize: const Size.fromHeight(60.0),
        child: Container(
          padding: const EdgeInsets.only(left: 18.0, bottom: 25.0, right: 18.0),
          color: Colors.white,
          child: SizedBox(
            height: 50.0,
            child: ElevatedButton(
              onPressed: () => onApplyButtonPressed(widget.offer!),
              style: ElevatedButton.styleFrom(
                primary: cPrimaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: getBottomText(widget.offer!),
            ),
          ),
        ),
      ),
    );
  }

  /// Function that handle Application Apply button and send post to api
  void onApplyButtonPressed(JobOffer offer) async {
    try {
      var result =
          await _jobApplicationService.createStudentApplication(offer.id!);
      if (result == "true") {
        Util.showNotification(
            "Has aplicado correctamente a la oferta. Tu inscripción esta pendiente por parte de la empresa.",
            "info");
        context.router.removeLast();
        context.router.replaceNamed('/home');
      }
    } on TimeoutException catch (_) {
      Util.showNotification(
          "Ha ocurrido un error, por favor, intentelo más tarde.", "error");
    } finally {
      Util.rebuildAllChildren(context);
    }
  }

  /// Method that generate the formatted offer subtitle
  getOfferSubtitle(JobOffer offer) {
    if (offer.schedule != null && offer.schedule != "") {
      return "+" + offer.remuneration.toString() + "€ · ${offer.schedule}";
    }
    return "+" + offer.remuneration.toString() + "€ · Horas por definir";
  }

  /// Method that generate formatted bottom text
  getBottomText(JobOffer offer) {
    if (currentStudent != null) {
      int appId =
          studentAlreadyApplied(offer.jobApplications!, currentStudent!);
      if (appId != -1) {
        String status =
            Util.getApplicationStatus(offer.jobApplications!, appId);
        return Text("Ya has aplicado ($status)", style: kTitleStyle);
      }
    }
    return Text("Aplicar al trabajo", style: kTitleStyle);
  }

  /// Method that returns of the application id if user has applied or -1 if not
  /// applied to that offer
  int studentAlreadyApplied(List<JobApplication> applications, User student) {
    for (JobApplication app in applications) {
      if (app.studentId == student.id) {
        return app.id;
      }
    }
    return -1;
  }
}
