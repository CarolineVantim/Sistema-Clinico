import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sistema_clinico/features/clinicalcare/domain/clinical_care.dart';

import 'widgets/ChewiePlayer.dart';

class ClinicalCareDetailWidget extends StatefulWidget {
  const ClinicalCareDetailWidget({super.key, required this.clinicalCare});

  final ClinicalCare clinicalCare;

  @override
  State<ClinicalCareDetailWidget> createState() =>
      _ClinicalCareDetailWidgetState();
}

class _ClinicalCareDetailWidgetState extends State<ClinicalCareDetailWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes Atendimento'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: const Icon(Icons.school),
            title: const Text(
              'Profissional',
            ),
            subtitle: Text(widget.clinicalCare.professional.name),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text(
              'Disciplina',
            ),
            subtitle: Text(widget.clinicalCare.discipline),
          ),
          ListTile(
            leading: const Icon(Icons.category),
            title: const Text(
              'Título',
            ),
            subtitle: Text(widget.clinicalCare.subject),
          ),
          widget.clinicalCare.media?.url == null
              ? Container()
              : ChewieVideoPlayerWidget(
                  url: widget.clinicalCare.media!.url,
                )
        ],
      ),
    );
  }
}
