class AccountModel {
  final String? name;
  final String? email;
  final String? phone;
  AccountModel({
    this.name,
    this.email,
    this.phone,
  });

  factory AccountModel.fromJson(Map<String, dynamic> json) {
    return AccountModel(
      email: json['email'],
      name: json['name'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = {
      'email': email,
      'name': name,
      'phone': phone,
    };
    return json;
  }
}
