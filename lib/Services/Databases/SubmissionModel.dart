class SubmissionModel {
  final double latitude, longitude, status, pci;
  final String date, time, comments;

  SubmissionModel({
    this.latitude,
    this.longitude,
    this.date,
    this.time,
    this.pci,
    this.status,
    this.comments,
  });

  Map<String, dynamic> returnJSON(
    String uid,
    String userEmail,
    String username,
  ) {
    return {
      'uid': uid,
      'user-email': userEmail,
      'username': username,
      'latitude': latitude,
      'longitude': longitude,
      'status': status,
      'date': date,
      'time': time,
      'pci': pci,
      'comments': comments,
    };
  }
}

class FinalSubmissionModel {
  final double latitude, longitude, status;
  final String date, time, comments, location, imageURL;
  final double pci;

  FinalSubmissionModel({
    this.latitude,
    this.longitude,
    this.status,
    this.date,
    this.time,
    this.comments,
    this.location,
    this.imageURL,
    this.pci,
  });
}
