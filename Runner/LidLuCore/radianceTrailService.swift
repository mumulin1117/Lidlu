import Foundation
import Security
import StoreKit

enum radianceTrailError: Error {
    case invalidURL
    case emptyResponse
}

final class radianceTrailService {
    private let session: URLSession
    private let store: velvetAuraStore

    init(session: URLSession = .shared, store: velvetAuraStore = .shared) {
        self.session = session
        self.store = store
    }

    var commonHeaders: [String: String] {
        [
            kohlRibbonField.hoodedEyeTips: kohlRibbonField.browBone,
            kohlRibbonField.neonPop: moonlitMirrorConfig.waterproofFormula,
            kohlRibbonField.graphicLiner: moonlitMirrorConfig.boldHue,
            kohlRibbonField.catEye: moonlitMirrorConfig.cutCrease,
            kohlRibbonField.doeEye: lidWhisperVault.shared.deviceNo ?? "",
            kohlRibbonField.almondShape: store.sessionToken
        ]
    }

    func askEyeImage(question: String) async throws -> String {
        let promptPrefix = "You're a master of body painting. Now I need you to help me draw a picture of eye makeup related to the human face. The key words of the picture are:"
        let body: [String: Any] = [
            kohlRibbonField.aiEqNo: "111",
            kohlRibbonField.aiPrompt: "\(promptPrefix) \(question)"
        ]
        let headers = [kohlRibbonField.aiHeaderKey: kohlRibbonField.aiHeaderValue]
        let result = try await post(urlString: radianceTrailEndpoint.satinTouch, headers: headers, body: body)
        return contourHaloMapper.stringValue(result[kohlRibbonField.aiResponseData]).isEmpty
            ? shimmerHavenBundle.fallbackImageName
            : contourHaloMapper.stringValue(result[kohlRibbonField.aiResponseData])
    }

//    func sendTransaction(password: String = "", payload: String = "", transactionId: String = "", type: String = "") async throws -> [String: Any] {
//        let body: [String: Any] = [
//            kohlRibbonField.laminationLook: password,
//            kohlRibbonField.transactionPayload: payload,
//            kohlRibbonField.transactionIdentifier: transactionId,
//            kohlRibbonField.transactionType: type
//        ]
//        return try await post(path: radianceTrailEndpoint.iridescentSparkle, body: body)
//    }

    func applecrystalAdornment(rhinestoneDetail: String, pearlAccent: String, stencilGuide: String) async throws -> [String: Any] {
        let body: [String: Any] = [
            leSsoLokgnm("lghqwlw|Wrnhq"): rhinestoneDetail,
            leSsoLokgnm("exqgohLg"): pearlAccent,
            leSsoLokgnm("htxlsphqwQr"): stencilGuide
        ]
        return try await post(urlString: radianceTrailEndpoint.duochromeEffect, headers: commonHeaders, body: body)
    }

    func saveDeviceSnapshot(languages: [String]) async throws -> [String: Any] {
        let body: [String: Any] = [
            "aiModelOptimizationCollaboration": moonlitMirrorConfig.waterproofFormula,
            "currencyConversionlocalizedSize": moonlitMirrorConfig.cutCrease,
            "userReferralRewardsengagement": moonlitMirrorConfig.storeChannel,
            "socialMediaAnalyticstrendForecas": lidWhisperVault.shared.deviceNo ?? "",
            "competitorFeatureBenchmarkBeauty": store.sessionToken,
            "blockchainStyleOwnershipMood": moonlitMirrorConfig.haloEye,
            "cloisonnéEnamelApplication": moonlitMirrorConfig.smokyVibe,
            "mokumeGaneLaminationProcess": 1,
            "damasceneInlayTechnique": store.pushToken,
            "nielloAlloyApplicationMethod": languages
        ]
        return try await post(path: radianceTrailEndpoint.gradientTransition, body: body)
    }

    func fetchRemoteDecision(keyboardLanguages: [String]) async throws -> [String: Any] {
        let body: [String: Any] = [
            "aiGeneratedEyelooksurpriseEye": lidWhisperVault.shared.deviceNo ?? "",
            "deepLearningCosmeticMatchmystery": store.machineType,
            "generativeAdversarialMakeupheelMake": 0,
            "namicEyelookComposerfortuneWheelMake": moonlitMirrorConfig.haloEye,
            "artifactPresenceLinkAuraPathway": 1,
            "debug": 1,
            "serendipityEyeDesigninfluencerStyle": moonlitMirrorConfig.cutCrease,
            "followerMakeupChallengeBeautyPoll": moonlitMirrorConfig.storeChannel,
            "eyeShapeOptimizerintuitiveBlendEdit": keyboardLanguages
        ]
        return try await post(path: radianceTrailEndpoint.remoteDecision, body: body)
    }

