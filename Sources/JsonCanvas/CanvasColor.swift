//
//  CanvasColor.swift
//  JsonCanvas
//
//  Created by Yoshinori Takada on 2024/10/16.
//

public enum PresetColor: Codable {
    case red
    case orange
    case yellow
    case green
    case cyan
    case purple
}

public enum CanvasColor: Codable {
    case hex(String)
    case preset(PresetColor)
}
