class User {
  String? uid;
  String? avatar;
  String? email;
  String? displayName;
  bool? emailActive;
  double? carbonReduction;
  int? point;

  User({
    this.uid,
    this.avatar,
    this.email,
    this.displayName,
    this.emailActive,
    this.carbonReduction,
    this.point,
  });

  User.fromJson(Map<String, dynamic> json) {
    uid = json['uid'];
    avatar = json['avatar'];
    email = json['email'];
    displayName = json['display_name'];
    emailActive = json['email_active'];
    carbonReduction = json['carbon_reduction'];
    point = json['point'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['uid'] = uid;
    data['avatar'] = avatar;
    data['email'] = email;
    data['display_name'] = displayName;
    data['email_active'] = emailActive;
    data['carbon_reduction'] = carbonReduction;
    data['point'] = point;
    return data;
  }

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.uid == uid;
  }

  @override
  int get hashCode => uid.hashCode;
}
