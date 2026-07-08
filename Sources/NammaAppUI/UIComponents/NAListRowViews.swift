//
//  NAListRowViews.swift
//  NammaAppUI
//
//  Created by apple on 11/09/25.
//

import SwiftUI
import Kingfisher

struct NAListRowViews: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    var body: some View {
        ZStack {
            appTheme.current.background.ignoresSafeArea()
            List {
                VStack(spacing: 20) {
                    OnboardingUserDetailsRow(name: "Anand Mani", address: "No: 47, Anna 4th st, Indira Nagar Khanu Nagar, Anna 4th street, Chennai - 600078", mobileNumber: "+91-9840381795", userType: "DELIVERY PARTNER")
                    OrderStatusHistoryRow(statusId: 4)
                    OrderStatusRow(title: "Title", subtitle: "Subtitle")
                    ProductListRowV1(
                        quantity: "0",
                        actualPricePerUnitOfMeasure: "0.0",
                        actualPrice: "0.0",
                        offeredPrice: "0.0",
                        productName: "Test Name",
                        productImageURL: "Test URL",
                        productDescription: "Test Description", onTapStartAdding: {
                            
                        }, onTapAdd: {
                            
                        }, onTapSubtract: {
                            
                        })
                    CheckoutProductListRow(productName: "Test Name", quantity: "Test Quantity", offeredPrice: "Test Price", onTapAdd: {}, onTapSubtract: {})
                    OrderedProductListRow(productNameList: [], productPriceList: [], amountSavedByCustomer: "", billTotal: "")
                    ShopDetailsRow(shopName: "Meat Basket Proteins", shopAddress: "Ramapuram, Chennai - 600078", fssai: "FDGDMN445LK", deliveryPartnerContact: "+91 9840381795")
                    SettingsOptionRow(rowIcon: "document", title: "Title", subTitle: "Subtitle")
                    ShopListRowV1(cardBackgroundColor: .white, shopName: "Namma Shop", shopImageURL: ""){
                    }
                    ShopListRowV2(shopName: "Namma Shop", shopImageURL: "", rating: "", totalReviews: ""){
                    }
                }.listRowSeparator(.hidden).listRowBackground(appTheme.current.background)
            }.listStyle(.plain)
        }
    }
}

public struct SettingsOptionRow: View {
    //MARK: Stored Properties
    var rowIcon: String
    var title: String
    var subTitle: String
    
    public init(rowIcon: String, title: String, subTitle: String) {
        self.rowIcon = rowIcon
        self.title = title
        self.subTitle = subTitle
    }
    
    public var body: some View {
        HStack {
            Image(systemName: rowIcon).resizable().scaledToFit().foregroundStyle(.black).frame(width: 16, height: 16).padding(.horizontal, 4)
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.system(size: 14, weight: .medium)).foregroundStyle(.black)
                Text(subTitle).font(.system(size: 12, weight: .regular)).foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "chevron.forward").foregroundStyle(.gray)
        }
    }
}

public struct OrderStatusHistoryRow: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var statusId: Int = 3
    
    public init(statusId: Int) {
        self.statusId = statusId
    }
    
    public var body: some View {
        HStack {
            ZStack {
                VStack(alignment: .leading, spacing: 0) {
                    ForEach(orderStatusHistoryList, id: \.id) { orderStatus in
                        ZStack {
                            HStack(spacing: 0) {
                                Image(systemName: "checkmark.circle.fill").resizable().frame(width: 12, height: 12).padding(10).foregroundStyle(orderStatus.id == statusId ? Color.white : orderStatus.id < statusId ? Color.black : Color.clear).background(orderStatus.id == statusId ? appTheme.current.secondary : Color.clear)
                                Text(orderStatus.title).padding(.leading, 6).font(.system(size: 10, weight: orderStatus.id == statusId ? .semibold : .regular)).foregroundStyle(orderStatus.id == statusId ? Color.white : orderStatus.id < statusId ? Color.black : Color.gray)
                                Spacer()
                            }
                        }.frame(width: 150).background(orderStatus.id == statusId ? appTheme.current.primary : Color.clear).clipShape(RoundedRectangle(cornerRadius: 8))
                    }
                }.frame(maxHeight: .infinity)
            }.background(appTheme.current.primary.opacity(0.05))
            Image("timing_pendulum", bundle: .module)
                .resizable()
                .scaledToFit()
        }.addCardViewEffectV2()
    }
}

