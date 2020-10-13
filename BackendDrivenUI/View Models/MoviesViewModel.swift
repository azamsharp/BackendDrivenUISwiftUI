//
//  MoviesViewModel.swift
//  BackendDrivenUI
//
//  Created by Mohammad Azam on 10/13/20.
//

import Foundation

class MoviesViewModel: ObservableObject {
    
    @Published var templates: [UITemplate] = []
    
   func load() {
            
    guard let sharedTemplate = SharedTemplate.load(pageName: "moviesScreen") else {
        fatalError("Unable to load the shared template!")
    }
    
    sharedTemplate.templates.forEach { template in
        
        switch template.type {
            case .roundedImage:
                guard let roundedImageModel: RoundedImageModel = template.data.decode() else { return }
                DispatchQueue.main.async {
                    self.templates.append(RoundedImageTemplate(model: roundedImageModel))
                }
            case .gradientBox:
                guard let gradientBoxModel: GradientBoxModel = template.data.decode() else { return }
                DispatchQueue.main.async {
                    self.templates.append(GradientBoxTemplate(model: gradientBoxModel))
                }
        }
        
    }
        
   }
    
}
