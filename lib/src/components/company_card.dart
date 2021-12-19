import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/joboffer.dart';

class CompanyCard extends StatelessWidget {
  const CompanyCard({Key? key, this.offer}) : super(key: key);
  final JobOffer? offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280.0,
      margin: const EdgeInsets.only(right: 15.0),
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        color: cPrimaryColor,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                width: 50.0,
                height: 50.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  image: const DecorationImage(
                    // image: AssetImage(company!.image!),
                    image: AssetImage("assets/default_companyu_logo.png"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Text(
                  offer!.remuneration!.toString(),
                  style: kTitleStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
                margin: const EdgeInsets.only(left: 10.0),
              ),
            ],
          ),
          const SizedBox(height: 15.0),
          Text(
            offer!.name!,
            style: kTitleStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15.0),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: offer!.company!.name,
                  style: kSubtitleStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: "  •  ",
                  style: kSubtitleStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: offer!.company!.province!.name,
                  style: kSubtitleStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 15.0),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: offer!.fPs!
                  .map(
                    (e) => Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(right: 10.0),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11.5, vertical: 5.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.0),
                        color: cPrimaryLightColor,
                      ),
                      child: Text(
                        e.name,
                        style: kSubtitleStyle.copyWith(
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }
}
