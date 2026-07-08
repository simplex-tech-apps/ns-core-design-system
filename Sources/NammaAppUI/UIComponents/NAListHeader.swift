//
//  NAListHeader.swift
//  NammaAppUI
//
//  Created by apple on 08/07/26.
//
import SwiftUI

struct ListHeaderViewV1: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.system(size: 16, weight: .medium))
            .padding(.horizontal, 16).padding(.vertical,8)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
