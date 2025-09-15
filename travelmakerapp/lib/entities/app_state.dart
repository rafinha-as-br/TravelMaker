
/// The status of the application
enum AppStatus{

  /// when the app is starting
  initializing,

  /// when the app does not have GPS
  needGPS,

  /// when there isn't a user activated
  userNotActive,

  /// when the database has a error (error on creating the table for example)
  errorDatabase,

  /// when the app is ready and can go to home screen
  ready,

  /// when the user is editing a travel
  editingTravel,

  /// when the user is creating a travel
  creatingTravel
}
