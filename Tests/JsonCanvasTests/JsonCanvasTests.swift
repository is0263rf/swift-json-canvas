import Foundation
import Testing

@testable import JsonCanvas

let json1 = #"""
    {
      "nodes": [
        {
          "id": "spec",
          "type": "file",
          "x": 600,
          "y": 140,
          "width": 480,
          "height": 480,
          "file": "spec/1.0.md"
        },
        {
          "id": "readme",
          "type": "file",
          "x": 36,
          "y": 240,
          "width": 480,
          "height": 580,
          "file": "readme.md"
        },
        {
          "id": "nav",
          "type": "text",
          "x": 336,
          "y": 36,
          "width": 182,
          "height": 168,
          "text": "Learn more:\n- [Apps](/docs/apps)\n- [Spec](/spec/1.0)\n- [GitHub](https://github.com/obsidianmd/jsoncanvas)"
        },
        {
          "id": "logo",
          "type": "file",
          "x": 36,
          "y": 48,
          "width": 176,
          "height": 68,
          "file": "logo.svg"
        }
      ],
      "edges": [
        {
          "id": "edge-readme-spec",
          "fromNode": "readme",
          "fromSide": "right",
          "fromEnd": "none",
          "toNode": "spec",
          "toSide": "left",
          "toEnd": "arrow"
        },
        {
          "id": "edge-logo-nav",
          "fromNode": "logo",
          "fromSide": "right",
          "fromEnd": "none",
          "toNode": "nav",
          "toSide": "left",
          "toEnd": "arrow"
        }
      ]
    }
    """#

@Test("Test nodes.") func testNodes() throws {
    let decoder = JSONDecoder()
    let jsonData = Data(json1.utf8)
    let canvas = try decoder.decode(JsonCanvas.self, from: jsonData)

    #expect(canvas.nodes?.count == 4)

    // nodes[0]
    #expect(canvas.nodes?[0].id == "spec")
    #expect(canvas.nodes?[0].x == 600)
    #expect(canvas.nodes?[0].y == 140)
    #expect(canvas.nodes?[0].width == 480)
    #expect(canvas.nodes?[0].height == 480)
    if case .file(let fileType) = canvas.nodes?[0].type {
        #expect(fileType.file == "spec/1.0.md")
    } else {
        #expect(Bool(false))
    }

    // nodes[1]
    #expect(canvas.nodes?[1].id == "readme")
    #expect(canvas.nodes?[1].x == 36)
    #expect(canvas.nodes?[1].y == 240)
    #expect(canvas.nodes?[1].width == 480)
    #expect(canvas.nodes?[1].height == 580)
    if case .file(let fileType) = canvas.nodes?[1].type {
        #expect(fileType.file == "readme.md")
    } else {
        #expect(Bool(false))
    }

    // nodes[2]
    #expect(canvas.nodes?[2].id == "nav")
    #expect(canvas.nodes?[2].x == 336)
    #expect(canvas.nodes?[2].y == 36)
    #expect(canvas.nodes?[2].width == 182)
    #expect(canvas.nodes?[2].height == 168)
    if case .text(let textType) = canvas.nodes?[2].type {
        let result =
            "Learn more:\n- [Apps](/docs/apps)\n- [Spec](/spec/1.0)\n- [GitHub](https://github.com/obsidianmd/jsoncanvas)"
        #expect(textType.text == result)
    } else {
        #expect(Bool(false))
    }

    // nodes[3]
    #expect(canvas.nodes?[3].id == "logo")
    #expect(canvas.nodes?[3].x == 36)
    #expect(canvas.nodes?[3].y == 48)
    #expect(canvas.nodes?[3].width == 176)
    #expect(canvas.nodes?[3].height == 68)
    if case .file(let fileType) = canvas.nodes?[3].type {
        #expect(fileType.file == "logo.svg")
    } else {
        #expect(Bool(false))
    }
}

@Test("Test edges.") func testEdges() throws {
    let decoder = JSONDecoder()
    let jsonData = Data(json1.utf8)
    let canvas = try decoder.decode(JsonCanvas.self, from: jsonData)

    #expect(canvas.edges?.count == 2)

    // edges[0]
    #expect(canvas.edges?[0].id == "edge-readme-spec")
    #expect(canvas.edges?[0].fromNode == "readme")
    #expect(canvas.edges?[0].fromSide == .right)
    #expect(canvas.edges?[0].fromEnd == .some(.none))
    #expect(canvas.edges?[0].toNode == "spec")
    #expect(canvas.edges?[0].toSide == .left)
    #expect(canvas.edges?[0].toEnd == .arrow)

    // edges[1]
    #expect(canvas.edges?[1].id == "edge-logo-nav")
    #expect(canvas.edges?[1].fromNode == "logo")
    #expect(canvas.edges?[1].fromSide == .right)
    #expect(canvas.edges?[1].fromEnd == .some(.none))
    #expect(canvas.edges?[1].toNode == "nav")
    #expect(canvas.edges?[1].toSide == .left)
    #expect(canvas.edges?[1].toEnd == .arrow)
}
