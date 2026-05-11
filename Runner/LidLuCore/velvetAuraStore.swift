import Foundation

final class velvetAuraStore {
    static let shared = velvetAuraStore()

    private let defaults: UserDefaults

    private init(defaults: UserDefaults = .standard) {
        self.defaults = defaults
    }

    var coinPacks: [chromaNestPack] {
        get { readList(velvetAuraStorageKey.coinPacks, fallback: Self.defaultCoinPacks) }
        set { writeList(newValue, key: velvetAuraStorageKey.coinPacks) }
    }

    var activeUserIndex: Int {
        get { defaults.object(forKey: velvetAuraStorageKey.activeUserIndex) as? Int ?? 0 }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.activeUserIndex) }
    }

    var localUsers: [opalCharmProfile] {
        get { readList(velvetAuraStorageKey.localUsers, fallback: Self.defaultUsers) }
        set { writeList(newValue, key: velvetAuraStorageKey.localUsers) }
    }

    var agreement: Int {
        get { defaults.object(forKey: velvetAuraStorageKey.agreement) as? Int ?? 0 }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.agreement) }
    }

    var inspirationItems: [prismPetalItem] {
        get { readList(velvetAuraStorageKey.inspirationItems, fallback: Self.defaultInspirationItems) }
        set { writeList(newValue, key: velvetAuraStorageKey.inspirationItems) }
    }

    var imageNames: [String] {
        get { defaults.stringArray(forKey: velvetAuraStorageKey.imageNames) ?? Self.defaultImageNames }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.imageNames) }
    }

    var roomItems: [twinkleCanvasNote] {
        get { readList(velvetAuraStorageKey.roomItems, fallback: []) }
        set { writeList(newValue, key: velvetAuraStorageKey.roomItems) }
    }

    var threadItems: [satinEchoThread] {
        get { readList(velvetAuraStorageKey.threadItems, fallback: []) }
        set { writeList(newValue, key: velvetAuraStorageKey.threadItems) }
    }

    var blockedUserIds: [Int] {
        get { defaults.array(forKey: velvetAuraStorageKey.blockedUserIds) as? [Int] ?? [] }
        set { defaults.set(Array(Set(newValue)), forKey: velvetAuraStorageKey.blockedUserIds) }
    }

    var editedProfileIds: [Int] {
        get { defaults.array(forKey: velvetAuraStorageKey.editedProfileIds) as? [Int] ?? [] }
        set { defaults.set(Array(Set(newValue)), forKey: velvetAuraStorageKey.editedProfileIds) }
    }

    var occasionItems: [festiveSproutMood] {
        get { readList(velvetAuraStorageKey.occasionItems, fallback: [festiveSproutMood(id: 0, count: 0, title: "Festive Celebrations", image: "zedDigitalEymoodyLashLookelegantLashLook.jpeg")]) }
        set { writeList(newValue, key: velvetAuraStorageKey.occasionItems) }
    }

    var browsNumber: Int {
        get { defaults.object(forKey: velvetAuraStorageKey.browsNumber) as? Int ?? 3 }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.browsNumber) }
    }

    var choseMain: Bool {
        get { defaults.object(forKey: velvetAuraStorageKey.choseMain) as? Bool ?? false }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.choseMain) }
    }

    var machineId: String {
        get { defaults.string(forKey: velvetAuraStorageKey.machineId) ?? "" }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.machineId) }
    }

    var machineType: String {
        get { defaults.string(forKey: velvetAuraStorageKey.machineType) ?? "" }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.machineType) }
    }

    var sessionToken: String {
        get { defaults.string(forKey: velvetAuraStorageKey.sessionToken) ?? "" }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.sessionToken) }
    }

    var pushToken: String {
        get { defaults.string(forKey: velvetAuraStorageKey.pushToken) ?? "" }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.pushToken) }
    }

    var remoteUserId: Int {
        get { defaults.object(forKey: velvetAuraStorageKey.remoteUserId) as? Int ?? 0 }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.remoteUserId) }
    }

    var remoteInfo: String {
        get { defaults.string(forKey: velvetAuraStorageKey.remoteInfo) ?? "" }
        set { defaults.set(newValue, forKey: velvetAuraStorageKey.remoteInfo) }
    }

    private func readList<T: dreamDrawerRecord>(_ key: String, fallback: [T]) -> [T] {
        guard let strings = defaults.stringArray(forKey: key) else { return fallback }
        return strings.compactMap { raw in
            guard let data = raw.data(using: .utf8),
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any] else {
                return nil
            }
            return T(dictionary: json)
        }
    }

    private func writeList<T: dreamDrawerRecord>(_ values: [T], key: String) {
        let strings = values.compactMap { value -> String? in
            guard JSONSerialization.isValidJSONObject(value.dictionary),
                  let data = try? JSONSerialization.data(withJSONObject: value.dictionary),
                  let string = String(data: data, encoding: .utf8) else {
                return nil
            }
            return string
        }
        defaults.set(strings, forKey: key)
    }

    func isBlocked(userId: Int) -> Bool {
        blockedUserIds.contains(userId)
    }

    func blockUser(_ userId: Int) {
        guard userId != activeUserIndex else { return }
        var blocked = blockedUserIds
        if !blocked.contains(userId) {
            blocked.append(userId)
        }
        blockedUserIds = blocked
        pruneUserRelations(with: userId)
    }

    func unblockUser(_ userId: Int) {
        blockedUserIds = blockedUserIds.filter { $0 != userId }
    }

    func markProfileEdited(userId: Int) {
        var edited = editedProfileIds
        if !edited.contains(userId) {
            edited.append(userId)
        }
        editedProfileIds = edited
    }

    func displayName(for user: opalCharmProfile?) -> String {
        guard let user else { return pearlGazeText.appName }
        let cleanName = user.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanEmail = user.email.trimmingCharacters(in: .whitespacesAndNewlines)
        if user.id == activeUserIndex {
            if editedProfileIds.contains(user.id), !cleanName.isEmpty {
                return cleanName
            }
            return cleanEmail.isEmpty ? (cleanName.isEmpty ? pearlGazeText.appName : cleanName) : cleanEmail
        }
        return cleanName.isEmpty ? (cleanEmail.isEmpty ? pearlGazeText.appName : cleanEmail) : cleanName
    }

    func avatarName(for user: opalCharmProfile?) -> String {
        let cleanAvatar = (user?.avatar ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
        if cleanAvatar.isEmpty || cleanAvatar == Self.legacyGeneratedAvatar {
            return Self.placeholderAvatar
        }
        return cleanAvatar
    }

    func pruneUserRelations(with userId: Int) {
        var users = localUsers
        users.indices.forEach { index in
            users[index].liked.removeAll { $0 == userId }
            users[index].saved.removeAll { $0 == userId }
        }
        localUsers = users
        threadItems = threadItems.filter { thread in
            thread.owner != userId && !thread.members.contains(userId) && thread.id != userId
        }
        roomItems = roomItems.filter { note in
            note.room != userId && note.author != userId
        }
    }

    private static let placeholderAvatar = "lanhuProfileAvatar.png"
    private static let legacyGeneratedAvatar = "zedDigitalEyholographicEyeshadsoftCutCrease.jpeg"
}

