//
//  NetworkRoutes.swift
//
//
//  Created by Kyrylo Mukha on 01.03.2023.
//

import Foundation

enum OpenAIHTTPMethod: String {
	case get = "GET"
	case post = "POST"
	case put = "PUT"
	case patch = "PATCH"
	case delete = "DELETE"
	case head = "HEAD"
	case options = "OPTIONS"
	case connect = "CONNECT"
	case trace = "TRACE"
}

typealias OpenAIHeaders = [String: String]

@available(swift 5.5)
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
protocol Endpoint {
	var route: String { get }
	var method: OpenAIHTTPMethod { get }
	func urlPath(for aiKit: OpenAIKit) -> String
}

@available(swift 5.5)
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)

protocol EndpointProvider {
    var completionsRoute: String { get set }
    var chatCompletionsRoute: String { get set }
    var editsRoute: String { get set }
    var dalleImageRoute: String { get set }
    var dalleImageEditRoute: String { get set }
}

public struct OpenAIKitEndpointProvider: EndpointProvider {
    var completionsRoute: String
    var chatCompletionsRoute: String
    var editsRoute: String
    var dalleImageRoute: String
    var dalleImageEditRoute: String
}


enum OpenAIEndpoint {
	case completions
	case chatCompletions
	case edits
	case dalleImage
	case dalleImageEdit
    
    static var completionsRoute: String = "/v1/completions"
    static var chatCompletionsRoute: String = "/v1/chat/completions"
    static var editsRoute: String = "/v1/edits"
    static var dalleImageRoute: String = "/v1/images/generations"
    static var dalleImageEditRoute: String = "/v1/images/edits"
}

@available(swift 5.5)
@available(macOS 10.15, iOS 13, watchOS 6, tvOS 13, *)
extension OpenAIEndpoint: Endpoint {
	var route: String {
		switch self {
		case .completions:
            return Self.completionsRoute
		case .chatCompletions:
            return Self.chatCompletionsRoute
		case .edits:
            return Self.editsRoute
		case .dalleImage:
            return Self.dalleImageRoute
		case .dalleImageEdit:
            return Self.dalleImageEditRoute
		}
	}

	var method: OpenAIHTTPMethod {
		switch self {
		default:
			return .post
		}
	}

	private var baseURL: String {
		switch self {
		default:
			return "https://api.openai.com"
		}
	}

	func urlPath(for aiKit: OpenAIKit) -> String {
		(aiKit.customOpenAIURL ?? baseURL) + route
	}
}

extension OpenAIEndpoint: EndpointProvider {
    var completionsRoute: String {
        get {
            return Self.completionsRoute
        }
        set {
            Self.completionsRoute = newValue
        }
    }
    
    var chatCompletionsRoute: String {
        get {
            return Self.chatCompletionsRoute
        }
        set {
            Self.chatCompletionsRoute = newValue
        }
    }
    
    var editsRoute: String {
        get {
            return Self.editsRoute
        }
        set {
            Self.editsRoute = newValue
        }
    }
    
    var dalleImageRoute: String {
        get {
            return Self.dalleImageRoute
        }
        set {
            Self.dalleImageRoute = newValue
        }
    }
    
    var dalleImageEditRoute: String {
        get {
            return Self.dalleImageEditRoute
        }
        set {
            Self.dalleImageEditRoute = newValue
        }
    }
}
