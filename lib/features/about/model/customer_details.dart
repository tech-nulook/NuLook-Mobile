class CustomerDetails {
  String? status;
  Customer? customer;
  String? message;

  CustomerDetails({this.status, this.customer, this.message});

  CustomerDetails.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? phoneNumber;
  String? email;
  String? gender;
  String? dob;
  String? location;
  String? picture;
  Null? status;
  Null? userId;
  Null? userDetails;

  Customer(
      {this.id,
        this.name,
        this.phoneNumber,
        this.email,
        this.gender,
        this.dob,
        this.location,
        this.picture,
        this.status,
        this.userId,
        this.userDetails});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phoneNumber = json['phone_number'];
    email = json['email'];
    gender = json['gender'];
    dob = json['dob'];
    location = json['location'];
    picture = json['picture'];
    status = json['status'];
    userId = json['user_id'];
    userDetails = json['user_details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['phone_number'] = this.phoneNumber;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['dob'] = this.dob;
    data['location'] = this.location;
    data['picture'] = this.picture;
    data['status'] = this.status;
    data['user_id'] = this.userId;
    data['user_details'] = this.userDetails;
    return data;
  }
}