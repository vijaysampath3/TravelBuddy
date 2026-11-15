import 'package:flutter/material.dart';

class DayAvailability {
  bool isEnabled;
  String startTime;
  String endTime;

  DayAvailability({
    required this.isEnabled,
    required this.startTime,
    required this.endTime,
  });
}

class BuddyRegistrationData extends ChangeNotifier {
  // Screen 1: Login
  String loginEmail = '';
  String loginPhone = '';
  String loginPassword = '';
  bool rememberMe = false;
  bool isBuddyPortalActive = false;

  // Screen 2: Identity Verification
  String governmentIdType = '';
  String aadhaarNumber = '';
  bool frontUploaded = false;
  bool backUploaded = false;
  bool selfieUploaded = false;

  // Screen 3: Personal Details
  String fullName = '';
  String mobileNumber = '';
  String dateOfBirth = '';
  String emailAddress = '';
  String password = '';
  List<String> emailOtp = ['', '', '', '', '', ''];
  List<String> mobileOtp = ['', '', '', '', '', ''];

  // Screen 4: Professional Details & Interests
  String city = '';
  List<String> areasCovered = [];
  List<String> selectedInterests = [];
  String guideExperience = '';
  String aboutMe = '';

  Map<String, DayAvailability> weeklyAvailability = {
    'Mon': DayAvailability(isEnabled: false, startTime: '09:00 AM', endTime: '05:00 PM'),
    'Tue': DayAvailability(isEnabled: false, startTime: '09:00 AM', endTime: '05:00 PM'),
    'Wed': DayAvailability(isEnabled: false, startTime: '09:00 AM', endTime: '05:00 PM'),
    'Thu': DayAvailability(isEnabled: false, startTime: '09:00 AM', endTime: '05:00 PM'),
    'Fri': DayAvailability(isEnabled: false, startTime: '09:00 AM', endTime: '05:00 PM'),
    'Sat': DayAvailability(isEnabled: false, startTime: '09:00 AM', endTime: '05:00 PM'),
    'Sun': DayAvailability(isEnabled: false, startTime: '09:00 AM', endTime: '05:00 PM'),
  };

  void updateGovernmentIdType(String val) {
    governmentIdType = val;
    notifyListeners();
  }

  void updateAadhaarNumber(String val) {
    aadhaarNumber = val;
    notifyListeners();
  }

  void toggleFrontUpload(bool val) {
    frontUploaded = val;
    notifyListeners();
  }

  void toggleBackUpload(bool val) {
    backUploaded = val;
    notifyListeners();
  }

  void toggleSelfieUpload(bool val) {
    selfieUploaded = val;
    notifyListeners();
  }

  void addArea(String area) {
    if (area.isNotEmpty && !areasCovered.contains(area)) {
      areasCovered.add(area);
      notifyListeners();
    }
  }

  void removeArea(String area) {
    areasCovered.remove(area);
    notifyListeners();
  }

  void toggleInterest(String interest) {
    if (selectedInterests.contains(interest)) {
      selectedInterests.remove(interest);
    } else {
      selectedInterests.add(interest);
    }
    notifyListeners();
  }

  void updateDayAvailability(String day, bool enabled) {
    if (weeklyAvailability.containsKey(day)) {
      weeklyAvailability[day]!.isEnabled = enabled;
      notifyListeners();
    }
  }

  void updateDayTime(String day, {String? start, String? end}) {
    if (weeklyAvailability.containsKey(day)) {
      if (start != null) weeklyAvailability[day]!.startTime = start;
      if (end != null) weeklyAvailability[day]!.endTime = end;
      notifyListeners();
    }
  }
}

// InheritedProvider for simple state access
class RegistrationScope extends InheritedWidget {
  final BuddyRegistrationData data;

  const RegistrationScope({
    super.key,
    required this.data,
    required super.child,
  });

  static BuddyRegistrationData of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<RegistrationScope>();
    assert(scope != null, 'No RegistrationScope found in context');
    return scope!.data;
  }

  @override
  bool updateShouldNotify(RegistrationScope oldWidget) => true;
}

