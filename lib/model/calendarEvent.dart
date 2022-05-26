class CalendarEvent {
  String? id;
  final String title;
  final String description;
  DateTime? eventDate;

  CalendarEvent(
      {required this.title,
      required this.description,
      required this.eventDate});
}
