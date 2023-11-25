@_exported import CoreLocation

public protocol AuthorizationDelegate {
  /// The current authorization status for the app.
  /// - Returns: A value indicating whether the app is authorized to use location services.
  ///
  /// contains location service.
  func authorizationStatus() -> CLAuthorizationStatus

  /// Determines whether the user has location services enabled.
  /// - Returns: true if location services are enabled on the device; false if they are not.
  func locationServiceEnabled() async -> Bool

  /// Monitor location permission status changes.
  func startMonitor() -> AsyncStream<CLAuthorizationStatus>

  /// Stop monitoring location permission.
  func stopMonitor()

  /// Request authorization permisssion.
  func requestAuthorizationStatus()
}
