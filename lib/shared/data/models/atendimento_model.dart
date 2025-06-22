class Atendimento {
  final String classDate;
  final String startTime;
  final String endTime;
  final String subject;
  final String status;
  final String discipline;
  final String location;
  final List<String> notes;
  final String crm;
  final int mediaId;
  final String studentCpf;

  Atendimento({
    required this.classDate,
    required this.startTime,
    required this.endTime,
    required this.subject,
    required this.status,
    required this.discipline,
    required this.location,
    required this.notes,
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
      "notes": notes,
      "professional": {"crm": crm},
      "media": {"id": mediaId},
      "student": {"cpf": studentCpf},
    };
  }
}
