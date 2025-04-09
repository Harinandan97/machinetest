class UserModel {
  final String name;
  final String email;
  final Address address;

  UserModel({required this.name, required this.email, required this.address});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: "${json['name']['firstname']} ${json['name']['lastname']}",
      email: json['email'],
      address: Address.fromJson(json['address']),
    );
  }
}

class Address {
  final String city;
  final String street;
  final int number;
  final String zipcode;

  Address({
    required this.city,
    required this.street,
    required this.number,
    required this.zipcode,
  });

  factory Address.fromJson(Map<String, dynamic> json) {
    return Address(
      city: json['city'],
      street: json['street'],
      number: json['number'],
      zipcode: json['zipcode'],
    );
  }
}