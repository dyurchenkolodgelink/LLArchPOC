// @generated
//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

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
        }
      }
    }
    """

  public let operationName: String = "login"

  public let operationIdentifier: String? = "cf4247297b005ea9fcb33a898bfe4bd7a6b480cfeb9f5c673debabc8652b2b16"

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
          ]
        }

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(emailAddress: String, phoneNumber: String? = nil, firstName: String, lastName: String, userId: String, company: String? = nil, position: String? = nil) {
          self.init(unsafeResultMap: ["__typename": "Me", "emailAddress": emailAddress, "phoneNumber": phoneNumber, "firstName": firstName, "lastName": lastName, "userId": userId, "company": company, "position": position])
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
      }
    }
    """

  public let operationName: String = "me"

  public let operationIdentifier: String? = "30693ecaf14fb1d5703e468936f3c4ce1c2db971a72f02738ced0e3fdec9c9c5"

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
        ]
      }

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(emailAddress: String, phoneNumber: String? = nil, firstName: String, lastName: String, userId: String, company: String? = nil, position: String? = nil) {
        self.init(unsafeResultMap: ["__typename": "Me", "emailAddress": emailAddress, "phoneNumber": phoneNumber, "firstName": firstName, "lastName": lastName, "userId": userId, "company": company, "position": position])
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
    }
  }
}
