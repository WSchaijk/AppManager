import Foundation
import AppKit

struct CSPApplicationWorkspace {
    private var workspace: NSWorkspace
    
    init() { self.workspace = NSWorkspace() }
    public mutating func refreshWorkspace() { self.workspace = NSWorkspace() }
    
    private func getOpenApplications(applicationType: CSPApplicationType, predicate: (NSRunningApplication) -> Bool) -> Array<CSPOpenApplication> {
        return self.workspace.runningApplications
            .filter(predicate)
            .map({ runningApp in CSPOpenApplication(applicationInstance: runningApp, applicationType: applicationType) })
    }
    
    private func applicationsAction(action: (NSRunningApplication) -> Void, predicate: (NSRunningApplication) -> Bool = { runningApp in true }) {
        for runningApp in workspace.runningApplications {
            if (predicate(runningApp)) {
                action(runningApp)
            }
        }
    }
    
    private func openApplicationsAction(applications: Array<CSPOpenApplication>, action: (CSPOpenApplication) -> Void) {
        if (applications.count > 0) {
            for application in applications {
                action(application)
            }
        }
    }
    
    public func getOpenApps() -> Array<CSPOpenApplication> {
        return getOpenApplications(
            applicationType: CSPApplicationType.App,
            predicate: { application in CSPUrl(url: application.bundleURL!).getFileExtension() == "app" && CSPUrl(url: application.bundleURL!).containsString(requestedString: ".app") == 1 && CSPUrl(url: application.bundleURL!).getFilePath() == "Applications/" }
        )
    }
    
    public func hideApplications(hideActiveApplication: Bool) {
        self.applicationsAction(
            action: { runningApp in runningApp.hide() },
            predicate: { runningApp in !(!hideActiveApplication && runningApp.isActive) }
        )
    }
    
    public func hideApplications(applicationsToHide: Array<CSPOpenApplication>) {
        self.openApplicationsAction(
            applications: applicationsToHide,
            action: { applicationToHide in applicationToHide.hideApp() }
        )
    }
    
    public func closeApplications(closeActiveApplication: Bool, forceTerminate: Bool) {
        self.applicationsAction(
            action: { runningApp in forceTerminate ? runningApp.terminate() : runningApp.forceTerminate() },
            predicate: { runningApp in !(!closeActiveApplication && runningApp.isActive) }
        )
    }
    
    public func closeApplications(applicationsToClose: Array<CSPOpenApplication>, forceTerminate: Bool) {
        self.openApplicationsAction(
            applications: applicationsToClose,
            action: { applicationToClose in applicationToClose.closeApp(forceClose: forceTerminate) }
        )
    }
}
