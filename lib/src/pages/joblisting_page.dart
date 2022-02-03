import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/components/promoted_card.dart';
import 'package:practicejob/src/components/recent_job_card.dart';
import 'package:practicejob/src/models/joboffer.dart';
import 'package:practicejob/src/routes/app_routes.dart';
import 'package:practicejob/src/services/joboffer_service.dart';

class JobListingPage extends StatefulWidget {
  const JobListingPage({Key? key}) : super(key: key);

  @override
  State<JobListingPage> createState() => _JobListingPageState();
}

class _JobListingPageState extends State<JobListingPage> {
  final keyRefresh = GlobalKey<RefreshIndicatorState>();
  final jobOfferService = JobOfferService();
  final searchController = TextEditingController();
  List<JobOffer> recentList = [];
  List<JobOffer> filteredRecentList = [];

  Future<void> getRecentList() async {
    List<JobOffer> retrievedList =
        await jobOfferService.getAllAvailableFromFp();
    recentList.clear();
    setState(() {
      for (JobOffer offer in retrievedList) {
        recentList.add(offer);
      }
    });
  }

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
              children: drawMainContentWidget(),
            ),
          ),
        ),
      ),
    );
  }

  /// Widget that builds Job Offers ListView
  Widget recentListWidget() {
    if (filteredRecentList.isNotEmpty || searchController.text.isNotEmpty) {
      return ListView.builder(
        itemCount: filteredRecentList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var recent = filteredRecentList[index];
          return InkWell(
            onTap: () {
              getRecentList();
              context.router.push(JobDetailPageRoute(offer: recent));
            },
            child: RecentJobCard(offer: recent),
          );
        },
      );
    } else if (recentList.isNotEmpty) {
      return ListView.builder(
        itemCount: recentList.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const AlwaysScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          var recent = recentList[index];
          return InkWell(
            onTap: () {
              getRecentList();
              context.router.push(JobDetailPageRoute(offer: recent));
            },
            child: RecentJobCard(offer: recent),
          );
        },
      );
    } else {
      return const Text("No hay ofertas recientes");
    }
  }

  /// Custom WidgetList to draw the specified components and handle blank list and so on...
  drawMainContentWidget() {
    // This need to check PROMOTED LIST not same as non promoted list...
    if (recentList.isNotEmpty) {
      return <Widget>[
        const SizedBox(height: 10.0),
        Text(
          "OFERTAS POPULARES",
          style: kTitleStyle,
        ),
        const SizedBox(height: 15.0),
        SizedBox(
          width: double.infinity,
          height: 190.0,
          child: ListView.builder(
            itemCount: recentList.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              var offer = recentList[index];
              return InkWell(
                  onTap: () {
                    getRecentList();
                    context.router.push(JobDetailPageRoute(offer: offer));
                  },
                  child: PromotedCard(offer: offer));
            },
          ),
        ),
        const SizedBox(height: 25.0),
        searchBar(),
        const SizedBox(height: 25.0),
        Text(
          "OFERTAS RECIENTES",
          style: kTitleStyle,
        ),
        recentListWidget(),
        const SizedBox(height: 15.0),
      ];
    }
    return <Widget>[
      searchBar(),
      const SizedBox(height: 25.0),
      Text(
        "OFERTAS RECIENTES",
        style: kTitleStyle,
      ),
      recentListWidget(),
      // Fix scroll to update
      SizedBox(
        height: 100.0,
        width: MediaQuery.of(context).size.width,
      ),
    ];
  }

  /// Searchbar widget for recent offer list
  Widget searchBar() {
    if (recentList.isNotEmpty || filteredRecentList.isNotEmpty) {
      return Container(
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
      );
    }
    return const SizedBox(width: 0.0);
  }

  /// Listenable method that filter current applications list in order to get
  /// applications with given name
  void doSearch() {
    String search = searchController.text;

    filteredRecentList.clear();
    if (search.isEmpty) {
      setState(() {});
      return;
    }

    for (JobOffer offer in recentList) {
      if (offer.name!.toLowerCase().contains(search.toLowerCase())) {
        filteredRecentList.add(offer);
      }
    }

    setState(() {});
  }
}