public struct ShopDetailsRow: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var butcher: Image = Image(systemName: "person.circle.fill")
    var shopName: String
    var shopAddress: String
    var fssai: String
    var deliveryPartnerContact: String
    
    
    public init(shopName: String, shopAddress: String, fssai: String, deliveryPartnerContact: String) {
        self.shopName = shopName
        self.shopAddress = shopAddress
        self.fssai = fssai
        self.deliveryPartnerContact = deliveryPartnerContact
    }
    
    public var body: some View {
        HStack {
            ZStack {
                VStack(spacing: 8) {
                    Text("PRODUCT PROCESSED BY").font(.system(size: 10, weight: .regular))
                    VStack {
                        Text(shopName).font(.system(size: 12, weight: .medium))
                        Text(shopAddress).multilineTextAlignment(.center).font(.system(size: 8, weight: .regular))
                    }
                    VStack {
                        Text("FSSAI").font(.system(size: 12, weight: .medium))
                        Text(fssai).font(.system(size: 8, weight: .regular))
                    }
                    VStack(spacing: 2) {
                        Text("YOUR DELIVERY PARTNER").font(.system(size: 10, weight: .regular))
                        Text("Call (\(deliveryPartnerContact)").font(.system(size: 12, weight: .medium)).foregroundStyle(appTheme.current.primary)
                    }
                }.padding()
            }.frame(maxWidth: .infinity, maxHeight: .infinity).background(Color.black.opacity(0.05)).cornerRadius(8).padding(4)
        }.addCardViewEffectV2()
    }
}

public struct OrderStatusRow: View {
    //MARK: Stored Properties
    var title: String
    var subtitle: String
    
    public init(title: String, subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    public var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(title).font(.system(size: 12, weight: .medium))
                Text(subtitle).font(.system(size: 10, weight: .regular)).foregroundStyle(.gray)
            }
            Spacer()
            Image(systemName: "chevron.forward").resizable().frame(width: 6, height: 10).foregroundStyle(Color.gray.opacity(0.5))
        }.frame(maxWidth: .infinity)
    }
}

