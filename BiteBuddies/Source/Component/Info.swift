//
//  Info.swift
//  BiteBuddies
//
//  Created by Mercen on 8/3/24.
//

import SwiftUI

struct Info: View {
    let name: String
    let rate: Int
    let location: String
    var body: some View {
        VStack(spacing: 4) {
            HStack(spacing: 8) {
                Text(name)
                    .font(.system(size: 24, weight: .semibold))
                Image(systemName: "checkmark.seal.fill")
                    .resizable()
                    .frame(width: 15, height: 15)
                    .foregroundStyle(Color.accentColor)
            }
            HStack(spacing: 8) {
                Text("Average Rate")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(Color.gray)
                Rate(rate: .constant(rate))
                    .frame(height: 16)
            }
            Text(location)
                .font(.system(size: 12))
                .foregroundStyle(Color(.lightGray))
        }
        .padding(.vertical, 24)
    }
}
