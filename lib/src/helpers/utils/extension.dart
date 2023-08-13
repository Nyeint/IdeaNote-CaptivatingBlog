extension Extension on String{
  bool isStringValid(){
    RegExp pattern = RegExp(r'^[a-zA-Z0-9]+$');
    return pattern.hasMatch(this);
  }
}