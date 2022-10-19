class User {
  String? userUID;
  String? userName;
  String? userAvatarUrl;
  String? userEmail;
  User({this.userUID, this.userName, this.userAvatarUrl, this.userEmail});
  User.fromJson(Map<String, dynamic> json) {
    userUID = json['userUID'];
    userName = json['userName'];
    userAvatarUrl = json['userAvatarUrl'];
    userEmail = json['userEmail'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['userUID'] = this.userUID;
    data['userName'] = this.userName;
    data['userAvatarUrl'] = this.userAvatarUrl;
    data['userEmail'] = this.userEmail;
    return data;
  }
}
