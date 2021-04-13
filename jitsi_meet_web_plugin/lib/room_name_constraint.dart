/// RoomNameConstraint
/// Constrain validator for the RoomNameConstraintType
class RoomNameConstraint {
  late Function(String) _checkFunction;
  late String _constraintMessage;

  ///
  RoomNameConstraint(Function(String) checkFunction, String constraintMessage) {
    _checkFunction = checkFunction;
    _constraintMessage = constraintMessage;
  }

  //// Checker for the constrain
  bool checkConstraint(String value) {
    return _checkFunction(value);
  }

  /// get message
  String getMessage() {
    return _constraintMessage;
  }
}
