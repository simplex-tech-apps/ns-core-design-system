//
//  NARupeesLabel.swift
//  NammaAppUI
//
//  Created by apple on 10/09/25.
//

import SwiftUI

public struct NALabel: View {
    // Stored Properties
    var labelType: NALabelTypes
    var isNegativeValue: Bool
    
    // Initializer
    public init(labelType: NALabelTypes, isNegativeValue: Bool = false) {
        self.labelType = labelType
        self.isNegativeValue = isNegativeValue
    }
    
    public var body: some View {
        switch labelType {
        case .checkoutDetails(let icon, title: let title, subtitle: let subtitle):
            HStack {
                if(icon != "") {
                    Image(systemName: icon).resizable().scaledToFit().frame(width: 14, height: 14).padding(.trailing)
                }
                Text(title)
                    .font(.system(size: 12, weight: .regular))
                + Text("  \(subtitle)")
                    .font(.system(size: 12, weight: .medium))
                    .foregroundColor(.black)
            }
        case .orderDetails(let title, let subtitle):
            VStack(alignment: .leading, spacing: 2) {
                Text(title)
                    .font(.system(size: 10, weight: .medium))
                Text(subtitle)
                    .font(.system(size: 10, weight: .regular))
                    .foregroundColor(.black)
            }
        case .rupess(let displayRupeesFor, let textColor, let amount, let isStrikedOut):
            NARupeesLabel(displayRupeesFor: displayRupeesFor, textColor: textColor, amount: amount, isStrikedOut: isStrikedOut, isNegativeValue: isNegativeValue)
        }
    }
}

public struct NARupeesLabel: View {
    
    // Stored Propertie
    var displayRupeesFor: DisplayRupeesFor
    var textColor: Color
    var amount: String
    var isStrikedOut: Bool
    var isNegativeValue: Bool
    
    public init(displayRupeesFor: DisplayRupeesFor = .productPrice, textColor: Color = .black, amount: String = "0", isStrikedOut: Bool = false, isNegativeValue: Bool = false) {
        self.displayRupeesFor = displayRupeesFor
        self.textColor = textColor
        self.amount = amount
        self.isStrikedOut = isStrikedOut
        self.isNegativeValue = isNegativeValue
    }
    
    public var body: some View {
        HStack(spacing: 0) {
            Text(isNegativeValue ? "-" : "").fontWeight(.medium).font(.system(size: displayRupeesFor.fontSize))
            Image(systemName: "indianrupeesign").resizable().scaledToFit().frame(width: displayRupeesFor.imageDimensions, height: displayRupeesFor.imageDimensions)
            ZStack {
                Text(amount).fontWeight(displayRupeesFor.fontWeight).font(.system(size: displayRupeesFor.fontSize))
                Rectangle()
                    .frame(height: isStrikedOut ? 1 : 0)
            }.fixedSize()
        }.foregroundStyle(isStrikedOut ? Color.gray : textColor)
    }
}

public enum DisplayRupeesFor {
    
    case placeOrder, productPrice, totalBill, amountSaved, orderedProductPrice, billDetails
    
    public var fontWeight: Font.Weight {
        switch self {
        case .billDetails:
            Font.Weight.regular
        default:
            Font.Weight.medium
        }
    }
    
    public var imageDimensions: CGFloat {
        switch self {
        case .placeOrder:
            return 10
        case .productPrice, .billDetails:
            return 8
        case .amountSaved, .orderedProductPrice:
            return 6
        case .totalBill:
            return 8
        }
    }
    
    public var fontSize: CGFloat {
        switch self {
        case .placeOrder:
            return 16
        case .productPrice, .totalBill:
            return 14
        case .billDetails:
            return 12
        case .amountSaved, .orderedProductPrice:
            return 10
        }
    }
}

public enum NALabelTypes {
    case checkoutDetails(icon: String, title: String, subtitle: String)
    case orderDetails(title: String, subtitle: String)
    case rupess(displayRupeesFor: DisplayRupeesFor, textColor: Color, amount: String, isStrikedOut: Bool)
}

#Preview {
    NALabel(labelType: .rupess(displayRupeesFor: .totalBill, textColor: .black, amount: "343", isStrikedOut: true))
}
