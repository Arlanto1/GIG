class RefreshTokenRequest {
  final JwtRefreshRequest? jwtRefreshRequest;

  RefreshTokenRequest({
    this.jwtRefreshRequest,
  });

  RefreshTokenRequest.fromJson(Map<String, dynamic> json)
      : jwtRefreshRequest =
            (json['jwtRefreshRequest'] as Map<String, dynamic>?) != null
                ? JwtRefreshRequest.fromJson(
                    json['jwtRefreshRequest'] as Map<String, dynamic>)
                : null;

  Map<String, dynamic> toJson() =>
      {'jwtRefreshRequest': jwtRefreshRequest?.toJson()};
}

class JwtRefreshRequest {
  final String? token;
  final String? refreshToken;

  JwtRefreshRequest({
    this.token,
    this.refreshToken,
  });

  JwtRefreshRequest.fromJson(Map<String, dynamic> json)
      : token = json['token'] as String?,
        refreshToken = json['refreshToken'] as String?;

  Map<String, dynamic> toJson() =>
      {'token': token, 'refreshToken': refreshToken};
}
