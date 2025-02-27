// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class TagUpdateMutation: GraphQLMutation {
  public static let operationName: String = "TagUpdate"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      mutation TagUpdate($input: TagUpdateInput!) {
        updateTag(input: $input) {
          __typename
          name
          id
        }
      }
      """
    ))

  public var input: TagUpdateInput

  public init(input: TagUpdateInput) {
    self.input = input
  }

  public var __variables: Variables? { ["input": input] }

  public struct Data: PocketGraph.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { PocketGraph.Objects.Mutation }
    public static var __selections: [Selection] { [
      .field("updateTag", UpdateTag.self, arguments: ["input": .variable("input")]),
    ] }

    /// Updates a Tag (renames the tag), and returns the updated Tag.
    /// If a Tag with the updated name already exists in the database, will
    /// associate that Tag to all relevant SavedItems rather than creating
    /// a duplicate Tag object.
    public var updateTag: UpdateTag { __data["updateTag"] }

    /// UpdateTag
    ///
    /// Parent Type: `Tag`
    public struct UpdateTag: PocketGraph.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { PocketGraph.Objects.Tag }
      public static var __selections: [Selection] { [
        .field("name", String.self),
        .field("id", ID.self),
      ] }

      /// The actual tag string the user created for their list
      public var name: String { __data["name"] }
      /// Surrogate primary key. This is usually generated by clients, but will be generated by the server if not passed through creation
      public var id: ID { __data["id"] }
    }
  }
}
