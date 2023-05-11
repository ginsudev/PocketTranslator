import Orion
import PocketTranslatorC

struct PocketTranslator: Tweak {
    private let presentationManager: PTPresentationManager
    
    init()  {
        self.presentationManager = .shared
    }
}
