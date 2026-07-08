// The Swift Programming Language
// https://docs.swift.org/swift-book

import SwiftUI

public struct NAButton: View {
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var buttonType: NAButtonTypes
    var enableLoader: Bool = false
    var onTap: () -> Void
    
    //MARK: Observed Properties
    @Binding var input: String
    @Binding var showLoader: Bool
    
    public init(
        input: Binding<String>? = nil,
        showLoader: Binding<Bool>? = nil,
        enableLoader:Bool? = nil,
        buttonType: NAButtonTypes,
        onTap: @escaping () -> Void
    ) {
        self._input = input ?? Binding<String>.constant("")
        self._showLoader = showLoader ?? Binding<Bool>.constant(false)
        self.enableLoader = enableLoader ?? false
        self.buttonType = buttonType
        self.onTap = onTap
    }
    
    public var body: some View {
        switch buttonType {
        case .proceedForOTP(let foregroundColor, let backgroundColor, let imageName, let iconButtonShape):
            NAStaticButton(showLoader: $showLoader, staticButtonType: .icon(foregroundColor, backgroundColor, imageName, iconButtonShape), enableLoader: enableLoader) {
                onTap()
            }
        case .search:
            NAStaticButton(showLoader: $showLoader, staticButtonType: .search) {
                onTap()
            }
        case .shopNow:
            NAStaticButton(showLoader: $showLoader, staticButtonType: .capsule(takeFullWidth: false, title: "Shop now", icon: "chevron.forward", height: 30, backgroundColor: appTheme.current.secondary.opacity(0.1), foregroundColor: appTheme.current.secondary), onTap: onTap)
        case .placeOrder:
            NADynamicButton(input: $input, buttonType: .placeOrder, onTap: onTap)
        case .cartCount:
            NADynamicButton(input: $input, buttonType: .cartCount, onTap: onTap)
        case .plain(let fillType, let foregroundColor, let backgroundColor, let title):
            NAStaticButton(showLoader: $showLoader, staticButtonType: .plain(fillType, foregroundColor, backgroundColor, title)) {
                onTap()
            }
        case .showMore:
            Text("")
        case .showLess:
            Text("")
        case .addProduct:
            Text("")
        case .text(let icon, let title, let foregroundColor):
            NAStaticButton(showLoader: $showLoader, staticButtonType: .text(icon, title, foregroundColor)) {
                onTap()
            }
        case .increaseOrDecreaseQuantity:
            Text("")
        case .privacyPolicyCheckBox:
            NADynamicButton(input: $input, buttonType: .checkbox, onTap: onTap)
        case .privacyPolicyLink(let title):
            NAStaticButton(showLoader: $showLoader, staticButtonType: .link(title: title)) {
                onTap()
            }
        case .closeIcon(let foregroundColor, let backgroundColor, let imageName, let iconButtonShape):
            NAStaticButton(showLoader: $showLoader, staticButtonType: .icon(foregroundColor, backgroundColor, imageName, iconButtonShape), iconFrameSize: CGSize(width: 24, height: 24)) {
                onTap()
            }
        case .markFavouriteIcon(foregroundColor: let foregroundColor, backgroundColor: let backgroundColor, imageName: let imageName, iconButtonShape: let iconButtonShape):
            NAStaticButton(showLoader: $showLoader, staticButtonType: .icon(foregroundColor, backgroundColor, imageName, iconButtonShape), enableLoader: enableLoader, iconFrameSize: CGSize(width: 18, height: 17), buttonFrameSize: CGSize(width: 36, height: 36)) {
                onTap()
            }
        case .callIcon(foregroundColor: let foregroundColor, backgroundColor: let backgroundColor, imageName: let imageName, iconButtonShape: let iconButtonShape):
            NAStaticButton(showLoader: $showLoader, staticButtonType: .icon(foregroundColor, backgroundColor, imageName, iconButtonShape), enableLoader: enableLoader, iconFrameSize: CGSize(width: 16, height: 16), buttonFrameSize: CGSize(width: 36, height: 36)) {
                onTap()
            }
        case .shopOffer:
            NAStaticButton(showLoader: $showLoader, staticButtonType: .capsule(takeFullWidth: true, title: "Shop Offers", icon: "", height: 40, backgroundColor: appTheme.current.tertiary, foregroundColor: appTheme.current.onTertiary), onTap: onTap)
        }
    }
}