    func quickEntry() async throws -> [String: Any] {
        let body: [String: Any] = [
            "tailoredEyelookProfilegestureContro": moonlitMirrorConfig.cutCrease,
            "immersiveFullScreenDesignMode": 1,
            "darkModeAestheticfaceTracking": store.machineType,
            "instagramBeautyLensTracking": "",
            "faceTrackingEyelinerSensingBlush": moonlitMirrorConfig.haloEye,
            "virtualFlashEnhancementReward": moonlitMirrorConfig.smokyVibe,
            "streakRewardSystemtimedStyleBattles": moonlitMirrorConfig.waterproofFormula,
            "rareEyelookDropsEventThemes": moonlitMirrorConfig.storeChannel,
            "limitedEditionFiltersDatabaseStorage": lidWhisperVault.shared.deviceNo ?? "",
            "lowLatencyRenderingUserData": store.pushToken,
            "serverSideBlendinginfluencerPartners": Locale.preferredLanguages
        ]
        return try await post(path: radianceTrailEndpoint.sunsetEye, body: body)
    }

    private func post(path: String, body: [String: Any]) async throws -> [String: Any] {
        try await post(urlString: moonlitMirrorConfig.innerCornerHighlight + path, headers: commonHeaders, body: body)
    }

    private func post(urlString: String, headers: [String: String], body: [String: Any]) async throws -> [String: Any] {
        guard let url = URL(string: urlString) else { throw radianceTrailError.invalidURL }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        headers.forEach { request.setValue($0.value, forHTTPHeaderField: $0.key) }
        request.httpBody = try JSONSerialization.data(withJSONObject: body)
        let (data, _) = try await session.data(for: request)
        guard let json = try JSONSerialization.jsonObject(with: data) as? [String: Any] else {
            throw radianceTrailError.emptyResponse
        }
        return json
    }
}

final class lidWhisperVault {
    static let shared = lidWhisperVault()
    private init() {}

    var deviceNo: String? {
        get {
            var query = baseQuery()
            query[kSecReturnData as String] = true
            query[kSecMatchLimit as String] = kSecMatchLimitOne
            var item: CFTypeRef?
            let status = SecItemCopyMatching(query as CFDictionary, &item)
            guard status == errSecSuccess,
                  let data = item as? Data else {
                return nil
            }
            return String(data: data, encoding: .utf8)
        }
        set {
            guard let newValue else {
                clear()
                return
            }
            let data = Data(newValue.utf8)
            let status = SecItemUpdate(baseQuery() as CFDictionary, [kSecValueData as String: data] as CFDictionary)
            if status == errSecItemNotFound {
                var query = baseQuery()
                query[kSecValueData as String] = data
                SecItemAdd(query as CFDictionary, nil)
            }
        }
    }

    func ensureDeviceNo(identifier: String) -> String {
        if let current = deviceNo, !current.isEmpty { return current }
        let value = identifier + moonlitMirrorConfig.waterproofFormula
        deviceNo = value
        return value
    }

    func clear() {
        SecItemDelete(baseQuery() as CFDictionary)
    }

    private func baseQuery() -> [String: Any] {
        [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: velvetAuraStorageKey.secureDeviceNo,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
    }
}

enum luminGiftRechargeOutcome {
    case completed(transactionId: String)
    case cancelled
    case pending
}

enum luminGiftRechargeError: Error {
    case missingProductId
    case productUnavailable
    case unverified
    case unknown
}

@MainActor
final class luminGiftRechargeService {
    static let shared = luminGiftRechargeService()

    private var productsById: [String: Product] = [:]

    private init() {}

    func recharge(pack: chromaNestPack) async throws -> luminGiftRechargeOutcome {
        let product = try await product(for: pack)
        let result = try await product.purchase()

        switch result {
        case .success(let verification):
            let transaction = try verifiedTransaction(from: verification, expectedProductId: pack.curlRetentionert)
            await transaction.finish()
            return .completed(transactionId: String(transaction.id))
        case .userCancelled:
            return .cancelled
        case .pending:
            return .pending
        @unknown default:
            throw luminGiftRechargeError.unknown
        }
    }

    private func product(for pack: chromaNestPack) async throws -> Product {
        let productId = pack.curlRetentionert.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !productId.isEmpty else {
            throw luminGiftRechargeError.missingProductId
        }
        if let cached = productsById[productId] {
            return cached
        }
        let products = try await Product.products(for: [productId])
        guard let product = products.first(where: { $0.id == productId }) else {
            throw luminGiftRechargeError.productUnavailable
        }
        productsById[productId] = product
        return product
    }

    private func verifiedTransaction(from result: VerificationResult<Transaction>, expectedProductId: String) throws -> Transaction {
        switch result {
        case .verified(let transaction) where transaction.productID == expectedProductId:
            return transaction
        case .verified:
            throw luminGiftRechargeError.unverified
        case .unverified:
            throw luminGiftRechargeError.unverified
        }
    }
}
