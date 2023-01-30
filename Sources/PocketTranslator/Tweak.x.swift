import Orion
import PocketTranslatorC

class SpringBoard_Hook: ClassHook<SpringBoard> {
    @Property (.nonatomic, .retain) var ptPresentationManager: PTPresentationManager? = .init()
    
    func applicationDidFinishLaunching(_ application: SBApplication) {
        orig.applicationDidFinishLaunching(application)
        ptPresentationManager = PTPresentationManager.shared
    }
}
