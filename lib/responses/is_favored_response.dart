class IsFavoredResponse {

  late bool isFavored;

  IsFavoredResponse.fromJson(Map<String, dynamic> json) {
    isFavored = json['data']['is_favored'];
  }

}