public struct OrderedProductListRow: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var productNameList: [String]
    var productPriceList: [(String, String)]
    var amountSavedByCustomer: String
    var billTotal: String
    
    public init(productNameList: [String], productPriceList: [(String, String)], amountSavedByCustomer: String, billTotal: String) {
        self.productNameList = productNameList
        self.productPriceList = productPriceList
        self.amountSavedByCustomer = amountSavedByCustomer
        self.billTotal = billTotal
    }
    
    public var body: some View {
        HStack {
            VStack(spacing: 4) {
                ForEach(productNameList.indices, id: \.self) { index in
                    HStack {
                        itemName(productName: productNameList[index])
                        Spacer()
                    }.frame(height: 20).frame(maxWidth: .infinity)
                    if index == productNameList.count - 1 {
                        HStack {
                            youSaved(amount: amountSavedByCustomer)
                            Spacer()
                        }
                        .frame(height: 20)
                        .padding(.top)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            ZStack {
                VStack(alignment: .leading, spacing: 4) {
                    ForEach(productPriceList.indices, id: \.self) { index in
                        HStack {
                            individualPriceRow(productPrice: productPriceList[index])
                        }.frame(height: 20).frame(maxWidth: .infinity)
                        if index == productPriceList.count - 1 {
                            totalPriceRow(billTotal: billTotal)
                                .frame(height: 20)
                                .background(appTheme.current.onSecondary)
                                .cornerRadius(4)
                                .padding(.top)
                        }
                    }
                }.padding(2)
            }
            .frame(width: 120)
            .background(Color.black.opacity(0.05))
            .cornerRadius(4)
        }.padding(8).addCardViewEffectV2()
    }
    
    func totalPriceRow(billTotal: String) -> some View {
        HStack {
            Text("Total").font(.system(size: 10, weight: .regular))
            Spacer()
            NALabel(labelType: .rupess(displayRupeesFor: .orderedProductPrice, textColor: .black, amount: billTotal, isStrikedOut: false))
        }.padding(6)
    }
    
    func individualPriceRow(productPrice: (String, String)) -> some View {
        HStack {
            Text(productPrice.0).font(.system(size: 10, weight: .medium))
            Spacer()
            NALabel(labelType: .rupess(displayRupeesFor: .orderedProductPrice, textColor: .black, amount: productPrice.1, isStrikedOut: false))
        }.padding(6)
    }
    
    func youSaved(amount: String) -> some View {
        ZStack {
            HStack(spacing: 4) {
                Text("You saved").font(.system(size: 8, weight: .regular))
                NALabel(
                    labelType: .rupess(
                        displayRupeesFor: .amountSaved,
                        textColor: appTheme.current.tertiary,
                        amount: amount,
                        isStrikedOut: false
                    )
                )
                Text("on this order").font(.system(size: 8, weight: .regular))
            }
            .foregroundStyle(appTheme.current.tertiary)
            .padding(6)
        }
        .background(appTheme.current.tertiary.opacity(0.05))
        .cornerRadius(6)
    }
    
    func itemName(productName: String) -> some View {
        HStack {
            Image(systemName: "arrowtriangle.up.square").resizable().frame(width: 8, height: 8).foregroundStyle(Color.red)
            Text(productName).font(.system(size: 10, weight: .regular))
        }.padding(6)
    }
}

public struct CheckoutProductListRow: View {
    var productName: String
    var quantity: String
    var offeredPrice: String
    var onTapAdd: () -> Void
    var onTapSubtract: () -> Void
    
    public init(productName: String, quantity: String, offeredPrice: String, onTapAdd: @escaping () -> Void, onTapSubtract: @escaping () -> Void) {
        self.productName = productName
        self.quantity = quantity
        self.offeredPrice = offeredPrice
        self.onTapAdd = onTapAdd
        self.onTapSubtract = onTapSubtract
    }
    
    public var body: some View {
        VStack(alignment: .trailing) {
            HStack(alignment: .center) {
                Image(systemName: "arrowtriangle.up.square").resizable().frame(width: 10, height: 10).foregroundStyle(Color.red)
                Text(productName).font(.system(size: 12, weight: .medium))
                Spacer()
                ManageProductQuantityRow(quantity: quantity, onTapAdd: {
                    onTapAdd()
                }, onTapSubtract: {
                    onTapSubtract()
                })
            }
            NALabel(labelType: .rupess(displayRupeesFor: .productPrice, textColor: .black, amount: offeredPrice, isStrikedOut: false))
        }.fixedSize(horizontal: false, vertical: true)
    }
}

public struct ShopListRowV1: View {
    //MARK: Stored Properties
    var onClickShopNow: () -> ()
    var shopName: String
    var shopImageURL: String
    var cardBackgroundColor: Color
    
    public init(cardBackgroundColor: Color, shopName: String, shopImageURL: String, onClickShopNow: @escaping () -> ()) {
        self.onClickShopNow = onClickShopNow
        self.shopName = shopName
        self.shopImageURL = shopImageURL
        self.cardBackgroundColor = cardBackgroundColor
    }
    
    public var body: some View {
        ZStack {
            Color(cardBackgroundColor)
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    KFImage(URL(string: shopImageURL))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                }.fixedSize(horizontal: false, vertical: true)
                HStack(alignment: VerticalAlignment.center) {
                    NAButton(buttonType: .shopOffer) {
                        onClickShopNow()
                    }
                }.padding(24)
            }
        }.fixedSize(horizontal: false, vertical: true).addCardViewEffectV2()
    }
}

