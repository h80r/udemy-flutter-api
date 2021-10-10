class AppConfig {
  AppConfig({
    required this.baseApiUrl,
    required this.baseImageApiUrl,
    required this.apiKey,
  });

  final String baseApiUrl;
  final String baseImageApiUrl;
  final String apiKey;

  AppConfig.fromJSON(dynamic json)
      : baseApiUrl = json['BASE_API_URL'],
        baseImageApiUrl = json['BASE_IMAGE_API_URL'],
        apiKey = json['API_KEY'];
}
