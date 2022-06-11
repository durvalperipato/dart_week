enum ProjectStatus {
  // ignore: constant_identifier_names
  em_andamento(label: "Em andamento"),
  finalizado(label: 'Finalizado');

  final String label;
  const ProjectStatus({required this.label});
}
