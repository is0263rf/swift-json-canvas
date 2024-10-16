# swift-json-canvas

Swift library for [JSON Canvas Spec](https://jsoncanvas.org/spec/1.0/).

## What is JSON Canvas?
see https://jsoncanvas.org/

## Install
You can use via Swift package manager.

## Example
This library provides `JsonCanvas` struct. Use `JSONDecoder` to read `.canvas` file.

```swift
import Foundation
import JsonCanvas

let decoder = JSONDecoder()
let jsonData = Data(json.utf8)
let canvas = try decoder.decode(JsonCanvas.self, from: jsonData)
```

## Author
Yoshinori Takada

## License
see [LICENSE](./LICENSE)