extension velvetAuraStore {
    static let defaultCoinPacks: [chromaNestPack] = [
        chromaNestPack(index: 0, amount: 400, productId: "ukdqtsstrgwqwgqp", price: 0.99),
        chromaNestPack(index: 1, amount: 800, productId: "cpkzcdmtzjxhycmw", price: 1.99),
        chromaNestPack(index: 2, amount: 2450, productId: "pyjboifqrwpetbdf", price: 4.99),
        chromaNestPack(index: 3, amount: 3430, productId: "tghyqkzojeclpabv", price: 6.99),
        chromaNestPack(index: 4, amount: 4900, productId: "zznrducnwfsdxpsn", price: 9.99),
        chromaNestPack(index: 5, amount: 9800, productId: "sldlihdoqduqulrq", price: 19.99),
        chromaNestPack(index: 6, amount: 14700, productId: "dmsuhtkzqorjvwcf", price: 29.99),
        chromaNestPack(index: 7, amount: 24500, productId: "enxipoqcfrvkxdej", price: 49.99),
        chromaNestPack(index: 8, amount: 29500, productId: "lqrzavxhncdpwyko", price: 59.99),
        chromaNestPack(index: 9, amount: 49000, productId: "pmuxjdoezwwilnuk", price: 99.99)
    ]

