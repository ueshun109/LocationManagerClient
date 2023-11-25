import CoreLocation

public final class MockAuthorizationClient: NSObject, AuthorizationDelegate {
  private let mockStatus: CLAuthorizationStatus
  private let locationServiceEnabled: Bool
  private let monitorInterval: TimeInterval
  private var monitorContinuation: AsyncStream<CLAuthorizationStatus>.Continuation?

  public init(
    mockStatus: CLAuthorizationStatus = .notDetermined,
    locationServiceEnabled: Bool = true,
    monitorInterval: TimeInterval = 0.5
  ) {
    self.mockStatus = mockStatus
    self.locationServiceEnabled = locationServiceEnabled
    self.monitorInterval = monitorInterval
    super.init()
  }

  public func authorizationStatus() -> CLAuthorizationStatus { mockStatus }

  public func locationServiceEnabled() async -> Bool { locationServiceEnabled }

  public func startMonitor() -> AsyncStream<CLAuthorizationStatus> {
    AsyncStream { continuation in
      let timer = Timer.scheduledTimer(withTimeInterval: monitorInterval, repeats: true) { _ in
        self.monitorContinuation = continuation
      }
    }
  }

  public func stopMonitor() {
    self.monitorContinuation?.finish()
  }

  public func requestAuthorizationStatus() {
    // NOP
  }
}