public struct ShopListRowV2: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var onClickShopNow: () -> ()
    var shopName: String
    var shopImageURL: String
    var rating: String
    var totalReviews: String
    
    public init(shopName: String, shopImageURL: String, rating: String, totalReviews: String, onClickShopNow: @escaping () -> ()) {
        self.onClickShopNow = onClickShopNow
        self.shopName = shopName
        self.shopImageURL = shopImageURL
        self.rating = rating
        self.totalReviews = totalReviews
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                ZStack(alignment: .bottom) {
                    KFImage(URL(string: shopImageURL))
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(12)
                    HStack {
                        HStack(alignment: VerticalAlignment.center, spacing: 0) {
                            Image(systemName: "star.fill").resizable().frame(width: 12, height: 12).padding(.leading, 10).foregroundColor(appTheme.current.tertiary)
                            Text(rating).font(.system(size: 12, weight: .medium)).padding(.leading, 8).foregroundStyle(appTheme.current.secondary)
                            Text("(\(totalReviews))").font(.system(size: 12, weight: .medium)).padding(.trailing, 10).foregroundStyle(Color.gray)
                        }.frame(height: 30)
                            .background(appTheme.current.onSecondary)
                            .cornerRadius(15)
                        Spacer()
                        NAButton(buttonType: .markFavouriteIcon(foregroundColor: appTheme.current.onSecondary, backgroundColor: appTheme.current.secondary, imageName: "heart", iconButtonShape: .circle)) {
                            
                        }
                    }.padding(8)
                }.fixedSize(horizontal: false, vertical: true)
                HStack(alignment: VerticalAlignment.center) {
                    Text(shopName).font(.system(size: 14, weight: .semibold))
                    Spacer()
                    NAButton(buttonType: .shopNow) {
                        onClickShopNow()
                    }
                }.padding(8).padding(.vertical, 8)
            }
        }.fixedSize(horizontal: false, vertical: true).addCardViewEffectV2()
    }
}

public struct ProductListRowV2: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Observed Properties
    @State private var isExpanded = false
    
    //MARK: Stored Properties
    var quantity: String
    var unitsOfMeasure: String
    var actualPrice: String
    var offeredPrice: String
    var productName: String
    var productImageURL: String
    var productDescription: String
    var onTapStartAdding: () -> Void
    var onTapAdd: () -> Void
    var onTapSubtract: () -> Void
    
    //MARK: Computed Properties
    var isStartedAddingProduct: Bool {
        (Double(quantity) ?? 0.0) > 0.0
    }
    
    //MARK: Initializer
    public init(quantity: String, unitsOfMeasure: String, actualPrice: String, offeredPrice: String, productName: String, productImageURL: String, productDescription: String, onTapStartAdding: @escaping () -> Void, onTapAdd: @escaping () -> Void, onTapSubtract: @escaping () -> Void) {
        self.quantity = quantity
        self.unitsOfMeasure = unitsOfMeasure
        self.actualPrice = actualPrice
        self.offeredPrice = offeredPrice
        self.productName = productName
        self.productImageURL = productImageURL
        self.productDescription = productDescription
        self.onTapStartAdding = onTapStartAdding
        self.onTapAdd = onTapAdd
        self.onTapSubtract = onTapSubtract
    }
    
    public var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            ZStack {
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                    .frame(height: 220)

                KFImage(URL(string: productImageURL))
                    .resizable()
                    .scaledToFit()
                    .frame(height: 220)
            }
            .overlay(alignment: .bottomLeading) {
                Button(action: {}) {
                    Text("ADD +")
                        .font(.system(size: 12, weight: .bold))
                        .foregroundColor(appTheme.current.primary)
                        .frame(width: 75, height: 34)
                        .background(Color.white)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                        .overlay {
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(
                                    appTheme.current.primary,
                                    lineWidth: 1
                                )
                        }
                }
                .padding(.leading, 24)
                .offset(y: 17)
            }
            .padding(.bottom, 22)
            
            HStack(alignment: .lastTextBaseline, spacing: 6) {
                Text("₹\(actualPrice)")
                    .font(.system(size: 18, weight: .bold))

                Text("₹\(offeredPrice)")
                    .font(.system(size: 12))
                    .strikethrough()
                    .foregroundColor(.gray)

                Spacer()

                Text("\(quantity) \(unitsOfMeasure)")
                    .font(.system(size: 13, weight: .medium))
                    .foregroundColor(appTheme.current.secondary)
            }
            .padding(.horizontal, 8)

            Text(productName)
                .font(.system(size: 15, weight: .semibold))
                .lineLimit(2)
                .padding(.horizontal, 8)

            VStack(alignment: .leading, spacing: 4) {

                Text(productDescription)
                    .font(.system(size: 11))
                    .foregroundColor(.secondary)
                    .lineLimit(isExpanded ? nil : 2)

                if !isExpanded {
                    Button("Read more") {
                        isExpanded = true
                    }
                    .font(.system(size: 11, weight: .medium))
                    .foregroundColor(appTheme.current.secondary)
                }
            }
            .padding(.horizontal, 8)
            .padding(.bottom, 6)
        }
        .padding(4)
        .background(Color.white)
        .cornerRadius(16)
        .addCardViewEffectV2()
    }
}

