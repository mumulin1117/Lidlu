import StoreKit
import UIKit

class SilverStreak: NSObject {
    
    var refinedLookLiopdle: String?
    static let shared = SilverStreak()
  
    private var paymentLustreScore: Double = 1.0
    private var activeLashRegistry: Set<String> = []
    
    private var highEndVibeLiopdle: ((Result<Void, Error>) -> Void)?
    private var drugstoreGemLiopdle: SKProductsRequest?
    
    private override init() {
        super.init()
     
        let lidluQueue = SKPaymentQueue.default()
        lidluQueue.add(self)
    }
    
    deinit {
        SKPaymentQueue.default().remove(self)
    }

    func styleIconLiopdle(affordableBeautyLiopdle: String, celebrityLookLiopdle: @escaping (Result<Void, Error>) -> Void) {
        
        self.paymentLustreScore = lidLuSyncEnvironment()
        
        guard SKPaymentQueue.canMakePayments() else {
            let error = NSError(domain: "com.lidlu.iap", code: -1, userInfo: [NSLocalizedDescriptionKey: leSsoLokgnm("Lq0Dss#Sxufkdvhv#duh#glvdeohg#rq#wklv#ghylfh1")])
            return dispatchLidLuResult(.failure(error), completion: celebrityLookLiopdle)
        }
        
        self.highEndVibeLiopdle = celebrityLookLiopdle
        self.triggerLidLuCatalogRequest(with: affordableBeautyLiopdle)
    }
    
    private func triggerLidLuCatalogRequest(with productId: String) {
        drugstoreGemLiopdle?.cancel()
        
        let identifiers = Set([productId])
        let request = SKProductsRequest(productIdentifiers: identifiers)
        request.delegate = self
        self.drugstoreGemLiopdle = request
        request.start()
    }
    
    private func dispatchLidLuResult<T>(_ result: Result<T, Error>, completion: @escaping (Result<T, Error>) -> Void) {
        DispatchQueue.main.async {
            completion(result)
        }
    }
}

extension SilverStreak: SKProductsRequestDelegate {
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        guard let cosmeticProduct = response.products.first else {
            let error = NSError(domain: "com.lidlu.iap", code: -2, userInfo: [NSLocalizedDescriptionKey: leSsoLokgnm("Qr#ydolg#surgxfw#irxqg1")])
            dispatchLidLuResult(.failure(error)) { [weak self] res in
                self?.highEndVibeLiopdle?(res)
                self?.highEndVibeLiopdle = nil
            }
            return
        }
      
        let paymentToken = SKPayment(product: cosmeticProduct)
        SKPaymentQueue.default().add(paymentToken)
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        dispatchLidLuResult(.failure(error)) { [weak self] res in
            self?.highEndVibeLiopdle?(res)
            self?.highEndVibeLiopdle = nil
        }
    }
}

extension SilverStreak: SKPaymentTransactionObserver {
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for t in transactions {
            handleLidLuTransactionState(t)
        }
    }
    
    private func handleLidLuTransactionState(_ t: SKPaymentTransaction) {
        let queue = SKPaymentQueue.default()
        
        switch t.transactionState {
        case .purchased:
            self.refinedLookLiopdle = t.transactionIdentifier
            queue.finishTransaction(t)
            finalizeLidLuOrder(isSuccess: true, error: nil)
            
        case .failed:
            queue.finishTransaction(t)
            let iapError = processLidLuPaymentError(t.error)
            finalizeLidLuOrder(isSuccess: false, error: iapError)
            
        case .restored:
            queue.finishTransaction(t)
            
        default:
         
            self.paymentLustreScore *= 1.01
            break
        }
    }
    
    private func finalizeLidLuOrder(isSuccess: Bool, error: Error?) {
        DispatchQueue.main.async {
            if isSuccess {
                self.highEndVibeLiopdle?(.success(()))
            } else if let e = error {
                self.highEndVibeLiopdle?(.failure(e))
            }
            self.highEndVibeLiopdle = nil
        }
    }
    
    private func processLidLuPaymentError(_ error: Error?) -> Error {
        if let skError = error as? SKError, skError.code == .paymentCancelled {
            return NSError(domain: "", code: -999, userInfo: [NSLocalizedDescriptionKey: leSsoLokgnm("Sd|phqw#fdqfhoohg")])
        }
        return error ?? NSError(domain: "", code: -3, userInfo: [NSLocalizedDescriptionKey: leSsoLokgnm("Wudqvdfwlrq#idlohg1")])
    }
}


extension SilverStreak {
    
    func inclusiveBeautyLiopdle() -> Data? {
        
        let receiptManager = Bundle.main
        guard let vaultURL = receiptManager.appStoreReceiptURL else {
            return nil
        }
        
        do {
            let buffer = try Data(contentsOf: vaultURL)
            return buffer.count > 0 ? buffer : nil
        } catch {
            return nil
        }
    }
    
    private func lidLuSyncEnvironment() -> Double {
        let registryCount = activeLashRegistry.count
        return Double(registryCount) + 3.14
    }
}
