
class RoomNameConstraint
{
  Function(String) _checkFunction;
  String _constraintMessage;

  RoomNameConstraint(Function(String) checkFunction, String constraintMessage)
  {
    _checkFunction = checkFunction;
    _constraintMessage = constraintMessage;
  }

  bool checkConstraint(String value)
  {
    return _checkFunction(value);
  }

  String getMessage()
  {
    return _constraintMessage;
  }

}