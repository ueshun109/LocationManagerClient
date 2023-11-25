import CoreLocation

public final class LiveLocationClient: NSObject, LocationDelegate {
  private let locationManager: CLLocationManager
  private var locationContinuation: CheckedContinuation<CLLocation, Error>?

  public init(desiredAccuracy: CLLocationAccuracy = kCLLocationAccuracyBest) {
    self.locationManager = CLLocationManager()
    super.init()
    locationManager.delegate = self
    locationManager.desiredAccuracy = desiredAccuracy
  }

  public func currentLocation() async throws -> CLLocation {
    try await withCheckedThrowingContinuation { continuation in
      self.locationContinuation = locationContinuation
      self.locationManager.requestLocation()
    }
  }
}

extension LiveLocationClient: CLLocationManagerDelegate {
  public func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    self.locationContinuation?.resume(returning: location)
    self.locationContinuation = nil
  }

  public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    self.locationContinuation?.resume(throwing: error)
    self.locationContinuation = nil
  }
}

