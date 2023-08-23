

class LoginResult {
  final String userId;
  final String name;
  final String token;

  const LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });

  factory LoginResult.fromJson(Map<String, dynamic> json) {
    return LoginResult(
        userId: json['userId'], name: json['name'], token: json['token']);
  }
   
  
}

class ResponseApi {
  final bool error;
  final String message;

  const ResponseApi({
    required this.error,
    required this.message,
  });

  factory ResponseApi.fromJson(Map<String, dynamic> json) {
    return ResponseApi(error: json['error'], message: json['message']);
  }
}

class ListStory {
  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final double? lat;
  final double? lon;

  const ListStory({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  factory ListStory.fromJson(Map<String, dynamic> json) {
    return ListStory(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      photoUrl: json['photoUrl'],
      createdAt: json['createdAt'],
      lat: json['lat'],
      lon: json['lon'],
    );
  }
}