class UserModel {
  late String email = '';
  String? uid;
  String name = 'Незнакомец';
  Set<String> roles = {'not_assigned'};

  UserModel({email, name, uid}) {
    this.email = email ?? '';
    this.name = name ?? '';
  }

  void update(Map<String, dynamic> data) {
    email = data['email'] ?? '';
    name = data['name'] ?? '';
    uid = data['uid'] ?? null;
  }

  Map<String, dynamic> get modelMap => {
    'name': name,
    'email': email,
    'uid': uid,
    'roles': roles,
  };

  @override
  String toString() {
    return 'uid - $uid \n name - $name \n email - $email \n roles - ${roles.toString}';
  }
}