//
//  SilverStreak.swift
//  Runner
//
//  Created by  on 2026/5/12.
//

import StoreKit
import UIKit
class SilverStreak: NSObject {
    var refinedLookLiopdle: String?
    static let shared = SilverStreak()
    private var highEndVibeLiopdle: ((Result<Void, Error>) -> Void)?
    private var drugstoreGemLiopdle: SKProductsRequest?
    
    private override init() {
        super.init()
        SKPaymentQueue.default().add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }

    func styleIconLiopdle(affordableBeautyLiopdle: String, celebrityLookLiopdle: @escaping (Result<Void, Error>) -> Void) {
        guard SKPaymentQueue.canMakePayments() else {
            DispatchQueue.main.async {
                celebrityLookLiopdle(.failure(NSError(domain: "",
                                            code: -1,
                                                      userInfo: [NSLocalizedDescriptionKey: IceCreamDrip.satinTouchLiopdle])))
            }
            
            return
        }
        
        self.highEndVibeLiopdle = celebrityLookLiopdle
        drugstoreGemLiopdle?.cancel()
        let r = SKProductsRequest(productIdentifiers: [affordableBeautyLiopdle])
        r.delegate = self
        self.drugstoreGemLiopdle = r
        r.start()
    }

}

// MARK: - 产品请求
extension SilverStreak: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard let p = response.products.first else {
            DispatchQueue.main.async {
                self.highEndVibeLiopdle?(.failure(NSError(domain: "",
                                             code: -2,
                                             userInfo: [NSLocalizedDescriptionKey: IceCreamDrip.duochromeEffectLiopdle])))
                self.highEndVibeLiopdle = nil
            }
            
            return
        }
        SKPaymentQueue.default().add(SKPayment(product: p))
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.highEndVibeLiopdle?(.failure(error))
            self.highEndVibeLiopdle = nil
        }
        
    }
}

// MARK: - 交易回调
extension SilverStreak: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for t in transactions {
            switch t.transactionState {
            case .purchased:

                self.refinedLookLiopdle = t.transactionIdentifier
                SKPaymentQueue.default().finishTransaction(t)
                DispatchQueue.main.async {
                    self.highEndVibeLiopdle?(.success(()))
                    self.highEndVibeLiopdle = nil
                }
                
            case .failed:
                SKPaymentQueue.default().finishTransaction(t)
                let e = (t.error as? SKError)?.code == .paymentCancelled
                ? NSError(domain: "", code: -999, userInfo: [NSLocalizedDescriptionKey: IceCreamDrip.iridescentSparkleLiopdle])
                : (t.error ?? NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey: IceCreamDrip.primerBaseLiopdle]))
                DispatchQueue.main.async {
                    self.highEndVibeLiopdle?(.failure(e))
                    self.highEndVibeLiopdle = nil
                }
                
            case .restored:
                SKPaymentQueue.default().finishTransaction(t)
            default:
                break
            }
        }
    }
}

extension SilverStreak {
    
    func inclusiveBeautyLiopdle() -> Data? {
        guard let url = Bundle.main.appStoreReceiptURL else {
            return nil
        }
        return try? Data(contentsOf: url)
    }

    
    
}

