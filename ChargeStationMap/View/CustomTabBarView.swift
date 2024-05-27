import SwiftUI

enum TabbedItems: Int, CaseIterable {
    case home = 0
    case favorite
    case settings
    
    var title: String {
        switch self {
        case .home:
            return "Map"
        case .favorite:
            return "Favorite"
        case .settings:
            return "Settings"
        }
    }
    
    var iconName: String {
        switch self {
        case .home:
            return "map"
        case .favorite:
            return "star.fill"
        case .settings:
            return "gearshape"
        }
    }
}

struct CustomTabBarView: View {
    @State var selectedTab = 0
    
    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedTab) {
                MapViewContainer()
                    .tabItem {
                        CustomTabItem(imageName: TabbedItems.home.iconName, title: TabbedItems.home.title, isActive: selectedTab == TabbedItems.home.rawValue)
                    }
                    .tag(TabbedItems.home.rawValue)
                
                FavoritesView()
                    .tabItem {
                        CustomTabItem(imageName: TabbedItems.favorite.iconName, title: TabbedItems.favorite.title, isActive: selectedTab == TabbedItems.favorite.rawValue)
                    }
                    .tag(TabbedItems.favorite.rawValue)
                
                SettingsView()
                    .tabItem {
                        CustomTabItem(imageName: TabbedItems.settings.iconName, title: TabbedItems.settings.title, isActive: selectedTab == TabbedItems.settings.rawValue)
                    }
                    .tag(TabbedItems.settings.rawValue)
            }
        }
    }
}


extension CustomTabBarView {
    func CustomTabItem(imageName: String, title: String, isActive: Bool) -> some View {
        HStack(spacing: 10) {
            Spacer()
            Image(systemName: imageName)
                .resizable()
                .renderingMode(.template)
                .foregroundColor(isActive ? .black : .gray)
                .frame(width: 20, height: 20)
            if isActive {
                Text(title)
                    .font(.system(size: 14))
                    .foregroundColor(isActive ? .black : .gray)
            }
            Spacer()
        }
        .frame(width: isActive ? .infinity : 60, height: 60)
        .background(isActive ? Color.purple.opacity(0.4) : Color.clear)
        .cornerRadius(30)
    }
}
 