    static let defaultUsers: [opalCharmProfile] = [
        opalCharmProfile(id: 0, name: "Leo Green", balance: 800, created: [1, 2, 3], liked: [2, 3], saved: [5], avatar: "zedDigitalEycutCreaseEyeshadowNudeEyeshadow.jpeg", email: "LidLu@gmail.com", password: "111111"),
        opalCharmProfile(id: 1, name: "Elena Walker", balance: 0, created: [0], liked: [0], saved: [0], avatar: "zedDigitalEycolorfulEyeshadowFluffyLashes.jpeg", email: "1111@gmail.com", password: "111111"),
        opalCharmProfile(id: 2, name: "Lucas Harrison", balance: 0, created: [0], liked: [0], saved: [0], avatar: "zedDigitalEydoubleWingedLinerBoldLashes.jpeg", email: "1111@gmail.com", password: "1111111"),
        opalCharmProfile(id: 3, name: "Ben Cole", balance: 0, created: [0], liked: [0], saved: [0], avatar: "zedDigitalEydramaticEyesGlitterLiner.jpeg", email: "12123@gmail.com", password: "1232123"),
        opalCharmProfile(id: 4, name: "Jack Gray", balance: 0, created: [0], liked: [0], saved: [0], avatar: "zedDigitalEyEyelashExtensionsEyePrimer.jpeg", email: "243548@gmail.com", password: "sdawq13512"),
        opalCharmProfile(id: 5, name: "Ava Whitaker", balance: 0, created: [0], liked: [0], saved: [0], avatar: "zedDigitalEyEyeshadowBasevFluffyLashes.jpeg", email: "5655@gmail.com", password: "545841841"),
        opalCharmProfile(id: 6, name: " Benjamin", balance: 0, created: [0], liked: [0], saved: [0], avatar: "zedDigitalEyfalseLashesCutCreasePencil.jpeg", email: "2546448@gmail.com", password: "sdawq13512"),
        opalCharmProfile(id: 7, name: "Samuel", balance: 0, created: [0], liked: [0], saved: [0], avatar: "zedDigitalEygelEyebrowPomadeSoftSmokeyEye.jpeg", email: "24575848@gmail.com", password: "sdawq13512"),
        opalCharmProfile(id: 8, name: "Jackson", balance: 0, created: [0], liked: [0], saved: [0], avatar: "zedDigitalEyPencilLinermokeyEyeWingedLiner.jpeg", email: "27848@gmail.com", password: "sdawq13512"),
        opalCharmProfile(id: 9, name: "Daniel", balance: 0, created: [0], liked: [0], saved: [0], avatar: "zedDigitalEytintedBrowGelEyeContouring.jpeg", email: "2548@gmail.com", password: "sdawq13512")
    ]

