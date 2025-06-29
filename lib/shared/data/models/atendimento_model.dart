class Atendimento {
  final String classDate;
  final String startTime;
  final String endTime;
  final String subject;
  final String status;
  final String discipline;
  final String location;
  final String crm;
  final int
      mediaId; // Mantemos como 'int' se for sempre esperado um valor válido
  final String studentCpf;

  Atendimento({
    required this.classDate,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.status,
    required this.discipline,
    required this.location,
    required this.crm,
    required this.mediaId,
    required this.studentCpf,
  });

  Map<String, dynamic> toJson() {
    return {
      "classDate": classDate,
      "startTime": startTime,
      "endTime": endTime,
      "subject": subject,
      "status": status,
      "discipline": discipline,
      "location": location,
      "professional": {"crm": crm},
      "media": {"id": mediaId},
      "student": {"cpf": studentCpf},
    };
  }

  // Se você tiver um fromJson, ele deve lidar com o formato aninhado:
  factory Atendimento.fromJson(Map<String, dynamic> json) {
    return Atendimento(
      classDate: json["classDate"],
      startTime: json["startTime"],
      endTime: json["endTime"],
      subject: json["subject"],
      status: json["status"],
      discipline: json["discipline"],
      location: json["location"],
      crm: json["professional"]["crm"],
      mediaId: json["media"] != null
          ? json["media"]["id"] as int
          : 0, // Assume 0 ou lança erro se media for nula e for obrigatória
      studentCpf: json["student"]["cpf"],
    );
  }
}
