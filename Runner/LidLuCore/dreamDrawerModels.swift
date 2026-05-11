import Foundation

protocol dreamDrawerRecord: Codable, Equatable {
    init(dictionary: [String: Any])
    var dictionary: [String: Any] { get }
}

enum contourHaloMapper {
    static func intValue(_ value: Any?) -> Int {
        if let value = value as? Int { return value }
        if let value = value as? Double { return Int(value) }
        if let value = value as? String { return Int(value) ?? 0 }
        return 0
    }

    static func doubleValue(_ value: Any?) -> Double {
        if let value = value as? Double { return value }
        if let value = value as? Int { return Double(value) }
        if let value = value as? String { return Double(value) ?? 0 }
        return 0
    }

    static func stringValue(_ value: Any?) -> String {
        if let value = value as? String { return value }
        if let value = value { return String(describing: value) }
        return ""
    }

    static func intArrayValue(_ value: Any?) -> [Int] {
        if let values = value as? [Int] { return values }
        if let values = value as? [String] { return values.compactMap(Int.init) }
        if let value = value as? String,
           let data = value.data(using: .utf8),
           let decoded = try? JSONSerialization.jsonObject(with: data) {
            return intArrayValue(decoded)
        }
        return []
    }

    static func dateValue(_ value: Any?) -> Date? {
        let milliseconds = doubleValue(value)
        guard milliseconds > 0 else { return nil }
        return Date(timeIntervalSince1970: milliseconds / 1000.0)
    }

    static func removeNil(_ dictionary: [String: Any?]) -> [String: Any] {
        dictionary.compactMapValues { $0 }
    }
}

struct chromaNestPack: dreamDrawerRecord {
    static let keyIndex = "zedDigitalmakeupInspoGeneratorPredictor"
    static let keyAmount = "zedDigitalmakeupInspoGeneratoroin"
    static let keyProductId = "zedDigitalmakeupVirtualMakeup"
    static let keyPrice = "zedDigitalmakeupVisionReationBoxone"

    var index: Int
    var amount: Int
    var productId: String
    var price: Double

    init(index: Int = 0, amount: Int = 0, productId: String = "", price: Double = 0) {
        self.index = index
        self.amount = amount
        self.productId = productId
        self.price = price
    }

    init(dictionary: [String: Any]) {
        index = contourHaloMapper.intValue(dictionary[Self.keyIndex])
        amount = contourHaloMapper.intValue(dictionary[Self.keyAmount])
        productId = contourHaloMapper.stringValue(dictionary[Self.keyProductId])
        price = contourHaloMapper.doubleValue(dictionary[Self.keyPrice])
    }

    var dictionary: [String: Any] {
        [
            Self.keyIndex: index,
            Self.keyAmount: amount,
            Self.keyProductId: productId,
            Self.keyPrice: price
        ]
    }
}

struct opalCharmProfile: dreamDrawerRecord {
    static let keyId = "zedDigitalEycreationBoxvirtualMakeupShowcase"
    static let keyName = "zedDigitalvirtualMakeupShowcasebeauty"
    static let keyBalance = "zedDigitalaIInspiredBeautyLooksMone"
    static let keyCreated = "zedDigitaltrendettereelookxperiencoxan"
    static let keyLiked = "zedDigitaltrendeteryelookExperienceoxfoo"
    static let keySaved = "zedDigitalvirtualakeuphowpirationlac"
    static let keyAvatar = "zedDigitalmakeupInspoCommunityVisionar"
    static let keyEmail = "zedDigitalbeautyIssistantCustomization"
    static let keyPassword = "zedDigitaleyeMakeupIeabeautysswor"

    var id: Int
    var name: String
    var balance: Int
    var created: [Int]
    var liked: [Int]
    var saved: [Int]
    var avatar: String
    var email: String
    var password: String

    init(id: Int = 0, name: String = "", balance: Int = 0, created: [Int] = [], liked: [Int] = [], saved: [Int] = [], avatar: String = "", email: String = "", password: String = "") {
        self.id = id
        self.name = name
        self.balance = balance
        self.created = created
        self.liked = liked
        self.saved = saved
        self.avatar = avatar
        self.email = email
        self.password = password
    }

    init(dictionary: [String: Any]) {
        id = contourHaloMapper.intValue(dictionary[Self.keyId])
        name = contourHaloMapper.stringValue(dictionary[Self.keyName])
        balance = contourHaloMapper.intValue(dictionary[Self.keyBalance])
        created = contourHaloMapper.intArrayValue(dictionary[Self.keyCreated])
        liked = contourHaloMapper.intArrayValue(dictionary[Self.keyLiked])
        saved = contourHaloMapper.intArrayValue(dictionary[Self.keySaved])
        avatar = contourHaloMapper.stringValue(dictionary[Self.keyAvatar])
        email = contourHaloMapper.stringValue(dictionary[Self.keyEmail])
        password = contourHaloMapper.stringValue(dictionary[Self.keyPassword])
    }

    var dictionary: [String: Any] {
        [
            Self.keyId: id,
            Self.keyName: name,
            Self.keyBalance: balance,
            Self.keyCreated: created,
            Self.keyLiked: liked,
            Self.keySaved: saved,
            Self.keyAvatar: avatar,
            Self.keyEmail: email,
            Self.keyPassword: password
        ]
    }
}

