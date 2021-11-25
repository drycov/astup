//User Model
class UserModel {
  final String uid;
  final String email;
  final String name;
  final String cn;
  final String post;
  final String firstName;
  final String middleName;
  final String lastName;
  final String photoUrl;

  UserModel(
      {required this.uid,
      required this.email,
      required this.name,
      required this.cn,
      required this.post,
      required this.firstName,
      required this.middleName,
      required this.lastName,
      required this.photoUrl});

  factory UserModel.fromMap(Map data) {
    return UserModel(
      uid: data['uid'],
      email: data['email'] ?? '',
      name: data['name'] ?? '',
      cn: data['cn'] ?? '',
      post: data['post'] ?? '',
      firstName: data['firstName'] ?? '',
      middleName: data['middleName'] ?? '',
      lastName: data['lastName'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "email": email,
        "name": name,
        "cn": cn,
        "post": post,
        "firstName": firstName,
        "middleName": middleName,
        "lastName": lastName,
        "photoUrl": photoUrl
      };
}