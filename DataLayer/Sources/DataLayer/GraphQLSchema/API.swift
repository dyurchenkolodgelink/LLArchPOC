// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public enum FeatureFlagEnum: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case flagDateSnake
  case flagBookMgmt
  case flagDemoOne
  case flagCrewSwap
  case flagPagBookings
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "FLAG_DATE_SNAKE": self = .flagDateSnake
      case "FLAG_BOOK_MGMT": self = .flagBookMgmt
      case "FLAG_DEMO_ONE": self = .flagDemoOne
      case "FLAG_CREW_SWAP": self = .flagCrewSwap
      case "FLAG_PAG_BOOKINGS": self = .flagPagBookings
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .flagDateSnake: return "FLAG_DATE_SNAKE"
      case .flagBookMgmt: return "FLAG_BOOK_MGMT"
      case .flagDemoOne: return "FLAG_DEMO_ONE"
      case .flagCrewSwap: return "FLAG_CREW_SWAP"
      case .flagPagBookings: return "FLAG_PAG_BOOKINGS"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: FeatureFlagEnum, rhs: FeatureFlagEnum) -> Bool {
    switch (lhs, rhs) {
      case (.flagDateSnake, .flagDateSnake): return true
      case (.flagBookMgmt, .flagBookMgmt): return true
      case (.flagDemoOne, .flagDemoOne): return true
      case (.flagCrewSwap, .flagCrewSwap): return true
      case (.flagPagBookings, .flagPagBookings): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [FeatureFlagEnum] {
    return [
      .flagDateSnake,
      .flagBookMgmt,
      .flagDemoOne,
      .flagCrewSwap,
      .flagPagBookings,
    ]
  }
}

public enum RoleName: RawRepresentable, Equatable, Hashable, CaseIterable, Apollo.JSONDecodable, Apollo.JSONEncodable {
  public typealias RawValue = String
  case organizationAdmin
  case bookingManager
  /// Auto generated constant for unknown enum values
  case __unknown(RawValue)

  public init?(rawValue: RawValue) {
    switch rawValue {
      case "OrganizationAdmin": self = .organizationAdmin
      case "BookingManager": self = .bookingManager
      default: self = .__unknown(rawValue)
    }
  }

  public var rawValue: RawValue {
    switch self {
      case .organizationAdmin: return "OrganizationAdmin"
      case .bookingManager: return "BookingManager"
      case .__unknown(let value): return value
    }
  }

  public static func == (lhs: RoleName, rhs: RoleName) -> Bool {
    switch (lhs, rhs) {
      case (.organizationAdmin, .organizationAdmin): return true
      case (.bookingManager, .bookingManager): return true
      case (.__unknown(let lhsValue), .__unknown(let rhsValue)): return lhsValue == rhsValue
      default: return false
    }
  }

  public static var allCases: [RoleName] {
    return [
      .organizationAdmin,
      .bookingManager,
    ]
  }
}

public final class LoginMutation: GraphQLMutation {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    mutation login($emailAddress: EmailAddress!, $password: String!) {
      login(emailAddress: $emailAddress, password: $password) {
        __typename
        errorMessage
        message
        accountToken
        tokenExpiry
        me {
          __typename
          emailAddress
          phoneNumber
          firstName
          lastName
          userId
          company
          position
          activeOrganization {
            __typename
            id
            name
            permissions
            featureFlagMapping {
              __typename
              id
              active
              featureFlag {
                __typename
                id
                active
                featureIdentifier
              }
            }
          }
        }
      }
    }
    """

  public let operationName: String = "login"

  public let operationIdentifier: String? = "711431e39b0066af7cdfe8ebbd4f8427cf508e18fb854bdea81de1de22116eb7"

  public var emailAddress: String
  public var password: String

  public init(emailAddress: String, password: String) {
    self.emailAddress = emailAddress
    self.password = password
  }

  public var variables: GraphQLMap? {
    return ["emailAddress": emailAddress, "password": password]
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Mutation"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("login", arguments: ["emailAddress": GraphQLVariable("emailAddress"), "password": GraphQLVariable("password")], type: .object(Login.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(login: Login? = nil) {
      self.init(unsafeResultMap: ["__typename": "Mutation", "login": login.flatMap { (value: Login) -> ResultMap in value.resultMap }])
    }

    public var login: Login? {
      get {
        return (resultMap["login"] as? ResultMap).flatMap { Login(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "login")
      }
    }

    public struct Login: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["LoginMutationResponse"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("errorMessage", type: .scalar(String.self)),
          GraphQLField("message", type: .nonNull(.scalar(String.self))),
          GraphQLField("accountToken", type: .scalar(String.self)),
          GraphQLField("tokenExpiry", type: .scalar(String.self)),
          GraphQLField("me", type: .object(Me.selections)),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(errorMessage: String? = nil, message: String, accountToken: String? = nil, tokenExpiry: String? = nil, me: Me? = nil) {
        self.init(unsafeResultMap: ["__typename": "LoginMutationResponse", "errorMessage": errorMessage, "message": message, "accountToken": accountToken, "tokenExpiry": tokenExpiry, "me": me.flatMap { (value: Me) -> ResultMap in value.resultMap }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var errorMessage: String? {
        get {
          return resultMap["errorMessage"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "errorMessage")
        }
      }

      public var message: String {
        get {
          return resultMap["message"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "message")
        }
      }

      public var accountToken: String? {
        get {
          return resultMap["accountToken"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "accountToken")
        }
      }

      public var tokenExpiry: String? {
        get {
          return resultMap["tokenExpiry"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "tokenExpiry")
        }
      }

      public var me: Me? {
        get {
          return (resultMap["me"] as? ResultMap).flatMap { Me(unsafeResultMap: $0) }
        }
        set {
          resultMap.updateValue(newValue?.resultMap, forKey: "me")
        }
      }

      public struct Me: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Me"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
            GraphQLField("phoneNumber", type: .scalar(String.self)),
            GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
            GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
            GraphQLField("userId", type: .nonNull(.scalar(String.self))),
            GraphQLField("company", type: .scalar(String.self)),
            GraphQLField("position", type: .scalar(String.self)),
            GraphQLField("activeOrganization", type: .nonNull(.object(ActiveOrganization.selections))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(emailAddress: String, phoneNumber: String? = nil, firstName: String, lastName: String, userId: String, company: String? = nil, position: String? = nil, activeOrganization: ActiveOrganization) {
          self.init(unsafeResultMap: ["__typename": "Me", "emailAddress": emailAddress, "phoneNumber": phoneNumber, "firstName": firstName, "lastName": lastName, "userId": userId, "company": company, "position": position, "activeOrganization": activeOrganization.resultMap])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var emailAddress: String {
          get {
            return resultMap["emailAddress"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "emailAddress")
          }
        }

        public var phoneNumber: String? {
          get {
            return resultMap["phoneNumber"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "phoneNumber")
          }
        }

        public var firstName: String {
          get {
            return resultMap["firstName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "firstName")
          }
        }

        public var lastName: String {
          get {
            return resultMap["lastName"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "lastName")
          }
        }

        public var userId: String {
          get {
            return resultMap["userId"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "userId")
          }
        }

        public var company: String? {
          get {
            return resultMap["company"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "company")
          }
        }

        public var position: String? {
          get {
            return resultMap["position"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "position")
          }
        }

        public var activeOrganization: ActiveOrganization {
          get {
            return ActiveOrganization(unsafeResultMap: resultMap["activeOrganization"]! as! ResultMap)
          }
          set {
            resultMap.updateValue(newValue.resultMap, forKey: "activeOrganization")
          }
        }

        public struct ActiveOrganization: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["Organization"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(Int.self))),
              GraphQLField("name", type: .nonNull(.scalar(String.self))),
              GraphQLField("permissions", type: .list(.nonNull(.scalar(String.self)))),
              GraphQLField("featureFlagMapping", type: .list(.nonNull(.object(FeatureFlagMapping.selections)))),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, name: String, permissions: [String]? = nil, featureFlagMapping: [FeatureFlagMapping]? = nil) {
            self.init(unsafeResultMap: ["__typename": "Organization", "id": id, "name": name, "permissions": permissions, "featureFlagMapping": featureFlagMapping.flatMap { (value: [FeatureFlagMapping]) -> [ResultMap] in value.map { (value: FeatureFlagMapping) -> ResultMap in value.resultMap } }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int {
            get {
              return resultMap["id"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var name: String {
            get {
              return resultMap["name"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "name")
            }
          }

          public var permissions: [String]? {
            get {
              return resultMap["permissions"] as? [String]
            }
            set {
              resultMap.updateValue(newValue, forKey: "permissions")
            }
          }

          public var featureFlagMapping: [FeatureFlagMapping]? {
            get {
              return (resultMap["featureFlagMapping"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [FeatureFlagMapping] in value.map { (value: ResultMap) -> FeatureFlagMapping in FeatureFlagMapping(unsafeResultMap: value) } }
            }
            set {
              resultMap.updateValue(newValue.flatMap { (value: [FeatureFlagMapping]) -> [ResultMap] in value.map { (value: FeatureFlagMapping) -> ResultMap in value.resultMap } }, forKey: "featureFlagMapping")
            }
          }

          public struct FeatureFlagMapping: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["FeatureFlagMapping"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(Int.self))),
                GraphQLField("active", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("featureFlag", type: .object(FeatureFlag.selections)),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int, active: Bool, featureFlag: FeatureFlag? = nil) {
              self.init(unsafeResultMap: ["__typename": "FeatureFlagMapping", "id": id, "active": active, "featureFlag": featureFlag.flatMap { (value: FeatureFlag) -> ResultMap in value.resultMap }])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int {
              get {
                return resultMap["id"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var active: Bool {
              get {
                return resultMap["active"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "active")
              }
            }

            public var featureFlag: FeatureFlag? {
              get {
                return (resultMap["featureFlag"] as? ResultMap).flatMap { FeatureFlag(unsafeResultMap: $0) }
              }
              set {
                resultMap.updateValue(newValue?.resultMap, forKey: "featureFlag")
              }
            }

            public struct FeatureFlag: GraphQLSelectionSet {
              public static let possibleTypes: [String] = ["FeatureFlag"]

              public static var selections: [GraphQLSelection] {
                return [
                  GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                  GraphQLField("id", type: .nonNull(.scalar(Int.self))),
                  GraphQLField("active", type: .nonNull(.scalar(Bool.self))),
                  GraphQLField("featureIdentifier", type: .nonNull(.scalar(FeatureFlagEnum.self))),
                ]
              }

              public private(set) var resultMap: ResultMap

              public init(unsafeResultMap: ResultMap) {
                self.resultMap = unsafeResultMap
              }

              public init(id: Int, active: Bool, featureIdentifier: FeatureFlagEnum) {
                self.init(unsafeResultMap: ["__typename": "FeatureFlag", "id": id, "active": active, "featureIdentifier": featureIdentifier])
              }

              public var __typename: String {
                get {
                  return resultMap["__typename"]! as! String
                }
                set {
                  resultMap.updateValue(newValue, forKey: "__typename")
                }
              }

              public var id: Int {
                get {
                  return resultMap["id"]! as! Int
                }
                set {
                  resultMap.updateValue(newValue, forKey: "id")
                }
              }

              public var active: Bool {
                get {
                  return resultMap["active"]! as! Bool
                }
                set {
                  resultMap.updateValue(newValue, forKey: "active")
                }
              }

              public var featureIdentifier: FeatureFlagEnum {
                get {
                  return resultMap["featureIdentifier"]! as! FeatureFlagEnum
                }
                set {
                  resultMap.updateValue(newValue, forKey: "featureIdentifier")
                }
              }
            }
          }
        }
      }
    }
  }
}

public final class MeQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition: String =
    """
    query me {
      me {
        __typename
        emailAddress
        phoneNumber
        firstName
        lastName
        userId
        company
        position
        activeOrganization {
          __typename
          id
          name
          roles
          permissions
          featureFlagMapping {
            __typename
            id
            active
            featureFlag {
              __typename
              id
              active
              featureIdentifier
            }
          }
        }
      }
    }
    """

  public let operationName: String = "me"

  public let operationIdentifier: String? = "088ae4ee888ee72bc104772edcf0a15acc015932567969ebe3ae4420b76c9087"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes: [String] = ["Query"]

    public static var selections: [GraphQLSelection] {
      return [
        GraphQLField("me", type: .object(Me.selections)),
      ]
    }

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(me: Me? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "me": me.flatMap { (value: Me) -> ResultMap in value.resultMap }])
    }

    public var me: Me? {
      get {
        return (resultMap["me"] as? ResultMap).flatMap { Me(unsafeResultMap: $0) }
      }
      set {
        resultMap.updateValue(newValue?.resultMap, forKey: "me")
      }
    }

    public struct Me: GraphQLSelectionSet {
      public static let possibleTypes: [String] = ["Me"]

      public static var selections: [GraphQLSelection] {
        return [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("emailAddress", type: .nonNull(.scalar(String.self))),
          GraphQLField("phoneNumber", type: .scalar(String.self)),
          GraphQLField("firstName", type: .nonNull(.scalar(String.self))),
          GraphQLField("lastName", type: .nonNull(.scalar(String.self))),
          GraphQLField("userId", type: .nonNull(.scalar(String.self))),
          GraphQLField("company", type: .scalar(String.self)),
          GraphQLField("position", type: .scalar(String.self)),
          GraphQLField("activeOrganization", type: .nonNull(.object(ActiveOrganization.selections))),
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(emailAddress: String, phoneNumber: String? = nil, firstName: String, lastName: String, userId: String, company: String? = nil, position: String? = nil, activeOrganization: ActiveOrganization) {
        self.init(unsafeResultMap: ["__typename": "Me", "emailAddress": emailAddress, "phoneNumber": phoneNumber, "firstName": firstName, "lastName": lastName, "userId": userId, "company": company, "position": position, "activeOrganization": activeOrganization.resultMap])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var emailAddress: String {
        get {
          return resultMap["emailAddress"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "emailAddress")
        }
      }

      public var phoneNumber: String? {
        get {
          return resultMap["phoneNumber"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "phoneNumber")
        }
      }

      public var firstName: String {
        get {
          return resultMap["firstName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "firstName")
        }
      }

      public var lastName: String {
        get {
          return resultMap["lastName"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "lastName")
        }
      }

      public var userId: String {
        get {
          return resultMap["userId"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "userId")
        }
      }

      public var company: String? {
        get {
          return resultMap["company"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "company")
        }
      }

      public var position: String? {
        get {
          return resultMap["position"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "position")
        }
      }

      public var activeOrganization: ActiveOrganization {
        get {
          return ActiveOrganization(unsafeResultMap: resultMap["activeOrganization"]! as! ResultMap)
        }
        set {
          resultMap.updateValue(newValue.resultMap, forKey: "activeOrganization")
        }
      }

      public struct ActiveOrganization: GraphQLSelectionSet {
        public static let possibleTypes: [String] = ["Organization"]

        public static var selections: [GraphQLSelection] {
          return [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .nonNull(.scalar(Int.self))),
            GraphQLField("name", type: .nonNull(.scalar(String.self))),
            GraphQLField("roles", type: .list(.nonNull(.scalar(RoleName.self)))),
            GraphQLField("permissions", type: .list(.nonNull(.scalar(String.self)))),
            GraphQLField("featureFlagMapping", type: .list(.nonNull(.object(FeatureFlagMapping.selections)))),
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: Int, name: String, roles: [RoleName]? = nil, permissions: [String]? = nil, featureFlagMapping: [FeatureFlagMapping]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Organization", "id": id, "name": name, "roles": roles, "permissions": permissions, "featureFlagMapping": featureFlagMapping.flatMap { (value: [FeatureFlagMapping]) -> [ResultMap] in value.map { (value: FeatureFlagMapping) -> ResultMap in value.resultMap } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: Int {
          get {
            return resultMap["id"]! as! Int
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var name: String {
          get {
            return resultMap["name"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "name")
          }
        }

        public var roles: [RoleName]? {
          get {
            return resultMap["roles"] as? [RoleName]
          }
          set {
            resultMap.updateValue(newValue, forKey: "roles")
          }
        }

        public var permissions: [String]? {
          get {
            return resultMap["permissions"] as? [String]
          }
          set {
            resultMap.updateValue(newValue, forKey: "permissions")
          }
        }

        public var featureFlagMapping: [FeatureFlagMapping]? {
          get {
            return (resultMap["featureFlagMapping"] as? [ResultMap]).flatMap { (value: [ResultMap]) -> [FeatureFlagMapping] in value.map { (value: ResultMap) -> FeatureFlagMapping in FeatureFlagMapping(unsafeResultMap: value) } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [FeatureFlagMapping]) -> [ResultMap] in value.map { (value: FeatureFlagMapping) -> ResultMap in value.resultMap } }, forKey: "featureFlagMapping")
          }
        }

        public struct FeatureFlagMapping: GraphQLSelectionSet {
          public static let possibleTypes: [String] = ["FeatureFlagMapping"]

          public static var selections: [GraphQLSelection] {
            return [
              GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
              GraphQLField("id", type: .nonNull(.scalar(Int.self))),
              GraphQLField("active", type: .nonNull(.scalar(Bool.self))),
              GraphQLField("featureFlag", type: .object(FeatureFlag.selections)),
            ]
          }

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: Int, active: Bool, featureFlag: FeatureFlag? = nil) {
            self.init(unsafeResultMap: ["__typename": "FeatureFlagMapping", "id": id, "active": active, "featureFlag": featureFlag.flatMap { (value: FeatureFlag) -> ResultMap in value.resultMap }])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: Int {
            get {
              return resultMap["id"]! as! Int
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var active: Bool {
            get {
              return resultMap["active"]! as! Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "active")
            }
          }

          public var featureFlag: FeatureFlag? {
            get {
              return (resultMap["featureFlag"] as? ResultMap).flatMap { FeatureFlag(unsafeResultMap: $0) }
            }
            set {
              resultMap.updateValue(newValue?.resultMap, forKey: "featureFlag")
            }
          }

          public struct FeatureFlag: GraphQLSelectionSet {
            public static let possibleTypes: [String] = ["FeatureFlag"]

            public static var selections: [GraphQLSelection] {
              return [
                GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
                GraphQLField("id", type: .nonNull(.scalar(Int.self))),
                GraphQLField("active", type: .nonNull(.scalar(Bool.self))),
                GraphQLField("featureIdentifier", type: .nonNull(.scalar(FeatureFlagEnum.self))),
              ]
            }

            public private(set) var resultMap: ResultMap

            public init(unsafeResultMap: ResultMap) {
              self.resultMap = unsafeResultMap
            }

            public init(id: Int, active: Bool, featureIdentifier: FeatureFlagEnum) {
              self.init(unsafeResultMap: ["__typename": "FeatureFlag", "id": id, "active": active, "featureIdentifier": featureIdentifier])
            }

            public var __typename: String {
              get {
                return resultMap["__typename"]! as! String
              }
              set {
                resultMap.updateValue(newValue, forKey: "__typename")
              }
            }

            public var id: Int {
              get {
                return resultMap["id"]! as! Int
              }
              set {
                resultMap.updateValue(newValue, forKey: "id")
              }
            }

            public var active: Bool {
              get {
                return resultMap["active"]! as! Bool
              }
              set {
                resultMap.updateValue(newValue, forKey: "active")
              }
            }

            public var featureIdentifier: FeatureFlagEnum {
              get {
                return resultMap["featureIdentifier"]! as! FeatureFlagEnum
              }
              set {
                resultMap.updateValue(newValue, forKey: "featureIdentifier")
              }
            }
          }
        }
      }
    }
  }
}
