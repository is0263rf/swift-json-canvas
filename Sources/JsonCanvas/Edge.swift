//
//  Edge.swift
//  JsonCanvas
//
//  Created by Yoshinori Takada on 2024/10/16.
//

public struct Edge: Codable {
    public enum FromSide: String, Codable {
        case top
        case right
        case bottom
        case left
    }

    public enum FromEnd: String, Codable {
        case none
        case arrow
    }

    public enum ToSide: String, Codable {
        case top
        case right
        case bottom
        case left
    }

    public enum ToEnd: String, Codable {
        case none
        case arrow
    }

    var id: String
    var fromNode: String
    var fromSide: FromSide?
    var fromEnd: FromEnd?
    var toNode: String
    var toSide: ToSide?
    var toEnd: ToEnd?
    var color: String?
    var label: String?
}