public struct NAStaticButton: View {
    //MARK: Observed Properties
    @Binding
    var showLoader: Bool
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var staticButtonType: StaticButtonTypes = StaticButtonTypes.plain(.filled, .white, .black, "")
    var enableLoader: Bool = false
    var iconFrameSize: CGSize = CGSize(width: 16, height: 14)
    var buttonFrameSize: CGSize = CGSize(width: 50, height: 50)
    var onTap: () -> Void
    
    public var body: some View {
        Button(action: {
            onTap()
        }) {
            switch staticButtonType {
            case .plain(_, _, _, let title):
                Text(title)
                    .fontWeight(.semibold)
                    .frame(maxWidth: .infinity)
            case .search:
                BTSearch(placeHolder: "Search your favourite meat", onTap: onTap)
            case .icon(let foregroundColor, let backgroundColor, let imageName, let iconButtonShape):
                ZStack {
                    if(showLoader && enableLoader) {
                        ProgressView().tint(.white)
                    } else {
                        Image(systemName: imageName).resizable().frame(width: iconFrameSize.width, height: iconFrameSize.height).foregroundStyle(foregroundColor)
                    }
                }
                .frame(width: buttonFrameSize.width, height: buttonFrameSize.height)
                .background(backgroundColor)
                .clipShape(iconButtonShape.shape)
            case .text(let imageName, let title, let foregroundColor):
                HStack(spacing: 0.0) {
                    Label(title, systemImage: imageName)
                        .font(.system(size: 12, weight: .medium))
                        .foregroundStyle(foregroundColor)
                }
            case .capsule(let takeFullWidth, let title, let icon, let height, let backgroundColor, let foregroundColor):
                ZStack(alignment: .center) {
                    RoundedRectangle(cornerRadius: height/2)
                        .fill(backgroundColor)
                        .frame(height: height)
                    HStack(spacing: 10) {
                        if(takeFullWidth) {
                            Text(title).font(.system(size: 14, weight: .semibold)).foregroundStyle(foregroundColor)
                        } else {
                            Text(title).font(.system(size: 10, weight: .medium)).foregroundStyle(foregroundColor)
                        }
                        if(icon != "") {
                            Image(systemName: icon).resizable().frame(width: 4, height: 8).foregroundStyle(foregroundColor)
                        }
                    }.padding(10)
                }.fixedSize(horizontal: !takeFullWidth, vertical: true)
            case .link(let title):
                Text(title)
                    .font(.footnote)
                    .foregroundColor(.blue)
                    .underline()
            }
        }
        .addStaticButtonModifier(staticButtonType: staticButtonType)
        .disabled(showLoader)
    }
}

public struct NADynamicButton: View {
    //MARK: Observed Properties
    @Binding
    var input: String
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var buttonType: DynamicButtonTypes = DynamicButtonTypes.placeOrder
    var onTap: () -> Void
    
    public init(
        input: Binding<String>,
        buttonType: DynamicButtonTypes = .placeOrder,
        onTap: @escaping () -> Void
    ) {
        self._input = input
        self.buttonType = buttonType
        self.onTap = onTap
    }
    
    public var body: some View {
        switch buttonType {
        case .cartCount:
            BTCartCount(input: $input) {
                onTap()
            }
        case .placeOrder:
            BTPlaceOrder(input: $input) {
                onTap()
            }
        case .checkbox:
            BTCheckBox(input: $input) {
                onTap()
            }
        }
    }
}

struct BTCheckBox: View {
    //MARK: Observed Properties
    @Binding
    var input: String
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            ZStack {
                Image(systemName: input == "T" ? "checkmark.square.fill" : "square").padding(14).foregroundStyle(appTheme.current.secondary)
            }
            .frame(width: 20, height: 20)
        }
    }
}


