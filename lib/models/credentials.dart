class Credentials {
  
  String rollNumber;
  String password;

  Credentials(this.rollNumber, this.password);

  String get firebaseEmail => "$rollNumber@thapar.abstergo.me";
  String get firebasePassword => "$password@tu123";

}