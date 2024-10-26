class UserModel {
  final String uid; // User ID from Firebase
  final String username;
  final String email;


  UserModel({
    required this.uid,
    required this.username,
    required this.email,
    
  });

  // Convert a UserModel into a Map.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'email': email,
      
    };
  }

  // Create a UserModel from a Map.
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'],
      username: map['username'],
      email: map['email'],
     
    );
  }
}