    static let defaultInspirationItems: [prismPetalItem] = [
        prismPetalItem(id: 0, image: "zedDigitalEycleanEyelinerdeepCutCrease.jpeg", owner: 0, time: Date(timeIntervalSince1970: 1740477968.505), marks: [1, 2, 0], state: 0),
      //  prismPetalItem(id: 1, image: "zedDigitalEyrichLidShadecleanEyelinerLine.png", owner: 999999999999999, time: Date(timeIntervalSince1970: 1740477987.553), marks: [0], state: 0),
        prismPetalItem(id: 2, image: "zedDigitalEydreamyEyeshadowPaletteeyelashFlick.jpeg", owner: 1, time: Date(timeIntervalSince1970: 1740478024.078), marks: [0], state: 0),
        prismPetalItem(id: 3, image: "zedDigitalEyglossyEyelashessoftLashCurl.jpeg", owner: 2, time: Date(timeIntervalSince1970: 1740478025.196), marks: [0], state: 0),
        prismPetalItem(id: 4, image: "zedDigitalEyLeyelashFlickrichLidShadeNordstrom.jpeg", owner: 3, time: Date(timeIntervalSince1970: 1740478026.616), marks: [0], state: 0),
        prismPetalItem(id: 5, image: "zedDigitalEyMaquiagemmasculinacarnava.jpeg", owner: 4, time: Date(timeIntervalSince1970: 1740478028.162), marks: [0], state: 0),
        prismPetalItem(id: 6, image: "zedDigitalEymultiLayerEyeshadoweyeMakeup.jpeg", owner: 5, time: Date(timeIntervalSince1970: 1740478029.178), marks: [0], state: 0),
        prismPetalItem(id: 7, image: "zedDigitalEynaturalEyeEnhancementnudeLidEffect.jpeg", owner: 6, time: Date(timeIntervalSince1970: 1740478030.908), marks: [0], state: 0),
        prismPetalItem(id: 8, image: "zedDigitalEypreciseBrowArchglossyEyelashes.jpeg", owner: 7, time: Date(timeIntervalSince1970: 1740478031.691), marks: [0], state: 0),
        prismPetalItem(id: 9, image: "zedDigitalEyshimmerEyeshadowcolorPopLine.jpeg", owner: 8, time: Date(timeIntervalSince1970: 1740478033.887), marks: [0], state: 0),
        prismPetalItem(id: 10, image: "zedDigitalEysparklyBrowHighlightdeepCutCrease.jpeg", owner: 9, time: Date(timeIntervalSince1970: 1740478242.495), marks: [0], state: 0),
        prismPetalItem(id: 11, image: "zedDigitalEysmokeyEyeVibeslidGlowEffect.jpeg", owner: 9, time: Date(timeIntervalSince1970: 1740478242.495), marks: [0], state: 0),
        prismPetalItem(id: 12, image: "zedDigitalEygradientEyeShadowrichLidShade.jpeg", owner: 9, time: Date(timeIntervalSince1970: 1740478242.495), marks: [0], state: 0),
        prismPetalItem(id: 13, image: "zedDigitalEycolorPopLinersoftSmokeyEyes.jpeg", owner: 9, time: Date(timeIntervalSince1970: 1740478242.495), marks: [0], state: 0),
        prismPetalItem(id: 14, image: "zedDigitalEysparklyBrowHighlightdeep.jpeg", owner: 9, time: Date(timeIntervalSince1970: 1740478242.495), marks: [0], state: 0)
    ]

    static let defaultImageNames = [
        "zedDigitalEyangelicLashesglossyLashCoat.jpeg",
        "zedDigitalEyboldLashCurlwingedShadowStyle.jpeg",
        "zedDigitalEycopperEyeshadoweffortlessLashLift.jpeg",
        "zedDigitalEydeepBrowShapethickLashCoat.jpeg",
        "zedDigitalEydeepEyeshadowPigmentclearBrowGel.jpeg",
        "zedDigitalEydeepPlumEyelinersparklingBrowGleam.jpeg",
        "zedDigitalEydelicateCutCreaseboldOuterLiner.jpeg",
        "zedDigitalEyelegantLashLookdefinedOuterCrease.jpeg",
        "zedDigitalEyeyeBrighteningEffectboldLashCurl.jpeg",
        "zedDigitalEyglitteryBrowEnhanceiridescentLidShade.jpeg",
        "zedDigitalEyglossyEyelinerpastelShadowTones.jpeg",
        "zedDigitalEyholographicEyeshadsoftCutCrease.jpeg",
        "zedDigitalEylashLengtheningsubtleCrease.jpeg",
        "zedDigitalEylavenderEyelinermoodyLashLook.jpeg",
        "zedDigitalEymoodyLashLookelegantLashLook.jpeg",
        "zedDigitalEymultiColoredLashesglimmeringBrowArch.jpeg",
        "zedDigitalEymutedEyelinerlushLashCurl.jpeg",
        "zedDigitalEynaturalShadowBlendlashLiftEffect.jpeg",
        "zedDigitalEyplumEyeshadoweffortlessLashLift.jpeg",
        "zedDigitalEyradiantEyeGlowholographicLashes.jpeg",
        "zedDigitalEysatinEyelinersoftCutCrease.jpeg",
        "zedDigitalEyshimmerBrowHighlightnudeLidFinish.jpeg",
        "zedDigitalEysoftCreaseBlenddelicateLashDefine.jpeg",
        "zedDigitalEysoftShimmerLinerdefinedOuterCrease.jpeg",
        "zedDigitalEytexturedLashesfieryLidShade.jpeg",
        "zedDigitalEythickLashCoatdeepBrowShape.jpeg",
        "zedDigitalEyvirtualMakeupEyelooksselect.jpeg"
    ]
}
