class BookMechanicModel {
  String? customerName;
  String? mechanicName;
  String? status;
  String? paymentType;
  String? currentLocation;
  BookMechanicModel(
      {this.customerName,
        this.paymentType,
        this.mechanicName,
        this.status,this.currentLocation});

  // receiving data from server
  factory BookMechanicModel.fromBookingMechanic(map) {
    return BookMechanicModel(

      customerName: map['customerName'],
      mechanicName: map['mechanicName'],
      status: map['status'],
      paymentType: map['paymentType'],
      currentLocation: map['currentLocation']

    );
  }
  // sending data to our server
  Map<String, dynamic> toMapBooking() {
    return {
      'customerName': customerName,
      'mechanicName': mechanicName,
      'status': status,
      'paymentType': paymentType,
      'currentLocation':currentLocation,
    };
  }
  Map<String, dynamic> toUpdateStatus() {
    return {
      'status': status,

    };
  }
}
