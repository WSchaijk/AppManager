import Foundation
import AppKit

struct CSPOpenApplication {
    private var applicationInstance: NSRunningApplication
    private var applicationName: String
    private var applicationPath: CSPUrl
    private var applicationType: CSPApplicationType
    
    public init(applicationInstance: NSRunningApplication, applicationType: CSPApplicationType) {
        self.applicationInstance = applicationInstance
        self.applicationName = applicationInstance.localizedName!
        self.applicationPath = CSPUrl(url: applicationInstance.bundleURL!)
        self.applicationType = applicationType
    }
    
    public func getAppName() -> String { return self.applicationName }
    public func getAppPath() -> String { return self.applicationPath.url.absoluteString }
    public func getAppType() -> CSPApplicationType { return self.applicationType }
    public func hideApp() { self.applicationInstance.hide() }
    public func closeApp(forceClose: Bool = false) -> Bool { return forceClose ? self.applicationInstance.forceTerminate() : self.applicationInstance.terminate() }
}
