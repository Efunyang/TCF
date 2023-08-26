class Auth {
  String? uid;
  String? token;
  String? refresh;

  Auth({this.uid, this.token, this.refresh});

  Auth.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    token = json['token'];
    refresh = json['refresh'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['token'] = token;
    data['refresh'] = refresh;
    return data;
  }

  @override
  bool operator ==(covariant Auth other) {
    if (identical(this, other)) return true;

    return other.uid == uid && other.token == token && other.refresh == refresh;
  }

  @override
  int get hashCode => uid.hashCode ^ token.hashCode ^ refresh.hashCode;

  @override
  String toString() => 'Auth(uid: $uid, token: $token, refresh: $refresh)';

  Auth copyWith({
    String? uid,
    String? token,
    String? refresh,
  }) {
    return Auth(
      uid: uid ?? this.uid,
      token: token ?? this.token,
      refresh: refresh ?? this.refresh,
    );
  }
}
