import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/components/description_tab.dart';
import 'package:practicejob/src/models/joboffer.dart';

class JobDetailPage extends StatelessWidget {
  const JobDetailPage({Key? key, this.offer}) : super(key: key);

  final JobOffer? offer;

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
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          offer!.company!.name.toString(),
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
                            image:
                                AssetImage("assets/default_companyu_logo.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      offer!.name!,
                      style: kTitleStyle.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      getOfferSubtitle(offer!),
                      style: kSubtitleStyle,
                    ),
                    const SizedBox(height: 10.0),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: offer!.fPs!
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
                    DescriptionTab(offer: offer, type: "description"),
                    DescriptionTab(offer: offer, type: "company"),
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
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                primary: cPrimaryLightColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              child: Text("Aplicar al trabajo", style: kTitleStyle),
            ),
          ),
        ),
      ),
    );
  }

  getOfferSubtitle(JobOffer offer) {
    if (offer.schedule != null && offer.schedule != "") {
      return "+" + offer.remuneration.toString() + "€ · ${offer.schedule}";
    }
    return "+" + offer.remuneration.toString() + "€ · Horas por definir";
  }
}
