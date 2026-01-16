class SignupModel {
  String? name;
  String? phoneNumber;
  String? email;
  String? gender;
  String? dob;
  String? location;
  String? picture;

  SignupModel(
      {this.name,
        this.phoneNumber,
        this.email,
        this.gender,
        this.dob,
        this.location,
      this.picture});

  SignupModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    location = json['location'];
    picture = json['picture'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['location'] = this.location;
    data['picture'] = this.picture;
    return data;
  }
}