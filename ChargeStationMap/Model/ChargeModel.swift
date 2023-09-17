
// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let charge = try? JSONDecoder().decode(Charge.self, from: jsonData)

import Foundation

// MARK: - ChargeElement
struct ChargeElement: Codable {
    let dataProvider: DataProvider?
    let operatorInfo: OperatorInfo?
    let usageType: UsageType?
    let statusType: StatusType?
    let submissionStatus: SubmissionStatus?
    
    let isRecentlyVerified: Bool?
    let id: Int?
    let uuid: String?
    let parentChargePointID: JSONNull?
    let dataProviderID: Int?
    
    let operatorID: Int?
    
    let usageTypeID: Int?
    let usageCost: String?
    let addressInfo: AddressInfo?
    let connections: [Connection]?
    let numberOfPoints: Int?
    
    let statusTypeID: Int?
    let metadataValues: JSONNull?
    let dataQualityLevel: Int?
    let submissionStatusTypeID: Int?

    enum CodingKeys: String, CodingKey {
        case dataProvider = "DataProvider"
        case operatorInfo = "OperatorInfo"
        case usageType = "UsageType"
        case statusType = "StatusType"
        case submissionStatus = "SubmissionStatus"
        
        
        case isRecentlyVerified = "IsRecentlyVerified"
        case id = "ID"
        case uuid = "UUID"
        case parentChargePointID = "ParentChargePointID"
        case dataProviderID = "DataProviderID"
        
        case operatorID = "OperatorID"
        
        case usageTypeID = "UsageTypeID"
        case usageCost = "UsageCost"
        case addressInfo = "AddressInfo"
        case connections = "Connections"
        case numberOfPoints = "NumberOfPoints"
        
        case statusTypeID = "StatusTypeID"
        
        case metadataValues = "MetadataValues"
        case dataQualityLevel = "DataQualityLevel"
        case submissionStatusTypeID = "SubmissionStatusTypeID"
    }
}

// MARK: - AddressInfo
struct AddressInfo: Codable {
    let id: Int?
    let title, addressLine1: String?
    
    let town, stateOrProvince, postcode: String?
    let countryID: Int?
    let country: Country?
    let latitude, longitude: Double?
    let contactTelephone1: String?
    
    let relatedURL: String?
    
    let distanceUnit: Int?

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case title = "Title"
        case addressLine1 = "AddressLine1"
        
        case town = "Town"
        case stateOrProvince = "StateOrProvince"
        case postcode = "Postcode"
        case countryID = "CountryID"
        case country = "Country"
        case latitude = "Latitude"
        case longitude = "Longitude"
        case contactTelephone1 = "ContactTelephone1"
        
        
        case relatedURL = "RelatedURL"
        
        case distanceUnit = "DistanceUnit"
    }
}

// MARK: - Country
struct Country: Codable {
    let isoCode, continentCode: String?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case isoCode = "ISOCode"
        case continentCode = "ContinentCode"
        case id = "ID"
        case title = "Title"
    }
}

// MARK: - Connection
struct Connection: Codable {
    let id, connectionTypeID: Int?
    let connectionType: ConnectionType?
    
    let statusTypeID: Int?
    let statusType: StatusType?
    let levelID: Int?
    let level: Level?
    let amps, voltage: Int?
    let powerKW, currentTypeID: Double?
    let currentType: CurrentType?
    let quantity: Int?
    

    enum CodingKeys: String, CodingKey {
        case id = "ID"
        case connectionTypeID = "ConnectionTypeID"
        case connectionType = "ConnectionType"
        
        case statusTypeID = "StatusTypeID"
        case statusType = "StatusType"
        case levelID = "LevelID"
        case level = "Level"
        case amps = "Amps"
        case voltage = "Voltage"
        case powerKW = "PowerKW"
        case currentTypeID = "CurrentTypeID"
        case currentType = "CurrentType"
        case quantity = "Quantity"
        
    }
}

// MARK: - ConnectionType
struct ConnectionType: Codable {
    let formalName: String?
    let isDiscontinued, isObsolete: Bool?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case formalName = "FormalName"
        case isDiscontinued = "IsDiscontinued"
        case isObsolete = "IsObsolete"
        case id = "ID"
        case title = "Title"
    }
}

// MARK: - CurrentType
struct CurrentType: Codable {
    let description: String?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case description = "Description"
        case id = "ID"
        case title = "Title"
    }
}

// MARK: - Level
struct Level: Codable {
    let comments: String?
    let isFastChargeCapable: Bool?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case comments = "Comments"
        case isFastChargeCapable = "IsFastChargeCapable"
        case id = "ID"
        case title = "Title"
    }
}

// MARK: - StatusType
struct StatusType: Codable {
    let isOperational, isUserSelectable: Bool?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case isOperational = "IsOperational"
        case isUserSelectable = "IsUserSelectable"
        case id = "ID"
        case title = "Title"
    }
}

// MARK: - DataProvider
struct DataProvider: Codable {
    let websiteURL: String?
    let comments: JSONNull?
    let dataProviderStatusType: DataProviderStatusType?
    let isRestrictedEdit, isOpenDataLicensed, isApprovedImport: Bool?
    let license: String?
 
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case websiteURL = "WebsiteURL"
        case comments = "Comments"
        case dataProviderStatusType = "DataProviderStatusType"
        case isRestrictedEdit = "IsRestrictedEdit"
        case isOpenDataLicensed = "IsOpenDataLicensed"
        case isApprovedImport = "IsApprovedImport"
        case license = "License"
        case id = "ID"
        case title = "Title"
    }
}

// MARK: - DataProviderStatusType
struct DataProviderStatusType: Codable {
    let isProviderEnabled: Bool?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case isProviderEnabled = "IsProviderEnabled"
        case id = "ID"
        case title = "Title"
    }
}

// MARK: - OperatorInfo
struct OperatorInfo: Codable {
    let websiteURL: String?
    let comments: String?
    
    let isPrivateIndividual: Bool?
    let addressInfo, bookingURL: JSONNull?
    let isRestrictedEdit: Bool?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case websiteURL = "WebsiteURL"
        case comments = "Comments"
        
        case isPrivateIndividual = "IsPrivateIndividual"
        case addressInfo = "AddressInfo"
        case bookingURL = "BookingURL"
        
        
        case isRestrictedEdit = "IsRestrictedEdit"
        case id = "ID"
        case title = "Title"
    }
}

// MARK: - SubmissionStatus
struct SubmissionStatus: Codable {
    let isLive: Bool?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case isLive = "IsLive"
        case id = "ID"
        case title = "Title"
    }
}

// MARK: - UsageType
struct UsageType: Codable {
    let isPayAtLocation, isMembershipRequired, isAccessKeyRequired: Bool?
    let id: Int?
    let title: String?

    enum CodingKeys: String, CodingKey {
        case isPayAtLocation = "IsPayAtLocation"
        case isMembershipRequired = "IsMembershipRequired"
        case isAccessKeyRequired = "IsAccessKeyRequired"
        case id = "ID"
        case title = "Title"
    }
}

typealias Charge = [ChargeElement]

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
