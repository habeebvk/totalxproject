class UserModel {
  final String name;
  final int age;
  final String image;
  final String phoneNumber;

  UserModel({
    required this.name,
    required this.age,
    required this.image,
    required this.phoneNumber,
  });

  Map<String, dynamic> toFirestore() {
    return {
      "name": name,
      "age": age,
      "image": image,
      "phoneNumber": phoneNumber,
    };
  }

  factory UserModel.fromFirestore(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      age: data['age'] ?? 0,
      image: data['image'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
    );
  }
}
