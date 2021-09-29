import XCTest
import Combine
import Apollo

@testable import Sync


class APISlateServiceTests: XCTestCase {
    var apollo: MockApolloClient!

    override func setUpWithError() throws {
        apollo = MockApolloClient()
    }

    func subject(apollo: MockApolloClient? = nil) -> APISlateService {
        APISlateService(apollo: apollo ?? self.apollo)
    }

    func test_fetchSlates_returnsSlates() async throws {
        apollo.stubFetch(toReturnFixturedNamed: "slates", asResultType: GetSlateLineupQuery.self)

        let slates = try await subject().fetchSlates()

        XCTAssertEqual(slates.count, 2)

        do {
            let slate = slates[0]
            XCTAssertEqual(slate.id, "slate-1")
            XCTAssertEqual(slate.name, "Slate 1")
            XCTAssertEqual(slate.description, "The description of slate 1")
            XCTAssertEqual(slate.recommendations.count, 2)

            let recommendations = slate.recommendations

            do {
                let recommendation = recommendations[0]
                XCTAssertEqual(recommendation.id, "slate-1-rec-1")
            }

            do {
                let recommendation = recommendations[1]
                XCTAssertEqual(recommendation.id, "slate-1-rec-2")
            }
        }

        do {
            let slate = slates[1]
            XCTAssertEqual(slate.id, "slate-2")
            XCTAssertEqual(slate.name, "Slate 2")
            XCTAssertEqual(slate.description, "The description of slate 2")
            XCTAssertEqual(slate.recommendations.count, 1)

            let recommendation = slate.recommendations[0]
            XCTAssertEqual(recommendation.id, "slate-2-rec-1")
            XCTAssertEqual(recommendation.url, URL(string: "https://resolved.example.com/rec-1")!)
            XCTAssertEqual(recommendation.itemID, "slate-2-item-1")
            XCTAssertEqual(recommendation.feedID, 2)
            XCTAssertEqual(recommendation.publisher, "lifehacker.com")
            XCTAssertEqual(recommendation.source, "RecommendationAPI")
            XCTAssertEqual(recommendation.title, "Slate 2, Recommendation 1")
            XCTAssertEqual(recommendation.language, "en")
            XCTAssertEqual(recommendation.topImageURL, URL(string: "http://example.com/slate-2-rec-1/top-image.png"))
            XCTAssertEqual(recommendation.timeToRead, 3)
            XCTAssertEqual(recommendation.particleJSON, "{}")
            XCTAssertEqual(recommendation.domain, "slate-2-rec-2.example.com")
            XCTAssertEqual(recommendation.domainMetadata?.name, "Lifehacker")
        }
    }

    func test_fetchSlate_returnsSlateDetails() async throws {
        apollo.stubFetch(toReturnFixturedNamed: "slate-detail", asResultType: GetSlateQuery.self)

        let slate = try await subject().fetchSlate("the-slate-id")

        XCTAssertEqual(slate?.id, "slate-1")
        XCTAssertEqual(slate?.name, "Slate 1")
        XCTAssertEqual(slate?.description, "The description of slate 1")
        XCTAssertEqual(slate?.recommendations.count, 3)

        let recommendations = slate?.recommendations

        do {
            let recommendation = recommendations?[0]
            XCTAssertEqual(recommendation?.id, "1")
        }

        do {
            let recommendation = recommendations?[1]
            XCTAssertEqual(recommendation?.id, "2")
        }

        do {
            let recommendation = recommendations?[2]
            XCTAssertEqual(recommendation?.id, "3")
        }
    }
}
