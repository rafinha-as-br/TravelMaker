/// validator entity, used for validating data
class Validator {
  ///
  const Validator(this.success, this.message);

  /// contains a success status
  final bool success;

  /// contains a message, in case of success, return null
  final String? message;
}