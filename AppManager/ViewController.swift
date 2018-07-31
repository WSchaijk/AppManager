import Cocoa

class ViewController: NSViewController {
    
    @IBOutlet weak var btnHideAll: NSButton!
    @IBOutlet weak var btnCloseAll: NSButton!
    
    private var workspace: CSPApplicationWorkspace = CSPApplicationWorkspace()
    
    override func viewDidLoad() { super.viewDidLoad() }
    override var representedObject: Any? { didSet { /* Update the view, if already loaded. */ } }
    
    @IBAction func hideAll(_ sender: Any) { workspace.hideApplications(hideActiveApplication: false) }
    @IBAction func closeAll(_ sender: Any) { workspace.closeApplications(closeActiveApplication: false, forceTerminate: false) }
}
