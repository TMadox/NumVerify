class OtherExceptions {
  late String message;
  handleError(String statusCode) {
    switch (statusCode) {
      case "404":
        return "Invalid request";
      case "101":
        return "Missing or invalid access key";
      case "103":
        return "Bad API call";
      case "210":
        return "No phone number is provided";
      case "211":
        return "No numeric phone number is provided";
      default:
        return 'Oops, something went wrong';
    }
  }

  @override
  String toString() => message;
}
