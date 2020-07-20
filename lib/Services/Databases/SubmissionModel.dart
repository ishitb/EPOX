class SubmissionModel {
  final int latitude, longitude;
  final String date, time, severity, status;

  SubmissionModel({
    this.latitude,
    this.longitude,
    this.date,
    this.time,
    this.severity,
    this.status,
  });

  Map returnJSON() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'date': date,
      'time': time,
      'severity': severity,
    };
  }
}
