class UserModel {
  String? uid;
  String? email;
  String? fullName;
  String? password;
  String? cnic;
  String? profileImageReference;
  String? city;
  String? profession;
  String? mobileNumber;
  String? category;
  String? bikeNumber;
  String? address;
  String? shopImageReference;
  String? shopName;
  String? rating;
  UserModel(
      {this.uid,
      this.email,
      this.fullName,
      this.password,
      this.cnic,
      this.profileImageReference,
      this.city,
      this.mobileNumber,
      this.profession,
        this.category,
        this.address,
        this.bikeNumber,
      this.shopImageReference,
      this.shopName,
      this.rating});

  // receiving data from server
  factory UserModel.fromMapRegsitration(map) {
    return UserModel(

      email: map['email'],
      fullName: map['fullName'],
      password: map['password'],
      cnic: map['cnic'],
      profileImageReference: map['profileImageReference'],
      profession: map['profession'],
    );
  }
  factory UserModel.fromMapMechanicRegistration(map) {
    return UserModel(

        email: map['email'],
        fullName: map['fullName'],
        password: map['password'],
        cnic: map['cnic'],
        profileImageReference: map['profileImageReference'],
        city: map['city'],
        profession: map['profession'],
        mobileNumber: map['mobileNumber']);
  }
  factory UserModel.fromMapRiderRegistration(map) {
    return UserModel(
        email: map['email'],
        fullName: map['fullName'],
        password: map['password'],
        cnic: map['cnic'],
        profileImageReference: map['profileImageReference'],
        city: map['city'],
        profession: map['profession'],
        mobileNumber: map['mobileNumber'],
        address: map['address'],
        bikeNumber: map['bikeNumber']
    );
  }
  // sending data to our server
  Map<String, dynamic> toMapRegistrationDetails() {
    return {
      'email': email,
      'fullName': fullName,
      'password': password,
      'cnic': cnic,
      'profileImageReference': profileImageReference,
      'profession': profession,
    };
  }

  Map<String, dynamic> toMapUpdateVisitorRegistration() {
    return {
      'fullName': fullName,
      'cnic': cnic,
      'profileImageReference': profileImageReference,
    };
  }

  Map<String, dynamic> toMapUpdateMechanicRegistration() {
    return {
      'fullName': fullName,
      'cnic': cnic,
      'profileImageReference': profileImageReference,
      'city': city,
      'mobileNumber': mobileNumber,
    };
  }

  Map<String, dynamic> toBecomeMechanicRegistration() {
    return {
      'mobileNumber': mobileNumber,
      'city': city,
      'email': email,
      'fullName': fullName,
      'password': password,
      'cnic': cnic,
      'profileImageReference': profileImageReference,
      'profession': profession,
    };
  }
  Map<String, dynamic> toBecomeShopOwnerRegistration() {
    return {
      'mobileNumber': mobileNumber,
      'city': city,
      'email': email,
      'fullName': fullName,
      'password': password,
      'cnic': cnic,
      'profileImageReference': profileImageReference,
      'profession': profession,
      'shopName': shopName,
      'shopImageReference':shopImageReference,
      'rating':rating
    };
  }
  Map<String, dynamic> toBecomeRiderRegistration() {
    return {
      'mobileNumber': mobileNumber,
      'city': city,
      'email': email,
      'fullName': fullName,
      'password': password,
      'cnic': cnic,
      'profileImageReference': profileImageReference,
      'profession': profession,
      'bikeNumber': bikeNumber,
      'address' : address,
    };
  }
  Map<String, dynamic> toMechanicCategoryRegistration() {
    return {
      'category':category,
    };
  }
}
