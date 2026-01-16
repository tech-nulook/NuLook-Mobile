
class OtpModel {
  Customer? customer;
  String? accessToken;
  String? status;

  OtpModel({this.customer, this.accessToken});

  OtpModel.fromJson(Map<String, dynamic> json) {
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    accessToken = json['access_token'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['status'] = this.status;
    return data;
  }
}

class Customer {
  int? id;
  String? phoneNumber;

  Customer({this.id, this.phoneNumber});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phoneNumber = json['phone_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['phone_number'] = this.phoneNumber;
    return data;
  }
}