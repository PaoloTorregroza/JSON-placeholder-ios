//
//  ContentView.swift
//  JSON-placeholder-ios
//
//  Created by Paolo on 20/03/22.
//

import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        Home(viewModel: HomeViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
