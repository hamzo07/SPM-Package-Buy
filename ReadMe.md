# Installation guide

 Copy url https://github.com/hamzo07/SPM-Package-Buy.git and paste in your SPM manager url section

# Usage
```swift
import MyLibrary

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ClientQuery.configureWith((apiKey: "<apiKey>", shopDomain: "<Shopify store Url>"))
        
        Task {
            let collection = await ClientQuery.manager.getCollections(withLimit: 20)
            print("[DEBUG] Collections are \(collection.count)")
        }
    }
}

```

