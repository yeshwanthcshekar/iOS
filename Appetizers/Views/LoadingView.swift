//
//  LoadingView.swift
//  Appetizers
//
//  Created by Yeshwanth Chandrashekar on 2/10/25.
//

import SwiftUI

import SwiftUI

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color(.systemBackground)
                .ignoresSafeArea()
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: Color.brandPrimary))
                .scaleEffect(1.5)
        }
    }
}
#Preview {
    LoadingView()
}
