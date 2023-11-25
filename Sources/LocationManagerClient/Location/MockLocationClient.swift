import CoreLocation

public final class MockLocationClient: NSObject, LocationDelegate {
  private let mockLocation: CLLocation
  public init(location: CLLocation = .init(latitude: 37.334633, longitude: -122.012682)) {
    self.mockLocation = location
    super.init()
  }

  public func currentLocation() async throws -> CLLocation { mockLocation }
}