struct BTPlaceOrder: View {
    //MARK: Observed Properties
    @Binding
    var input: String
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            HStack {
                Text("Pay on delivery(Cash/UPI)").padding(.leading).font(.system(size: 14, weight: .medium))
                Spacer()
                HStack(alignment: .center, spacing: 0) {
                    NALabel(labelType: .rupess(displayRupeesFor: .placeOrder, textColor: Color.white, amount: input, isStrikedOut: false)).padding(.horizontal, 8)
                    Text("Place Order").font(.footnote)
                    Image(systemName: "arrowtriangle.right.fill").resizable().frame(width: 6, height: 6).padding(.horizontal, 8)
                }.frame(height: 44)
                    .background(appTheme.current.primary)
                    .cornerRadius(10)
                    .padding(.trailing, 3)
            }.frame(maxWidth: .infinity).frame(height: 50)
                .background(appTheme.current.secondary)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct BTCartCount: View {
    //MARK: Observed Properties
    @Binding
    var input: String
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            HStack {
                Text(input).padding(.leading).font(.system(size: 14, weight: .medium))
                Spacer()
                Image(systemName: "arrow.forward.square.fill").resizable().frame(width: 20, height: 20).padding(.horizontal, 8).foregroundStyle(appTheme.current.primary)
            }.frame(maxWidth: .infinity).frame(height: 50)
                .background(appTheme.current.secondary)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}

struct BTSearch: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var placeHolder: String = ""
    var onTap: () -> Void
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            ZStack {
                HStack(spacing: 0) {
                    Image(systemName: "magnifyingglass").resizable().frame(width: 20, height: 20).foregroundStyle(appTheme.current.primary).padding(.horizontal)
                    Text(placeHolder).foregroundStyle(Color.black.opacity(0.3))
                    Spacer()
                }.frame(height: 44).background(Color.black.opacity(0.05)).padding(.horizontal, 3).cornerRadius(10)
            }.frame(maxWidth: .infinity).frame(height: 50)
                .background(Color.white)
                .cornerRadius(10)
                .addCardViewEffectV2()
        }
    }
}

public enum StaticButtonTypes {
    case plain(ButtonFillTypes, Color, Color, String)
    case search
    case icon(Color, Color, String, IconButtonShape)
    case text(String, String, Color)
    case capsule(takeFullWidth: Bool, title: String, icon: String, height: CGFloat, backgroundColor: Color, foregroundColor: Color)
    case link(title: String)
}

public enum DynamicButtonTypes {
    case cartCount
    case placeOrder
    case checkbox
}

public enum ButtonFillTypes {
    case outlined
    case filled
}

public enum IconButtonShape {
    case circle
    case roundedRect
}

extension IconButtonShape {
    var shape: AnyShape {
        switch self {
        case .circle:
            return AnyShape(Circle())
        case .roundedRect:
            return AnyShape(RoundedRectangle(cornerSize: CGSize(width: 6, height: 6)))
        }
    }
}

public enum NAButtonTypes {
    case search
    case shopNow
    case shopOffer
    case placeOrder
    case cartCount
    case plain(fillType: ButtonFillTypes, foregroundColor: Color, backgroundColor: Color, title: String)
    case showMore
    case showLess
    case addProduct
    case text(icon: String, title: String, color: Color)
    case increaseOrDecreaseQuantity
    case proceedForOTP(foregroundColor: Color, backgroundColor: Color, imageName: String, iconButtonShape: IconButtonShape)
    case markFavouriteIcon(foregroundColor: Color, backgroundColor: Color, imageName: String, iconButtonShape: IconButtonShape)
    case privacyPolicyCheckBox
    case privacyPolicyLink(title: String)
    case closeIcon(foregroundColor: Color, backgroundColor: Color, imageName: String, iconButtonShape: IconButtonShape)
    case callIcon(foregroundColor: Color, backgroundColor: Color, imageName: String, iconButtonShape: IconButtonShape)
}

