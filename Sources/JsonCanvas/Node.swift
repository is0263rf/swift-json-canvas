//
//  Node.swift
//  JsonCanvas
//
//  Created by Yoshinori Takada on 2024/10/16.
//

public struct Node: Codable {
    public struct TextType: Codable {
        var text: String
    }

    public struct FileType: Codable {
        var file: String
        var subpath: String?
    }

    public struct LinkType: Codable {
        var url: String
    }

    public enum BackgroundStyle: String, Codable {
        case cover
        case ratio
        case `repeat`
    }

    public struct GroupType: Codable {
        var label: String?
        var background: String?
        var backgroundStyle: BackgroundStyle?
    }

    public enum NodeType: Codable {
        case text(TextType)
        case file(FileType)
        case link(LinkType)
        case group(GroupType)
    }

    var id: String
    var type: NodeType
    var x: Int
    var y: Int
    var width: Int
    var height: Int
    var color: String?

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case text
        case file
        case subpath
        case url
        case label
        case background
        case backgroundStyle
        case x
        case y
        case width
        case height
        case color
    }

    public init(from decoder: any Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(String.self, forKey: .id)
        let nodeType = try container.decode(String.self, forKey: .type)
        switch nodeType {
        case "text":
            let text = try container.decode(String.self, forKey: .text)
            let textType = TextType(text: text)
            self.type = .text(textType)
        case "file":
            let file = try container.decode(String.self, forKey: .file)
            let subpath = try container.decodeIfPresent(String.self, forKey: .subpath)
            let fileType = FileType(file: file, subpath: subpath)
            self.type = .file(fileType)
        case "link":
            let url = try container.decode(String.self, forKey: .url)
            let linkType = LinkType(url: url)
            self.type = .link(linkType)
        case "group":
            let label = try container.decodeIfPresent(String.self, forKey: .label)
            let background = try container.decodeIfPresent(String.self, forKey: .background)
            let backgroundStyle = try container.decodeIfPresent(
                BackgroundStyle.self, forKey: .backgroundStyle)
            let groupType = GroupType(
                label: label, background: background, backgroundStyle: backgroundStyle)
            self.type = .group(groupType)
        default:
            throw DecodingError.dataCorruptedError(
                forKey: .type, in: container, debugDescription: "Invalid node type")
        }
        self.x = try container.decode(Int.self, forKey: .x)
        self.y = try container.decode(Int.self, forKey: .y)
        self.width = try container.decode(Int.self, forKey: .width)
        self.height = try container.decode(Int.self, forKey: .height)
        self.color = try container.decodeIfPresent(String.self, forKey: .color)
    }

    public func encode(to encoder: any Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.id, forKey: .id)
        switch self.type {
        case .text(let text):
            try container.encode("text", forKey: .type)
            try container.encode(text.text, forKey: .text)
        case .file(let file):
            try container.encode("file", forKey: .type)
            try container.encode(file.file, forKey: .file)
            try container.encodeIfPresent(file.subpath, forKey: .subpath)
        case .link(let link):
            try container.encode("link", forKey: .type)
            try container.encode(link.url, forKey: .url)
        case .group(let group):
            try container.encode("group", forKey: .type)
            try container.encodeIfPresent(group.label, forKey: .label)
            try container.encodeIfPresent(group.background, forKey: .background)
            try container.encodeIfPresent(group.backgroundStyle, forKey: .backgroundStyle)
        }
    }
}
