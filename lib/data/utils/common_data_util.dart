class CommonDataUtil{
  static String generateUniqueId(
      {required String collection,
        required String displaySitename,
        required String imageUrl,
        required String datetime}) {
    return "${collection}_${displaySitename}_${imageUrl}_${datetime}";
  }
}