struct prismPetalItem: dreamDrawerRecord {
    static let keyId = "zedDigitalfalseLashesEyelashCurlersEye"
    static let keyImage = "zedDigitalbrowPencilEyelashCrease"
    static let keyOwner = "zedDigitalmatteShadowEyeLashExten"
    static let keyTime = "zedDigibrighteningEyeDropsBoldBrows"
    static let keyMarks = "zedDigitallashEnhancerColorfulEyeliner"
    static let keyState = "zedDigitalmatteShadowEyeLashExtenGot"

    var id: Int
    var image: String
    var owner: Int
    var time: Date?
    var marks: [Int]
    var state: Int

    init(id: Int = 0, image: String = "", owner: Int = 0, time: Date? = nil, marks: [Int] = [], state: Int = 0) {
        self.id = id
        self.image = image
        self.owner = owner
        self.time = time
        self.marks = marks
        self.state = state
    }

    init(dictionary: [String: Any]) {
        id = contourHaloMapper.intValue(dictionary[Self.keyId])
        image = contourHaloMapper.stringValue(dictionary[Self.keyImage])
        owner = contourHaloMapper.intValue(dictionary[Self.keyOwner])
        time = contourHaloMapper.dateValue(dictionary[Self.keyTime])
        marks = contourHaloMapper.intArrayValue(dictionary[Self.keyMarks])
        state = contourHaloMapper.intValue(dictionary[Self.keyState])
    }

    var dictionary: [String: Any] {
        contourHaloMapper.removeNil([
            Self.keyId: id,
            Self.keyImage: image,
            Self.keyOwner: owner,
            Self.keyTime: time.map { Int($0.timeIntervalSince1970 * 1000) },
            Self.keyMarks: marks,
            Self.keyState: state
        ])
    }
}

struct twinkleCanvasNote: dreamDrawerRecord {
    static let keyRoom = "zedDigitalmascaraEyebrowDramaticEyeom"
    static let keyAuthor = "zedDigitalmascaraEyebrowDramaticEyes"
    static let keyText = "zedDigitalboldLashesEyePrimerLiquidLineit"

    var room: Int
    var author: Int
    var text: String

    init(room: Int = 0, author: Int = 0, text: String = "") {
        self.room = room
        self.author = author
        self.text = text
    }

    init(dictionary: [String: Any]) {
        room = contourHaloMapper.intValue(dictionary[Self.keyRoom])
        author = contourHaloMapper.intValue(dictionary[Self.keyAuthor])
        text = contourHaloMapper.stringValue(dictionary[Self.keyText])
    }

    var dictionary: [String: Any] {
        [Self.keyRoom: room, Self.keyAuthor: author, Self.keyText: text]
    }
}

struct satinEchoThread: dreamDrawerRecord {
    static let keyId = "zedDigitalglitterLinerEyeshadowaseo"
    static let keyOwner = "zedDigitalglitterLinerEyeshadowsed"
    static let keyTitle = "zedDigitalsmokeyBrownsColorPopesyet"
    static let keyMembers = "zedDigitalnudeShadowsGraphicLinerSatin"
    static let keyUnread = "zedDigitalyeshadowBaseSatinLinerrennmer"

    var id: Int
    var owner: Int
    var title: String
    var members: [Int]
    var unread: Int

    init(id: Int = 0, owner: Int = 0, title: String = "", members: [Int] = [], unread: Int = 0) {
        self.id = id
        self.owner = owner
        self.title = title
        self.members = members
        self.unread = unread
    }

    init(dictionary: [String: Any]) {
        id = contourHaloMapper.intValue(dictionary[Self.keyId])
        owner = contourHaloMapper.intValue(dictionary[Self.keyOwner])
        title = contourHaloMapper.stringValue(dictionary[Self.keyTitle])
        members = contourHaloMapper.intArrayValue(dictionary[Self.keyMembers])
        unread = contourHaloMapper.intValue(dictionary[Self.keyUnread])
    }

    var dictionary: [String: Any] {
        [Self.keyId: id, Self.keyOwner: owner, Self.keyTitle: title, Self.keyMembers: members, Self.keyUnread: unread]
    }
}

struct festiveSproutMood: dreamDrawerRecord {
    static let keyId = "zedDigitalflawlessBrowGraphicLiner"
    static let keyCount = "zedDigitalflawlessBrowConsumption"
    static let keyTitle = "zedDigitalgreenEyeshadowBrowwor"
    static let keyImage = "zedDigitalliquidEyeshadowEyeContour"

    var id: Int
    var count: Int
    var title: String
    var image: String

    init(id: Int = 0, count: Int = 0, title: String = "", image: String = "") {
        self.id = id
        self.count = count
        self.title = title
        self.image = image
    }

    init(dictionary: [String: Any]) {
        id = contourHaloMapper.intValue(dictionary[Self.keyId])
        count = contourHaloMapper.intValue(dictionary[Self.keyCount])
        title = contourHaloMapper.stringValue(dictionary[Self.keyTitle])
        image = contourHaloMapper.stringValue(dictionary[Self.keyImage])
    }

    var dictionary: [String: Any] {
        [Self.keyId: id, Self.keyCount: count, Self.keyTitle: title, Self.keyImage: image]
    }
}
