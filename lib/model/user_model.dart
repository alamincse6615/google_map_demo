class UserModel {
  String? uid;
  String? userPassword;
  String? phoneNumber;
  String? registeredBy;
  String? name;
  String? lon;
  String? userEmail;
  String? lat;
  String? userImage;

  UserModel(
      {this.uid,
        this.userPassword,
        this.phoneNumber,
        this.registeredBy,
        this.name,
        this.lon,
        this.userEmail,
        this.userImage,
        this.lat});

  UserModel.fromJson(Map<dynamic, dynamic> json) {
    uid = json['uid'].toString();
    userPassword = json['userPassword'].toString();
    phoneNumber = json['phoneNumber'].toString();
    registeredBy = json['registeredBy'].toString();
    name = json['name'].toString();
    lon = json['lon'].toString();
    userEmail = json['userEmail'].toString();
    userImage = json['userImage'].toString();
    lat = json['lat'].toString();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uid'] = this.uid;
    data['userPassword'] = this.userPassword;
    data['phoneNumber'] = this.phoneNumber;
    data['registeredBy'] = this.registeredBy;
    data['name'] = this.name;
    data['lon'] = this.lon;
    data['userEmail'] = this.userEmail;
    data['lat'] = this.lat;
    data['userImage'] = this.userImage;
    return data;
  }
}