public struct ProductListRowV1: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var quantity: String
    var actualPricePerUnitOfMeasure: String
    var actualPrice: String
    var offeredPrice: String
    var productName: String
    var productImageURL: String
    var productDescription: String
    var onTapStartAdding: () -> Void
    var onTapAdd: () -> Void
    var onTapSubtract: () -> Void
    
    //MARK: Computed Properties
    var isStartedAddingProduct: Bool {
        (Double(quantity) ?? 0.0) > 0.0
    }
    
    //MARK: Initializer
    public init(quantity: String, actualPricePerUnitOfMeasure: String, actualPrice: String, offeredPrice: String, productName: String, productImageURL: String, productDescription: String, onTapStartAdding: @escaping () -> Void, onTapAdd: @escaping () -> Void, onTapSubtract: @escaping () -> Void) {
        self.quantity = quantity
        self.actualPricePerUnitOfMeasure = actualPricePerUnitOfMeasure
        self.actualPrice = actualPrice
        self.offeredPrice = offeredPrice
        self.productName = productName
        self.productImageURL = productImageURL
        self.productDescription = productDescription
        self.onTapStartAdding = onTapStartAdding
        self.onTapAdd = onTapAdd
        self.onTapSubtract = onTapSubtract
    }
    
    public var body: some View {
        HStack {
            VStack(spacing: 0) {
                KFImage(URL(string: productImageURL))
                    .resizable()
                    .frame(width: 75, height: 75)
                    .padding(4).padding(.vertical, 4)
                    .aspectRatio(contentMode: .fill)
                    .cornerRadius(12)
                Spacer()
                NALabel(labelType: .rupess(displayRupeesFor: .billDetails, textColor: .black, amount: actualPricePerUnitOfMeasure, isStrikedOut: false))
                Spacer()
            }
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Text(productName).font(.system(size: 12, weight: .medium))
                    Spacer()
                    Image(systemName: "arrowtriangle.up.square").resizable().frame(width: 12, height: 12).foregroundStyle(Color.red)
                }
                Text(productDescription).font(.system(size: 10, weight: .light)).padding(.bottom)
                ZStack {
                    HStack {
                        let extractedQuantity = quantity.filter { $0.isNumber }
                        if (Double(extractedQuantity) ?? 0.0 > 0.0) {
                            ManageProductQuantityRow(quantity: quantity, onTapAdd: {
                                onTapAdd()
                            }, onTapSubtract: {
                                onTapSubtract()
                            }).padding(4)
                            Spacer()
                            NALabel(labelType: .rupess(displayRupeesFor: .productPrice, textColor: .black, amount: actualPrice, isStrikedOut: true))
                            NALabel(labelType: .rupess(displayRupeesFor: .productPrice, textColor: .black, amount: offeredPrice, isStrikedOut: false)).padding(.trailing)
                        } else {
                            Button("ADD") {
                                onTapStartAdding()
                            }
                            .padding(10).padding(.horizontal, 6)
                            .font(.system(size: 12, weight: .medium))
                            .background(appTheme.current.primary.opacity(0.1))
                            .foregroundColor(appTheme.current.primary)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(appTheme.current.primary, lineWidth: 1)
                            )
                            .padding(4)
                        }
                    }
                }.background(appTheme.current.primary.opacity(isStartedAddingProduct ? 0.1 : 0.0)).cornerRadius(8)
            }.padding(.top, 6)
        }.fixedSize(horizontal: false, vertical: true).padding(4).addCardViewEffectV2()
    }
}

