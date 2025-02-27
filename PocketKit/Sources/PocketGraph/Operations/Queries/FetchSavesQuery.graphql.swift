// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class FetchSavesQuery: GraphQLQuery {
  public static let operationName: String = "FetchSaves"
  public static let document: ApolloAPI.DocumentType = .notPersisted(
    definition: .init(
      """
      query FetchSaves($token: String!, $pagination: PaginationInput, $savedItemsFilter: SavedItemsFilter) {
        userByToken(token: $token) {
          __typename
          isPremium
          savedItems(pagination: $pagination, filter: $savedItemsFilter) {
            __typename
            totalCount
            pageInfo {
              __typename
              hasNextPage
              endCursor
            }
            edges {
              __typename
              cursor
              node {
                __typename
                ...SavedItemParts
              }
            }
          }
        }
      }
      """,
      fragments: [SavedItemParts.self, TagParts.self, ItemParts.self, MarticleTextParts.self, ImageParts.self, MarticleDividerParts.self, MarticleTableParts.self, MarticleHeadingParts.self, MarticleCodeBlockParts.self, VideoParts.self, MarticleBulletedListParts.self, MarticleNumberedListParts.self, MarticleBlockquoteParts.self, DomainMetadataParts.self, PendingItemParts.self]
    ))

  public var token: String
  public var pagination: GraphQLNullable<PaginationInput>
  public var savedItemsFilter: GraphQLNullable<SavedItemsFilter>

  public init(
    token: String,
    pagination: GraphQLNullable<PaginationInput>,
    savedItemsFilter: GraphQLNullable<SavedItemsFilter>
  ) {
    self.token = token
    self.pagination = pagination
    self.savedItemsFilter = savedItemsFilter
  }

  public var __variables: Variables? { [
    "token": token,
    "pagination": pagination,
    "savedItemsFilter": savedItemsFilter
  ] }

  public struct Data: PocketGraph.SelectionSet {
    public let __data: DataDict
    public init(data: DataDict) { __data = data }

    public static var __parentType: ParentType { PocketGraph.Objects.Query }
    public static var __selections: [Selection] { [
      .field("userByToken", UserByToken?.self, arguments: ["token": .variable("token")]),
    ] }

    /// Gets a user entity for a given access token
    public var userByToken: UserByToken? { __data["userByToken"] }

    /// UserByToken
    ///
    /// Parent Type: `User`
    public struct UserByToken: PocketGraph.SelectionSet {
      public let __data: DataDict
      public init(data: DataDict) { __data = data }

      public static var __parentType: ParentType { PocketGraph.Objects.User }
      public static var __selections: [Selection] { [
        .field("isPremium", Bool?.self),
        .field("savedItems", SavedItems?.self, arguments: [
          "pagination": .variable("pagination"),
          "filter": .variable("savedItemsFilter")
        ]),
      ] }

      /// The user's premium status
      public var isPremium: Bool? { __data["isPremium"] }
      /// Get a general paginated listing of all SavedItems for the user
      public var savedItems: SavedItems? { __data["savedItems"] }

      /// UserByToken.SavedItems
      ///
      /// Parent Type: `SavedItemConnection`
      public struct SavedItems: PocketGraph.SelectionSet {
        public let __data: DataDict
        public init(data: DataDict) { __data = data }

        public static var __parentType: ParentType { PocketGraph.Objects.SavedItemConnection }
        public static var __selections: [Selection] { [
          .field("totalCount", Int.self),
          .field("pageInfo", PageInfo.self),
          .field("edges", [Edge?]?.self),
        ] }

        /// Identifies the total count of SavedItems in the connection.
        public var totalCount: Int { __data["totalCount"] }
        /// Information to aid in pagination.
        public var pageInfo: PageInfo { __data["pageInfo"] }
        /// A list of edges.
        public var edges: [Edge?]? { __data["edges"] }

        /// UserByToken.SavedItems.PageInfo
        ///
        /// Parent Type: `PageInfo`
        public struct PageInfo: PocketGraph.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ParentType { PocketGraph.Objects.PageInfo }
          public static var __selections: [Selection] { [
            .field("hasNextPage", Bool.self),
            .field("endCursor", String?.self),
          ] }

          /// When paginating forwards, are there more items?
          public var hasNextPage: Bool { __data["hasNextPage"] }
          /// When paginating forwards, the cursor to continue.
          public var endCursor: String? { __data["endCursor"] }
        }

        /// UserByToken.SavedItems.Edge
        ///
        /// Parent Type: `SavedItemEdge`
        public struct Edge: PocketGraph.SelectionSet {
          public let __data: DataDict
          public init(data: DataDict) { __data = data }

          public static var __parentType: ParentType { PocketGraph.Objects.SavedItemEdge }
          public static var __selections: [Selection] { [
            .field("cursor", String.self),
            .field("node", Node?.self),
          ] }

          /// A cursor for use in pagination.
          public var cursor: String { __data["cursor"] }
          /// The SavedItem at the end of the edge.
          public var node: Node? { __data["node"] }

          /// UserByToken.SavedItems.Edge.Node
          ///
          /// Parent Type: `SavedItem`
          public struct Node: PocketGraph.SelectionSet {
            public let __data: DataDict
            public init(data: DataDict) { __data = data }

            public static var __parentType: ParentType { PocketGraph.Objects.SavedItem }
            public static var __selections: [Selection] { [
              .fragment(SavedItemParts.self),
            ] }

            /// The url the user saved to their list
            public var url: String { __data["url"] }
            /// Surrogate primary key. This is usually generated by clients, but will be generated by the server if not passed through creation
            public var remoteID: ID { __data["remoteID"] }
            /// Helper property to indicate if the SavedItem is archived
            public var isArchived: Bool { __data["isArchived"] }
            /// Helper property to indicate if the SavedItem is favorited
            public var isFavorite: Bool { __data["isFavorite"] }
            /// Unix timestamp of when the entity was deleted, 30 days after this date this entity will be HARD deleted from the database and no longer exist
            public var _deletedAt: Int? { __data["_deletedAt"] }
            /// Unix timestamp of when the entity was created
            public var _createdAt: Int { __data["_createdAt"] }
            /// Timestamp that the SavedItem became archied, null if not archived
            public var archivedAt: Int? { __data["archivedAt"] }
            /// The Tags associated with this SavedItem
            public var tags: [Tag]? { __data["tags"] }
            /// Link to the underlying Pocket Item for the URL
            public var item: Item { __data["item"] }

            public struct Fragments: FragmentContainer {
              public let __data: DataDict
              public init(data: DataDict) { __data = data }

              public var savedItemParts: SavedItemParts { _toFragment() }
            }

            /// UserByToken.SavedItems.Edge.Node.Tag
            ///
            /// Parent Type: `Tag`
            public struct Tag: PocketGraph.SelectionSet {
              public let __data: DataDict
              public init(data: DataDict) { __data = data }

              public static var __parentType: ParentType { PocketGraph.Objects.Tag }

              /// The actual tag string the user created for their list
              public var name: String { __data["name"] }
              /// Surrogate primary key. This is usually generated by clients, but will be generated by the server if not passed through creation
              public var id: ID { __data["id"] }

              public struct Fragments: FragmentContainer {
                public let __data: DataDict
                public init(data: DataDict) { __data = data }

                public var tagParts: TagParts { _toFragment() }
              }
            }

            /// UserByToken.SavedItems.Edge.Node.Item
            ///
            /// Parent Type: `ItemResult`
            public struct Item: PocketGraph.SelectionSet {
              public let __data: DataDict
              public init(data: DataDict) { __data = data }

              public static var __parentType: ParentType { PocketGraph.Unions.ItemResult }

              public var asItem: AsItem? { _asInlineFragment() }
              public var asPendingItem: AsPendingItem? { _asInlineFragment() }

              /// UserByToken.SavedItems.Edge.Node.Item.AsItem
              ///
              /// Parent Type: `Item`
              public struct AsItem: PocketGraph.InlineFragment {
                public let __data: DataDict
                public init(data: DataDict) { __data = data }

                public static var __parentType: ParentType { PocketGraph.Objects.Item }

                /// The Item entity is owned by the Parser service.
                /// We only extend it in this service to make this service's schema valid.
                /// The key for this entity is the 'itemId'
                public var remoteID: String { __data["remoteID"] }
                /// key field to identify the Item entity in the Parser service
                public var givenUrl: Url { __data["givenUrl"] }
                /// If the givenUrl redirects (once or many times), this is the final url. Otherwise, same as givenUrl
                public var resolvedUrl: Url? { __data["resolvedUrl"] }
                /// The title as determined by the parser.
                public var title: String? { __data["title"] }
                /// The detected language of the article
                public var language: String? { __data["language"] }
                /// The page's / publisher's preferred thumbnail image
                @available(*, deprecated, message: "use the topImage object")
                public var topImageUrl: Url? { __data["topImageUrl"] }
                /// How long it will take to read the article (TODO in what time unit? and by what calculation?)
                public var timeToRead: Int? { __data["timeToRead"] }
                /// The domain, such as 'getpocket.com' of the {.resolved_url}
                public var domain: String? { __data["domain"] }
                /// The date the article was published
                public var datePublished: DateString? { __data["datePublished"] }
                /// true if the item is an article
                public var isArticle: Bool? { __data["isArticle"] }
                /// 0=no images, 1=contains images, 2=is an image
                public var hasImage: GraphQLEnum<Imageness>? { __data["hasImage"] }
                /// 0=no videos, 1=contains video, 2=is a video
                public var hasVideo: GraphQLEnum<Videoness>? { __data["hasVideo"] }
                /// List of Authors involved with this article
                public var authors: [ItemParts.Author?]? { __data["authors"] }
                /// The Marticle format of the article, used by clients for native article view.
                public var marticle: [Marticle]? { __data["marticle"] }
                /// A snippet of text from the article
                public var excerpt: String? { __data["excerpt"] }
                /// Additional information about the item domain, when present, use this for displaying the domain name
                public var domainMetadata: DomainMetadata? { __data["domainMetadata"] }
                /// Array of images within an article
                public var images: [ItemParts.Image?]? { __data["images"] }
                /// If the item has a syndicated counterpart the syndication information
                public var syndicatedArticle: ItemParts.SyndicatedArticle? { __data["syndicatedArticle"] }

                public struct Fragments: FragmentContainer {
                  public let __data: DataDict
                  public init(data: DataDict) { __data = data }

                  public var itemParts: ItemParts { _toFragment() }
                }

                /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle
                ///
                /// Parent Type: `MarticleComponent`
                public struct Marticle: PocketGraph.SelectionSet {
                  public let __data: DataDict
                  public init(data: DataDict) { __data = data }

                  public static var __parentType: ParentType { PocketGraph.Unions.MarticleComponent }

                  public var asMarticleText: AsMarticleText? { _asInlineFragment() }
                  public var asImage: AsImage? { _asInlineFragment() }
                  public var asMarticleDivider: AsMarticleDivider? { _asInlineFragment() }
                  public var asMarticleTable: AsMarticleTable? { _asInlineFragment() }
                  public var asMarticleHeading: AsMarticleHeading? { _asInlineFragment() }
                  public var asMarticleCodeBlock: AsMarticleCodeBlock? { _asInlineFragment() }
                  public var asVideo: AsVideo? { _asInlineFragment() }
                  public var asMarticleBulletedList: AsMarticleBulletedList? { _asInlineFragment() }
                  public var asMarticleNumberedList: AsMarticleNumberedList? { _asInlineFragment() }
                  public var asMarticleBlockquote: AsMarticleBlockquote? { _asInlineFragment() }

                  /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle.AsMarticleText
                  ///
                  /// Parent Type: `MarticleText`
                  public struct AsMarticleText: PocketGraph.InlineFragment {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public static var __parentType: ParentType { PocketGraph.Objects.MarticleText }

                    /// Markdown text content. Typically, a paragraph.
                    public var content: Markdown { __data["content"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(data: DataDict) { __data = data }

                      public var marticleTextParts: MarticleTextParts { _toFragment() }
                    }
                  }

                  /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle.AsImage
                  ///
                  /// Parent Type: `Image`
                  public struct AsImage: PocketGraph.InlineFragment {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public static var __parentType: ParentType { PocketGraph.Objects.Image }

                    /// A caption or description of the image
                    public var caption: String? { __data["caption"] }
                    /// A credit for the image, typically who the image belongs to / created by
                    public var credit: String? { __data["credit"] }
                    /// The id for placing within an Article View. {articleView.article} will have placeholders of <div id='RIL_IMG_X' /> where X is this id. Apps can download those images as needed and populate them in their article view.
                    public var imageID: Int { __data["imageID"] }
                    /// Absolute url to the image
                    @available(*, deprecated, message: "use url property moving forward")
                    public var src: String { __data["src"] }
                    /// The determined height of the image at the url
                    public var height: Int? { __data["height"] }
                    /// The determined width of the image at the url
                    public var width: Int? { __data["width"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(data: DataDict) { __data = data }

                      public var imageParts: ImageParts { _toFragment() }
                    }
                  }

                  /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle.AsMarticleDivider
                  ///
                  /// Parent Type: `MarticleDivider`
                  public struct AsMarticleDivider: PocketGraph.InlineFragment {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public static var __parentType: ParentType { PocketGraph.Objects.MarticleDivider }

                    /// Always '---'; provided for convenience if building a markdown string
                    public var content: Markdown { __data["content"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(data: DataDict) { __data = data }

                      public var marticleDividerParts: MarticleDividerParts { _toFragment() }
                    }
                  }

                  /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle.AsMarticleTable
                  ///
                  /// Parent Type: `MarticleTable`
                  public struct AsMarticleTable: PocketGraph.InlineFragment {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public static var __parentType: ParentType { PocketGraph.Objects.MarticleTable }

                    /// Raw HTML representation of the table.
                    public var html: String { __data["html"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(data: DataDict) { __data = data }

                      public var marticleTableParts: MarticleTableParts { _toFragment() }
                    }
                  }

                  /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle.AsMarticleHeading
                  ///
                  /// Parent Type: `MarticleHeading`
                  public struct AsMarticleHeading: PocketGraph.InlineFragment {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public static var __parentType: ParentType { PocketGraph.Objects.MarticleHeading }

                    /// Heading text, in markdown.
                    public var content: Markdown { __data["content"] }
                    /// Heading level. Restricted to values 1-6.
                    public var level: Int { __data["level"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(data: DataDict) { __data = data }

                      public var marticleHeadingParts: MarticleHeadingParts { _toFragment() }
                    }
                  }

                  /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle.AsMarticleCodeBlock
                  ///
                  /// Parent Type: `MarticleCodeBlock`
                  public struct AsMarticleCodeBlock: PocketGraph.InlineFragment {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public static var __parentType: ParentType { PocketGraph.Objects.MarticleCodeBlock }

                    /// Content of a pre tag
                    public var text: String { __data["text"] }
                    /// Assuming the codeblock was a programming language, this field is used to identify it.
                    public var language: Int? { __data["language"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(data: DataDict) { __data = data }

                      public var marticleCodeBlockParts: MarticleCodeBlockParts { _toFragment() }
                    }
                  }

                  /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle.AsVideo
                  ///
                  /// Parent Type: `Video`
                  public struct AsVideo: PocketGraph.InlineFragment {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public static var __parentType: ParentType { PocketGraph.Objects.Video }

                    /// If known, the height of the video in px
                    public var height: Int? { __data["height"] }
                    /// Absolute url to the video
                    public var src: String { __data["src"] }
                    /// The type of video
                    public var type: GraphQLEnum<VideoType> { __data["type"] }
                    /// The video's id within the service defined by type
                    public var vid: String? { __data["vid"] }
                    /// The id of the video within Article View. {articleView.article} will have placeholders of <div id='RIL_VID_X' /> where X is this id. Apps can download those images as needed and populate them in their article view.
                    public var videoID: Int { __data["videoID"] }
                    /// If known, the width of the video in px
                    public var width: Int? { __data["width"] }
                    /// If known, the length of the video in seconds
                    public var length: Int? { __data["length"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(data: DataDict) { __data = data }

                      public var videoParts: VideoParts { _toFragment() }
                    }
                  }

                  /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle.AsMarticleBulletedList
                  ///
                  /// Parent Type: `MarticleBulletedList`
                  public struct AsMarticleBulletedList: PocketGraph.InlineFragment {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public static var __parentType: ParentType { PocketGraph.Objects.MarticleBulletedList }

                    public var rows: [MarticleBulletedListParts.Row] { __data["rows"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(data: DataDict) { __data = data }

                      public var marticleBulletedListParts: MarticleBulletedListParts { _toFragment() }
                    }
                  }

                  /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle.AsMarticleNumberedList
                  ///
                  /// Parent Type: `MarticleNumberedList`
                  public struct AsMarticleNumberedList: PocketGraph.InlineFragment {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public static var __parentType: ParentType { PocketGraph.Objects.MarticleNumberedList }

                    public var rows: [MarticleNumberedListParts.Row] { __data["rows"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(data: DataDict) { __data = data }

                      public var marticleNumberedListParts: MarticleNumberedListParts { _toFragment() }
                    }
                  }

                  /// UserByToken.SavedItems.Edge.Node.Item.AsItem.Marticle.AsMarticleBlockquote
                  ///
                  /// Parent Type: `MarticleBlockquote`
                  public struct AsMarticleBlockquote: PocketGraph.InlineFragment {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public static var __parentType: ParentType { PocketGraph.Objects.MarticleBlockquote }

                    /// Markdown text content.
                    public var content: Markdown { __data["content"] }

                    public struct Fragments: FragmentContainer {
                      public let __data: DataDict
                      public init(data: DataDict) { __data = data }

                      public var marticleBlockquoteParts: MarticleBlockquoteParts { _toFragment() }
                    }
                  }
                }

                /// UserByToken.SavedItems.Edge.Node.Item.AsItem.DomainMetadata
                ///
                /// Parent Type: `DomainMetadata`
                public struct DomainMetadata: PocketGraph.SelectionSet {
                  public let __data: DataDict
                  public init(data: DataDict) { __data = data }

                  public static var __parentType: ParentType { PocketGraph.Objects.DomainMetadata }

                  /// The name of the domain (e.g., The New York Times)
                  public var name: String? { __data["name"] }
                  /// Url for the logo image
                  public var logo: Url? { __data["logo"] }

                  public struct Fragments: FragmentContainer {
                    public let __data: DataDict
                    public init(data: DataDict) { __data = data }

                    public var domainMetadataParts: DomainMetadataParts { _toFragment() }
                  }
                }
              }

              /// UserByToken.SavedItems.Edge.Node.Item.AsPendingItem
              ///
              /// Parent Type: `PendingItem`
              public struct AsPendingItem: PocketGraph.InlineFragment {
                public let __data: DataDict
                public init(data: DataDict) { __data = data }

                public static var __parentType: ParentType { PocketGraph.Objects.PendingItem }

                /// URL of the item that the user gave for the SavedItem
                /// that is pending processing by parser
                public var url: Url { __data["url"] }
                public var status: GraphQLEnum<PendingItemStatus>? { __data["status"] }

                public struct Fragments: FragmentContainer {
                  public let __data: DataDict
                  public init(data: DataDict) { __data = data }

                  public var pendingItemParts: PendingItemParts { _toFragment() }
                }
              }
            }
          }
        }
      }
    }
  }
}
