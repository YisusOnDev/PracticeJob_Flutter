import 'package:flutter/material.dart';
import 'package:practicejob/app_constants.dart';
import 'package:practicejob/src/models/company.dart';
import 'package:practicejob/src/models/joboffer.dart';
import 'package:intl/intl.dart';

class DescriptionTab extends StatelessWidget {
  const DescriptionTab({Key? key, this.offer, required this.type})
      : super(key: key);
  final String type;
  final JobOffer? offer;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        const SizedBox(height: 5.0),
        Text(
          type == 'company' ? "Sobre la empresa" : "Sobre la oferta",
          style: kTitleStyle.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 15.0),
        Text(
          type == 'company'
              ? getCompanyDescription(offer!.company!)
              : getOfferDescription(offer!),
          style: kSubtitleStyle.copyWith(
            fontWeight: FontWeight.w300,
            height: 1.5,
            color: const Color(0xFF5B5B5B),
          ),
        ),
        const SizedBox(height: 25.0)
      ],
    );
  }

  String getCompanyDescription(Company c) {
    return "Nombre: ${c.name}\nDirección: ${c.address} - ${c.province!.name}\n\nNo hay información adicional.";
  }

  String getOfferDescription(JobOffer j) {
    String start = DateFormat('dd-MM-yyyy').format(j.startDate!);
    String end = DateFormat('dd-MM-yyyy').format(j.endDate!);
    return "${j.description}\n\nFecha de publicación: $start.\nFecha máxima: $end.";
  }
}
