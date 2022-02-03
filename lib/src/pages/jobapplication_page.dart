import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/components/application_job_card.dart';
import 'package:practicejob/src/models/jobapplication.dart';
import 'package:practicejob/src/models/joboffer.dart';
import 'package:practicejob/src/models/user.dart';
import 'package:practicejob/src/routes/app_routes.dart';
import 'package:practicejob/src/services/auth_service.dart';
import 'package:practicejob/src/services/joboffer_service.dart';

class JobApplicationPage extends StatefulWidget {
  const JobApplicationPage({Key? key}) : super(key: key);

  @override
  State<JobApplicationPage> createState() => _JobApplicationPagePageState();
}

class _JobApplicationPagePageState extends State<JobApplicationPage> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final _authService = AuthService();
  final _jobOfferService = JobOfferService();
  final searchController = TextEditingController();

  List<JobOffer> jobApplicationsList = [];
  List<JobOffer> filteredApplicationsList = [];
  User? student;

  @override
  void initState() {
    super.initState();
    getRecentList();
    searchController.addListener(doSearch);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cSilver,
      body: RefreshIndicator(
        key: keyRefresh,
        onRefresh: getRecentList,
        child: Container(
          margin: const EdgeInsets.only(left: 18.0),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 15.0),
                Container(
                  width: double.infinity,
                  height: 50.0,
                  margin: const EdgeInsets.only(right: 18.0),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          child: TextField(
                            controller: searchController,
                            cursorColor: cDarkColor,
                            decoration: InputDecoration(
                              icon: const Icon(
                                Icons.search,
                                size: 25.0,
                                color: cDarkColor,
                              ),
                              border: InputBorder.none,
                              hintText: "Buscar",
                              hintStyle: kSubtitleStyle.copyWith(
                                color: Colors.black38,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 5.0),
                jobApplicationsListWidget(),
                const SizedBox(height: 15.0),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Widget that builds Job Application ListView
  Widget jobApplicationsListWidget() {
    if (filteredApplicationsList.isNotEmpty ||
        searchController.text.isNotEmpty) {
      return ListView.builder(
        itemCount: filteredApplicationsList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          var recent = filteredApplicationsList[index];
          return InkWell(
            onTap: () {
              getRecentList();
              context.router.push(JobDetailPageRoute(offer: recent));
            },
            child: ApplicationJobCard(
              offer: recent,
              student: student,
            ),
          );
        },
      );
    } else if (jobApplicationsList.isNotEmpty) {
      return ListView.builder(
        itemCount: jobApplicationsList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (context, index) {
          var recent = jobApplicationsList[index];
          return InkWell(
            onTap: () {
              getRecentList();
              context.router.push(JobDetailPageRoute(offer: recent));
            },
            child: ApplicationJobCard(
              offer: recent,
              student: student,
            ),
          );
        },
      );
    } else {
      return const Text("No has aplicado a ninguna oferta aún");
    }
  }

  /// Method that retrieves and fill job applications list
  Future<void> getRecentList() async {
    jobApplicationsList.clear();
    student = await _authService.readUserFromStorage();
    if (student != null) {
      List<JobOffer> retrievedList = await _jobOfferService.getAll();

      setState(() {
        for (JobOffer offer in retrievedList) {
          for (JobApplication app in offer.jobApplications!) {
            if (app.studentId == student!.id) {
              jobApplicationsList.add(offer);
            }
          }
        }
      });
    }
  }

  /// Listenable method that filter current applications list in order to get
  /// applications with given name
  void doSearch() {
    String search = searchController.text;

    filteredApplicationsList.clear();
    if (search.isEmpty) {
      setState(() {});
      return;
    }

    for (JobOffer offer in jobApplicationsList) {
      if (offer.name!.toLowerCase().contains(search.toLowerCase())) {
        filteredApplicationsList.add(offer);
      }
    }

    setState(() {});
  }
}
