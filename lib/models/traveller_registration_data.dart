class TravellerRegistrationData {
  String fullName;
  String email;
  String password;
  String nationality;
  DateTime? dateOfBirth;
  String phoneNumber;
  String countryCode;
  String gender; // 'Male' | 'Female' | ''
  bool acceptedTerms;

  // Buddy preference fields
  List<String> languagesKnown;
  int preferredAgeMin;
  int preferredAgeMax;
  String preferredGender;
  String buddyBackground;
  List<String> interests;

  // Travel purpose & duration
  String travelPurpose;
  String stayDuration;

  // Passport & verification
  String passportNumber;
  String issuingCountry;
  DateTime? passportExpiryDate;
  bool isPassportVerified;

  TravellerRegistrationData({
    this.fullName = '',
    this.email = '',
    this.password = '',
    this.nationality = '',
    this.dateOfBirth,
    this.phoneNumber = '',
    this.countryCode = '+91',
    this.gender = '',
    this.acceptedTerms = false,
    List<String>? languagesKnown,
    this.preferredAgeMin = 18,
    this.preferredAgeMax = 45,
    this.preferredGender = '',
    this.buddyBackground = '',
    List<String>? interests,
    this.travelPurpose = 'Leisure / Tourism',
    this.stayDuration = 'Customizable',
    this.passportNumber = 'ESP-9844210-A',
    this.issuingCountry = 'India',
    this.passportExpiryDate,
    this.isPassportVerified = true,
  })  : languagesKnown = languagesKnown ?? [],
        interests = interests ?? [];
}