public struct ManageProductQuantityRow: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var onTapAdd: () -> Void
    var onTapSubtract: () -> Void
    var quantity: String
    
    init(quantity: String, onTapAdd: @escaping () -> Void, onTapSubtract: @escaping () -> Void) {
        self.quantity = quantity
        self.onTapAdd = onTapAdd
        self.onTapSubtract = onTapSubtract
    }
    
    public var body: some View {
        ZStack {
            HStack {
                Button("+") {
                    onTapAdd()
                }.padding(.leading, 6)
                    .font(.system(size: 14, weight: .medium))
                Text(quantity).font(.system(size: 12, weight: .semibold)).padding(.vertical, 10)
                Button("-") {
                    onTapSubtract()
                }.padding(.trailing, 6)
                    .font(.system(size: 14, weight: .medium))
            }
        }
        .background(appTheme.current.primary)
        .foregroundColor(appTheme.current.onPrimary)
        .clipShape(RoundedRectangle(cornerRadius: 8))
        
    }
}

public struct OnboardingUserDetailsRow: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Stored Properties
    var name: String
    var address: String
    var mobileNumber: String
    var userType: String
    var padding: CGFloat
    
    public init(name: String, address: String, mobileNumber: String, userType: String, padding: CGFloat = 16) {
        self.name = name
        self.address = address
        self.mobileNumber = mobileNumber
        self.userType = userType
        self.padding = padding
    }
    
    public var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .foregroundStyle(appTheme.current.onPrimary)
                .padding(16)
                .frame(width: 50, height: 50)
                .background(appTheme.current.primary)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            VStack(alignment: .leading, spacing: 12) {
                HStack {
                    Text(name).font(.system(size: 16, weight: .medium))
                    Spacer()
                    Text(userType).font(.system(size: 10, weight: .medium)).foregroundStyle(appTheme.current.tertiary)
                }
                Text(address).font(.system(size: 12, weight: .regular)).lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                HStack {
                    Text("Phone Number").font(.system(size: 12, weight: .thin))
                    Text(mobileNumber).font(.system(size: 12, weight: .regular))
                }
            }
        }.padding(padding).addCardViewEffectV2()
    }
}

public struct PlaceOrderRow: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Observed Properties
    var totalAmount: String
    
    //MARK: Stored Properties
    var onTap: () -> Void
    
    public init(totalAmount: String, onTap: @escaping () -> Void) {
        self.totalAmount = totalAmount
        self.onTap = onTap
    }
    
    public var body: some View {
        Button(action: {
            onTap()
        }) {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    Text("PAY USING").font(.system(size: 10, weight: .semibold)).foregroundStyle(appTheme.current.onSecondary)
                    Text("Cash on delivery").font(.system(size: 12, weight: .regular)).foregroundStyle(appTheme.current.primary)
                }.padding(.horizontal)
                Spacer()
                HStack(alignment: .center, spacing: 0) {
                    NALabel(labelType: .rupess(displayRupeesFor: .placeOrder, textColor: appTheme.current.secondary, amount: totalAmount, isStrikedOut: false)).padding(.horizontal, 8)
                    Spacer()
                    Text("Place Order").font(.footnote)
                    Image(systemName: "arrowtriangle.right.fill").resizable().frame(width: 6, height: 6).padding(.horizontal, 8)
                }
                .frame(height: 48)
                .background(appTheme.current.onSecondary)
                .foregroundStyle(appTheme.current.secondary)
                .cornerRadius(10)
                .padding(.trailing, 3).padding(.leading)
            }
            .frame(maxWidth: .infinity).frame(height: 54)
            .background(appTheme.current.secondary)
            .foregroundColor(appTheme.current.onSecondary)
            .cornerRadius(10)
        }
    }
}

public struct ProceedToCheckoutRow: View {
    //MARK: Observed Properties
    @State
    private var appTheme = AppThemeManager.shared
    
    //MARK: Observed Properties
    var title: String
    var cartCount: String
    var ordersCount: String
    
    //MARK: Stored Properties
    var checkoutVersion: ProceedToCheckoutRowVersions
    var onTap: (Int) -> Void
    
    //MARK: Computed Properties
    var backgroundColor: Color {
        switch(checkoutVersion) {
        case .homeCheckout, .homeTrackOrders, .homeCheckoutWithAllComponent, .homeCheckoutWithShowAll, .homeCheckoutWithTrackOrders, .shopCheckout:
            appTheme.current.secondary
        case .showAllListCheckout:
            appTheme.current.onSecondary
        }
    }
    
