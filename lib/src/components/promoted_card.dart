import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/joboffer.dart';

class PromotedCard extends StatelessWidget {
  const PromotedCard({Key? key, this.offer}) : super(key: key);
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
                    image: AssetImage(defaultCompanyLogo),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                child: Text(
                  offer!.company!.name!,
                  style: kTitleStyle.copyWith(
                    color: Colors.white,
                  ),
                ),
                margin: const EdgeInsets.only(left: 10.0),
              ),
            ],
          ),
          Text(
            offer!.name!,
            style: kTitleStyle.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: offer!.remuneration!.toString() + "€",
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
        ],
      ),
    );
  }
}
