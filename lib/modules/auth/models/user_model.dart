part of pragma_app.modules.auth.models;

class UserModel  {
  final String email, displayName, urlImg;
  final String? accessToken;
  final bool isPragmatic;

  UserModel({
    this.isPragmatic = false,
    this.displayName = '',
    this.urlImg = '',
    this.email = '',
    this.accessToken,
  });


  UserModel copyWith({
    String? email,
    displayName,
    urlImg,
    String? newAccessToken,
  }) {
    return UserModel(
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      urlImg: urlImg ?? this.urlImg,
      accessToken: newAccessToken ?? accessToken,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is UserModel &&
        other.runtimeType == runtimeType &&
        other.hashCode == hashCode;
  }

  @override
  int get hashCode => '$email$displayName$urlImg$accessToken'.hashCode;
}
