import CoreLocation

public final class LiveAuthorizationClient: NSObject, AuthorizationDelegate {
  private let locationManager: CLLocationManager
  private var monitorContinuation: AsyncStream<CLAuthorizationStatus>.Continuation?
  private var statusHandler: ((CLAuthorizationStatus) -> Void)?

  override public init() {
    self.locationManager = CLLocationManager()
    super.init()
    locationManager.delegate = self
  }

  public func authorizationStatus() -> CLAuthorizationStatus {
    locationManager.authorizationStatus
  }

  public func locationServiceEnabled() async -> Bool {
    CLLocationManager.locationServicesEnabled()
  }

  public func startMonitor() -> AsyncStream<CLAuthorizationStatus> {
    AsyncStream { [weak self] continuation in
      self?.monitorContinuation = continuation
      self?.statusHandler = { status in
        self?.monitorContinuation?.yield(status)
      }
    }
  }

  public func stopMonitor() {
    self.statusHandler = nil
    self.monitorContinuation?.finish()
  }

  public func requestAuthorizationStatus() {
    if case .authorizedWhenInUse = authorizationStatus() {
      self.locationManager.requestAlwaysAuthorization()
    } else {
      self.locationManager.requestWhenInUseAuthorization()
    }
  }
}

extension LiveAuthorizationClient: CLLocationManagerDelegate {
  public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
    statusHandler?(manager.authorizationStatus)
  }
}