    var checkoutBackgroundColor: Color {
        switch(checkoutVersion) {
        case .homeCheckout, .homeTrackOrders, .homeCheckoutWithAllComponent, .homeCheckoutWithShowAll, .homeCheckoutWithTrackOrders, .shopCheckout:
            appTheme.current.onSecondary
        case .showAllListCheckout:
            appTheme.current.secondary
        }
    }
    
    var checkoutForegroundColor: Color {
        switch(checkoutVersion) {
        case .homeCheckout, .homeTrackOrders, .homeCheckoutWithAllComponent, .homeCheckoutWithShowAll, .homeCheckoutWithTrackOrders, .shopCheckout:
            appTheme.current.secondary
        case .showAllListCheckout:
            appTheme.current.onSecondary
        }
    }
    
    var showAllVisibility: Bool {
        switch(checkoutVersion) {
        case .homeCheckout, .homeCheckoutWithTrackOrders, .shopCheckout, .showAllListCheckout, .homeTrackOrders:
            false
        case .homeCheckoutWithAllComponent, .homeCheckoutWithShowAll:
            true
        }
    }
    
    var viewItemsVisibility: Bool {
        switch(checkoutVersion) {
        case .homeCheckout, .homeCheckoutWithTrackOrders, .showAllListCheckout, .homeTrackOrders, .homeCheckoutWithAllComponent, .homeCheckoutWithShowAll:
            true
        case .shopCheckout:
            false
        }
    }
    
    var trackOrderVisibility: Bool {
        switch(checkoutVersion) {
        case .homeCheckout, .shopCheckout, .homeCheckoutWithShowAll, .showAllListCheckout:
            false
        case .homeCheckoutWithTrackOrders, .homeTrackOrders, .homeCheckoutWithAllComponent:
            true
        }
    }
    
    var trackOrderBackgroundVisibility: Bool {
        switch(checkoutVersion) {
        case .homeCheckout, .shopCheckout, .homeCheckoutWithShowAll:
            false
        case .homeCheckoutWithTrackOrders, .homeTrackOrders, .homeCheckoutWithAllComponent, .showAllListCheckout:
            true
        }
    }
    
    var shadowVisibility: Double {
        switch(checkoutVersion) {
        case .showAllListCheckout:
            0.0
        default:
            0.1
        }
    }
    
    var trackOrderBottomPadding: Double {
        switch(checkoutVersion) {
        case .homeCheckout, .shopCheckout, .homeCheckoutWithShowAll, .homeCheckoutWithTrackOrders, .homeCheckoutWithAllComponent, .showAllListCheckout:
            24
        case .homeTrackOrders:
            16
        }
    }
    
    var proceedToCheckoutRowVisibility: Bool {
        switch(checkoutVersion) {
        case .homeCheckout, .homeCheckoutWithAllComponent, .homeCheckoutWithShowAll, .homeCheckoutWithTrackOrders, .shopCheckout, .showAllListCheckout:
            true
        case .homeTrackOrders:
            false
        }
    }
    
    public init(title: String, cartCount: String, ordersCount: String, checkoutVersion: Int, onTap: @escaping (Int) -> Void) {
        self.title = title
        self.cartCount = cartCount
        self.ordersCount = ordersCount
        self.onTap = onTap
        self.checkoutVersion = ProceedToCheckoutRowVersions(rawValue: checkoutVersion) ?? .homeCheckout
    }
    
