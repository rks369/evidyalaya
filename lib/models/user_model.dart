class UserModel {
  int id;
  String name;
  String email;
  String phone;
  String userName;
  String designation;
  String profilePicture;
  int currentClass;

  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone,
      required this.userName,
      required this.designation,
      required this.profilePicture,
      required this.currentClass});
}
