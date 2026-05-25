<div align="center">

# ⚡ ChargeStationMap

### Find EV charging stations near you — in real time.

A SwiftUI + MapKit iOS app that surfaces nearby electric-vehicle charging stations with live availability, designed map-first so it stays usable while you're on the move.

![Swift](https://img.shields.io/badge/Swift-F05138?style=for-the-badge&logo=swift&logoColor=white)
![SwiftUI](https://img.shields.io/badge/SwiftUI-0071E3?style=for-the-badge&logo=swift&logoColor=white)
![MapKit](https://img.shields.io/badge/MapKit-34C759?style=for-the-badge&logo=apple&logoColor=white)
![iOS](https://img.shields.io/badge/iOS-000000?style=for-the-badge&logo=apple&logoColor=white)

<a href="https://apps.apple.com/gb/app/chargeev/id6505103671">
  <img src="https://img.shields.io/badge/Download_on_the-App_Store-0D96F6?style=for-the-badge&logo=appstore&logoColor=white" alt="Download on the App Store"/>
</a>

</div>

---

## ✨ Overview

**ChargeEV** (this repo: *ChargeStationMap*) helps EV drivers locate charging points around them and check availability before driving over. The interface is built around the map so key information stays glanceable while walking or driving — and it's **100% free, no subscriptions, no paywalls**.

> 📲 **Live on the App Store:** [ChargeEV — Charge Station Map to EV](https://apps.apple.com/gb/app/chargeev/id6505103671) · Available in English + 13 more languages · iPhone, iPad, Mac & Vision.

## 🚀 Features

- 🗺️ **Live charging map** — thousands of stations as color-coded pins (AC in blue, DC fast chargers in green) on an interactive MapKit map.
- 🔍 **Smart search & filters** — filter by power (7 kW to 150+ kW), connector type (Type 2, CCS, CHAdeMO, Tesla), and availability; sort by distance, speed, or reliability.
- 🧭 **Trip planner** — enter a destination and get optimized charging stops with drive + charge time, then open the route in Apple Maps, Google Maps, or Waze.
- 🧮 **Charging calculator** — estimate charging time and cost from your battery level, charge speed, and energy price.
- 📍 **Location-aware** — centers on your current position with CoreLocation; new map regions load automatically as you pan.
- ⭐ **Favorites & history** — save go-to stations locally with CoreData and track sessions with visit history and cost.
- 🔐 **Simple & private** — Sign in with Apple or Google; the app collects no user data.

## 🛠️ Tech Stack

| Area | Technology |
|------|-----------|
| Language | Swift |
| UI | SwiftUI |
| Maps | MapKit |
| Location | CoreLocation |
| Persistence | CoreData (favorites) |
| Data | Remote REST API |

## 🏗️ Architecture

```
 ┌─────────────┐     ┌──────────────┐     ┌─────────────────┐
 │ CoreLocation│ →   │  Remote API  │ →   │   Map (MapKit)  │
 │ user coords │     │  stations +  │     │  annotations +  │
 │             │     │ availability │     │   detail cards  │
 └─────────────┘     └──────────────┘     └────────┬────────┘
                                                    │
                                          ┌─────────▼─────────┐
                                          │  CoreData         │
                                          │  saved favorites  │
                                          └───────────────────┘
```

## ⚙️ Getting Started

### Prerequisites
- Xcode 14+
- iOS 15+ deployment target
- An API key/endpoint for the charging-station data source

### Installation

```bash
git clone https://github.com/Albaylar/ChargeStationMap.git
cd ChargeStationMap
open ChargeStationMap.xcodeproj
```

### Configuration
Add your data-source endpoint and key before building:

```swift
enum Config {
    static let stationsAPIBaseURL = "https://your-stations-api.example.com"
    static let stationsAPIKey     = "YOUR_API_KEY"
}
```

Make sure your `Info.plist` includes a location-usage description:

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>We use your location to show nearby charging stations.</string>
```

> ⚠️ Never commit real API keys. Keep secrets out of version control via `.gitignore`.

## 📸 Screenshots

*(Add a couple of screenshots or a short GIF here — map view, station detail, favorites.)*

## 🗺️ Roadmap

- [ ] Filter by connector type / charging speed
- [ ] Turn-by-turn directions to a selected station
- [ ] Offline cache of recently viewed stations
- [ ] Dark-mode map styling

## 🤝 Contributing

Issues and pull requests are welcome. Open an [issue](https://github.com/Albaylar/ChargeStationMap/issues) to start a discussion.

## 📄 License

Consider adding an open-source license (e.g. MIT) to clarify how others may use this code.

## 📬 Contact

**Furkan Deniz Albaylar** — iOS Engineer
📧 furkandenizalbaylar@gmail.com
🔗 [LinkedIn](https://www.linkedin.com/in/furkandenizalbaylar/) · [GitHub](https://github.com/Albaylar)

---

<div align="center">
<sub>Built with ❤️ in SwiftUI</sub>
</div>
