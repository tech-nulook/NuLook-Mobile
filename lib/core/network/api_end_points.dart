

class ApiEndPoints {

  static const baseUrl = "http://3.6.64.35:8000";

  static String postRequestOTP() {
    //http://3.6.64.35:8000/auth/customer/request-otp
    return "/auth/customer/request-otp";
  }
  static String postVerifyOTP() {
    return "/auth/customer/verify-otp";
  }
  static String postLogin() {
    return "/auth/login";
  }
  static String postSignUp() {
    return "/customer/profile";
  }

  ///customer/details
  static String getCustomerDetails() {
    return "/customer/details";
  }

  static String getQuestion() {
    return "/customer/questions";
  }
  static String postFileUpload() {
    return "/file-upload/upload/images/?folder=mobile";
  }
  //http://3.6.64.35:8000/customer/vendors
  static String getVendorsAsListOfSalon() {
    return "/customer/vendors";
  }
  //http://3.6.64.35:8000/customer/packages?vendor_id=1
  static String getVendorPackages() {
    return "/customer/packages";
  }
  //http://3.6.64.35:8000/tags?active_only=true&type=mood , occasion

  static String getTags({required String type}) {
    return "/tags?active_only=true&type=$type";
  }
}