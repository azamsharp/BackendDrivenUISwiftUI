//
//  SharedTemplate.swift
//  BackendDrivenUI
//
//  Created by Mohammad Azam on 10/13/20.
//

import Foundation
import SwiftUI 

protocol UITemplate {
    var uniqueId: UUID { get }
    func render() -> AnyView
}

extension UITemplate {
    var uniqueId: UUID { UUID() }
}

enum TemplateType: String, Decodable {
    case roundedImage
    case gradientBox
}

struct RoundedImageModel: Codable {
    let title: String
    let imageURL: String
}

struct RoundedImageView: View {
    let model: RoundedImageModel
    var body: some View {
        VStack {
            URLImage(url: model.imageURL)
                .aspectRatio(contentMode: .fit)
                .clipShape(Circle())
            Text(model.title)
        }
    }
}

struct GradientBoxModel: Codable {
    let title: String
}

struct GradientBoxView: View {
    let model: GradientBoxModel
    var body: some View {
        HStack {
            Text(model.title)
        }.frame(width: 300, height: 300)
        .background(LinearGradient(gradient: Gradient(colors: [Color.red, Color.blue]), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
    }
}

struct GradientBoxTemplate: UITemplate {
    let model: GradientBoxModel
    
    func render() -> AnyView {
        GradientBoxView(model: model).toAnyView() 
    }
}


struct RoundedImageTemplate: UITemplate {
    let model: RoundedImageModel
    
    func render() -> AnyView {
        RoundedImageView(model: model).toAnyView()
    }
}

struct uiModel: Decodable {
    let type: TemplateType
    let data: [String: String]
}

struct SharedTemplate: Decodable {
    let pageTitle: String
    let templates: [uiModel]
}


extension SharedTemplate {
    
    static func load(pageName: String) -> SharedTemplate? {
        
        guard let jsonFilePath = Bundle.main.path(forResource: pageName, ofType: "json") else {
            fatalError("Unable to load JSON for \(pageName)")
        }
        
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: jsonFilePath)) else {
            fatalError("Unable to load data from \(jsonFilePath)")
        }
        
        return try? JSONDecoder().decode(SharedTemplate.self, from: data)
    }
    
}
