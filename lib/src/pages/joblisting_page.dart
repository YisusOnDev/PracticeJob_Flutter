import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/components/recent_job_card.dart';
import 'package:practicejob/src/routes/app_routes.dart';
import 'package:practicejob/src/services/joboffer_service.dart';

class JobListingPage extends StatefulWidget {
  const JobListingPage({Key? key}) : super(key: key);

  @override
  State<JobListingPage> createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {
  final jobOfferService = JobOfferService();

  List<dynamic> recentList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: cSilver,
      body: Container(
        margin: const EdgeInsets.only(left: 18.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const SizedBox(height: 10.0),
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
                    Container(
                      width: 50.0,
                      height: 50.0,
                      margin: const EdgeInsets.only(left: 12.0),
                      decoration: BoxDecoration(
                        color: cPrimaryColor,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: const Icon(
                        FontAwesomeIcons.slidersH,
                        color: Colors.white,
                        size: 20.0,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 25.0),
              Text(
                "OFERTAS POPULARES",
                style: kTitleStyle,
              ),
              const SizedBox(height: 15.0),
              /*SizedBox(
                width: double.infinity,
                height: 190.0,
                child: ListView.builder(
                  itemCount: 1, //list.length,
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemBuilder: (context, index) {
                    var offer = list[index];
                    return InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => JobDetailPage(
                                offer: offer,
                              ),
                            ),
                          );
                        },
                        child: CompanyCard(offer: offer));
                  },
                ),
              ),*/
              const SizedBox(height: 25.0),
              Text(
                "OFERTAS RECIENTES",
                style: kTitleStyle,
              ),
              FutureBuilder(
                future: jobOfferService.getAll(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    recentList = snapshot.data;
                    return ListView.builder(
                      itemCount: recentList.length,
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      physics: const ScrollPhysics(),
                      itemBuilder: (context, index) {
                        var recent = recentList[index];
                        return InkWell(
                          onTap: () {
                            context.router
                                .push(JobDetailPageRoute(offer: recent));
                          },
                          child: RecentJobCard(offer: recent),
                        );
                      },
                    );
                  }
                  return uSpinner;
                },
              ),
              const SizedBox(height: 15.0),
            ],
          ),
        ),
      ),
    );
  }
}
