import Foundation
import GoogleMobileAds

class InterstitialAdsManager: NSObject, GADFullScreenContentDelegate, ObservableObject {
    
    // Properties
    @Published var interstitialAdLoaded: Bool = false
    var interstitialAd: GADInterstitialAd?
    var adLoadRequested = false
    
    override init() {
        super.init()
    }
    
    // Load InterstitialAd if needed
    func loadInterstitialAdIfNeeded() {
        if !adLoadRequested {
            loadInterstitialAd()
            adLoadRequested = true
        }
    }
    
    // Load InterstitialAd
    func loadInterstitialAd(){
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-9645439906826429/6946459711", request: GADRequest()) { [weak self] add, error in
            guard let self = self else {return}
            if let error = error {
                print("🔴: \(error.localizedDescription)")
                self.interstitialAdLoaded = false
                return
            }
            print("🟢: Loading succeeded")
            self.interstitialAdLoaded = true
            self.interstitialAd = add
            self.interstitialAd?.fullScreenContentDelegate = self
        }
    }
    
    // Display InterstitialAd
    func displayInterstitialAd(){
        guard let root = UIApplication.shared.windows.first?.rootViewController else {
            return
        }
        if let add = interstitialAd {
            add.present(fromRootViewController: root)
            self.interstitialAdLoaded = false
            adLoadRequested = false
        } else {
            print("🔵: Ad wasn't ready")
            self.interstitialAdLoaded = false
            self.loadInterstitialAdIfNeeded()
        }
    }
    
    // Failure notification
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("🟡: Failed to display interstitial ad")
        self.loadInterstitialAdIfNeeded()
    }
    
    // Indicate notification
    func adWillPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("🤩: Displayed an interstitial ad")
        self.interstitialAdLoaded = false
    }
    
    // Close notification
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
            print("😔: Interstitial ad closed")
            NotificationCenter.default.post(name: .interstitialAdDidDismiss, object: nil)
        }
    }

    extension Notification.Name {
        static let interstitialAdDidDismiss = Notification.Name("interstitialAdDidDismiss")
    }

