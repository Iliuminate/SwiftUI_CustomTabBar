//
//  CustomTabBar.swift
//  CustomTabBar
//
//  Created by Carlos Diaz on 24/08/22.
//

import SwiftUI

struct CustomTabBar: View {
    
    @State var currentTab: Tab = .home
    @State var currrentXValue: CGFloat = 0
    
    @Namespace var animation
    
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        TabView(selection: $currentTab) {
            SampleCard(color: .purple, count: 6)
                .tag(Tab.home)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG")).ignoresSafeArea()
            
            Text("Search")
                .tag(Tab.search )
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG")).ignoresSafeArea()
            
            Text("Notifications")
                .tag(Tab.currentNotifications)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG")).ignoresSafeArea()
            
            Text("Account")
                .tag(Tab.account)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color("BG")).ignoresSafeArea()
        }
        
        .overlay(
            HStack(spacing: 0) {
                ForEach(Tab.allCases, id: \.rawValue) { tab in
                    TabButton(tab: tab)
                }
            }
            .padding(.vertical)
            .padding(.bottom, getSafeArea().bottom == 0 ? 10 : getSafeArea().bottom - 10)
            .background(
                MaterialEffect(style: .systemUltraThinMaterialDark)
                    .clipShape(BottomCurve(currentXValue: currrentXValue))
            )
            
            ,alignment: .bottom
        )
        .ignoresSafeArea(.all, edges: .bottom)
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    func TabButton(tab: Tab) -> some View {
        
        GeometryReader { proxy in
            Button {
                withAnimation(.spring()) {
                    currentTab = tab
                    currrentXValue = proxy.frame(in: .global).midX
                }
            } label: {
                Image(systemName: tab.rawValue)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 25, height: 25)
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)
                    .padding(currentTab == tab ? 15 : 0 )
                    .background(
                        ZStack {
                            if currentTab == tab {
                                MaterialEffect(style: .systemChromeMaterialDark)
                                    .clipShape(Circle())
                                    .matchedGeometryEffect(id: "TAB", in: animation)
                            }
                        }
                    )
                    .contentShape(Rectangle())
                    .offset(y: currentTab == tab ? -50 : 0)
            }
            .onAppear {
                if tab == Tab.allCases.first && currrentXValue == 0 {
                    currrentXValue = proxy.frame(in: .global).midX
                }
            }
        }
        .frame(height: 30)
    }
    
    @ViewBuilder
    func SampleCard(color: Color, count: Int) -> some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 16) {
                    ForEach(1...count, id: \.self) { index in
                        Image("sample\(index)")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: UIScreen.main.bounds.width - 32, height: 210)
                            .cornerRadius(12)
                    }
                }
                .padding()
                .padding(.bottom, 60)
                .padding(.bottom, getSafeArea().bottom == 0 ? 15 : getSafeArea().bottom)
            }
            .navigationTitle("GOT Houses")
        }
    }
}

enum Tab: String, CaseIterable  {
    case home = "house.fill"
    case search = "magnifyingglass"
    case currentNotifications = "bell.fill"
    case account = "person.fill"
}


extension View {
    func getSafeArea() -> UIEdgeInsets {
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return .zero }
        guard let safeArea = screen.windows.first?.safeAreaInsets else { return .zero}
        return safeArea
    }
}


struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar()
    }
}
 
