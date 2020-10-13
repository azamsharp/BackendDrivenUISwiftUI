//
//  ContentView.swift
//  BackendDrivenUI
//
//  Created by Mohammad Azam on 10/13/20.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject private var vm: MoviesViewModel = MoviesViewModel()
    
    var body: some View {
        VStack {
            ForEach(vm.templates, id: \.uniqueId) { template in
                template.render() 
            }
        }
        
        .onAppear(perform: {
            vm.load()
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
