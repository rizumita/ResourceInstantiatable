# ResourceInstantiatable

This framework is a helper for instantiating resources such as Storyboard, Nib and Plist.

## Install by Carthage

1. Create Cartfile
2. Add `github "rizumita/ResourceInstantiatable"` to Cartfile
3. Run `carthage update`

## How To Use

### Storyboard

```Swift
class StoryboardsManager {
    static let testViewController = StoryboardInstantiator<TestViewController>(name: "Test", bundle: NSBundle(forClass: StoryboardInstantiatorTests.self))
    static let secondaryViewController = StoryboardInstantiator<TestViewController>(name: "Test", bundle: NSBundle(forClass: StoryboardInstantiatorTests.self), identifier: "Secondary")
}

let testController = try? StoryboardsManager.testViewController.instantiate()
let secondaryController = try? StoryboardsManager.secondaryViewController.instantiate()
```

### Nib

```Swift
class NibsManager {
    static let testView = NibInstantiator<TestView>(name: "Test", bundle: NSBundle(forClass: NibInstantiatorTests.self))
}

let testView = try? NibsManager.testView.instantiate()
```

### File

```Swift
struct FilesManager {
    static let stringsPList = FileInstantiator<[String]>(name: "Strings", type: "plist", bundle: NSBundle(forClass: FileInstantiatorTests.self)) { NSArray(contentsOfFile: $0) as? [String] }
    static let dictPList = FileInstantiator<[String : String]>(name: "Dict", type: "plist", bundle: NSBundle(forClass: FileInstantiatorTests.self)) { NSDictionary(contentsOfFile: $0) as? [String : String] }
    static let textFile = FileInstantiator<String>(name: "Text", bundle: NSBundle(forClass: FileInstantiatorTests.self)) { try String(contentsOfFile: $0) }
}

let strings = try? FilesManager.stringsPList.instantiate()
let dict = try? FilesManager.dictPList.instantiate()
let text = try? FilesManager.textFile.instantiate()
```

### Configure instance after instantiating

If you configure an instance after instantiate, you can pass a configuration closure to the instantiate method.

```Swift
func configure(inout controller: TestViewController) {
    controller.message = "Configured"
}
let controller = try? StoryboardsManager.testViewController.instantiate(configure)
```

## License

MIT license