    public var body: some View {
        ZStack {
            VStack(spacing: 0) {
                if trackOrderVisibility {
                    HStack {
                        Text("You have \(ordersCount) orders to be delivered").font(.system(size: 12, weight: .medium)).foregroundStyle(appTheme.current.secondary)
                        Spacer()
                        Button(action: {
                            onTap(4)
                        }) {
                            HStack {
                                Text("Track Order").font(.system(size: 12, weight: .medium)).foregroundStyle(appTheme.current.primary)
                                Image(systemName: "chevron.right").resizable().frame(width: 4, height: 8).foregroundStyle(appTheme.current.primary)
                            }
                        }
                    }.padding(.horizontal, 16).padding(.bottom, trackOrderBottomPadding).padding(.top, 16)
                }
                if checkoutVersion == .homeCheckoutWithShowAll {
                    HStack {}.padding(.top, 16)
                }
                if proceedToCheckoutRowVisibility {
                    HStack(spacing: 0) {
                        VStack(alignment: .leading, spacing: 2) {
                            Text(viewItemsVisibility ? title : "\(cartCount) item added").font(.system(size: 14, weight: .semibold)).foregroundStyle(checkoutBackgroundColor)
                            if viewItemsVisibility {
                                Button(action: {
                                    onTap(3)
                                }) {
                                    HStack {
                                        Text("View items").font(.system(size: 10, weight: .regular)).foregroundStyle(appTheme.current.primary)
                                        Image(systemName: "chevron.right").resizable().frame(width: 4, height: 8).foregroundStyle(appTheme.current.primary)
                                    }
                                }
                            }
                        }.padding(.leading)
                        Spacer()
                        Button(action: {
                            onTap(1)
                        }) {
                            ZStack {
                                appTheme.current.primary
                                HStack {
                                    Image(systemName: "cart").resizable().frame(width: 16, height: 16)
                                        .overlay(
                                            Text(cartCount)
                                                .font(.system(size: 6, weight: .semibold))
                                                .foregroundColor(appTheme.current.onSecondary)
                                                .padding(.all, 4)
                                                .background(appTheme.current.secondary)
                                                .clipShape(Circle())
                                                .offset(x: 6, y: -6),
                                            alignment: .topTrailing
                                        )
                                        .padding(.horizontal, 4)
                                        .foregroundStyle(appTheme.current.onPrimary)
                                    ZStack {
                                        checkoutBackgroundColor
                                        HStack {
                                            Text("Checkout").font(.system(size: 12, weight: .medium)).foregroundStyle(checkoutForegroundColor)
                                            Image(systemName: "chevron.right").resizable().frame(width: 4, height: 8).foregroundStyle(checkoutForegroundColor)
                                        }.padding(.horizontal, 8)
                                    }
                                    .background(appTheme.current.secondary)
                                    .cornerRadius(10)
                                    .fixedSize(horizontal: true, vertical: false)
                                }
                            }
                        }
                        .cornerRadius(10)
                        .fixedSize(horizontal: true, vertical: false)
                        .frame(height: 50)
                        Button(action: {
                            onTap(6)
                        }) {
                            Image(systemName: "xmark.circle.fill").resizable().frame(width: 12, height: 12).padding(.horizontal, 8).foregroundStyle(checkoutBackgroundColor)
                        }
                    }
                    .frame(maxWidth: .infinity).frame(height: 54)
                    .background(backgroundColor)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .overlay(
                        Group {
                            if showAllVisibility {
                                Button(action: {
                                    onTap(2)
                                }) {
                                    HStack {
                                        Text("Show all").font(.system(size: 10, weight: .medium)).foregroundStyle(appTheme.current.onSecondary)
                                        Image(systemName: "chevron.up.square.fill").resizable().frame(width: 10, height: 10).foregroundStyle(appTheme.current.onSecondary)
                                    }
                                    .padding(8)
                                    .background(appTheme.current.secondary)
                                    .cornerRadius(6)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 6)
                                            .stroke(appTheme.current.onSecondary, lineWidth: 1)
                                    )
                                }
                            } else {
                                EmptyView()
                            }
                        }
                            .offset(y: -14),
                        alignment: .top
                    )
                }
            }
        }
        .background(trackOrderBackgroundVisibility ? appTheme.current.onSecondary : Color.clear)
        .cornerRadius(10)
        .addShadowEffectV3(shadowOpacity: shadowVisibility)
    }
}

#Preview {
//    ProceedToCheckoutRow(title: "Test", cartCount: "6", ordersCount: "3", checkoutVersion: 3, onTap: {_ in
//        
//    })
    ProductListRowV1(quantity: "0", actualPricePerUnitOfMeasure: "34", actualPrice: "454", offeredPrice: "34", productName: "Test", productImageURL: "", productDescription: "Nothing", onTapStartAdding: {}, onTapAdd: {}, onTapSubtract: {})
}
