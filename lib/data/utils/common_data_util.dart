class CommonDataUtil{
  /// 고유 아이디 생성 - Kakao Image API에서 받아온 데이터를 저장할 때 사용
  static String generateUniqueId(
      {required String collection,
        required String displaySiteName,
        required String imageUrl,
        required String datetime}) {
    return "${collection}_${displaySiteName}_${imageUrl}_${datetime}";
  }
}