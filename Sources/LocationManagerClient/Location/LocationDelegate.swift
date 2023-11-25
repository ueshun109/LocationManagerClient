@_exported import CoreLocation

public protocol LocationDelegate {
  /// Return current location information.
  func currentLocation() async throws -> CLLocation
}
