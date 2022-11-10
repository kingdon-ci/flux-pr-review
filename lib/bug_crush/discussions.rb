# typed: strict
require 'forwardable'
require "graphql/client"
require "graphql/client/http"
require 'csv'

module BugCrush
  class Discussions
    extend Forwardable
    def_delegators :@properties, :[], :[]=

    def initialize()
      @properties = {
      }
    end

    def data_pages_in_nodes
      per_page = 100

      page1 = Client.query(AllDiscussions, variables: {after:nil, perPage:per_page})
      c_p2 = page1.data.repository.discussions.page_info.end_cursor
      page2 = Client.query(AllDiscussions, variables: {after:c_p2, perPage:per_page})
      c_p3 = page2.data.repository.discussions.page_info.end_cursor
      page3 = Client.query(AllDiscussions, variables: {after:c_p3, perPage:per_page})
      c_p4 = page3.data.repository.discussions.page_info.end_cursor
      page4 = Client.query(AllDiscussions, variables: {after:c_p4, perPage:per_page})
      c_p5 = page4.data.repository.discussions.page_info.end_cursor
      page5 = Client.query(AllDiscussions, variables: {after:c_p5, perPage:per_page})
      c_p6 = page5.data.repository.discussions.page_info.end_cursor
      page6 = Client.query(AllDiscussions, variables: {after:c_p6, perPage:per_page})
      c_p7 = page6.data.repository.discussions.page_info.end_cursor
      page7 = Client.query(AllDiscussions, variables: {after:c_p7, perPage:per_page})
      c_p8 = page7.data.repository.discussions.page_info.end_cursor
      page8 = Client.query(AllDiscussions, variables: {after:c_p8, perPage:per_page})
      c_p9 = page8.data.repository.discussions.page_info.end_cursor
      page9 = Client.query(AllDiscussions, variables: {after:c_p9, perPage:per_page})
      c_p10 = page9.data.repository.discussions.page_info.end_cursor
      page10 = Client.query(AllDiscussions, variables: {after:c_p10, perPage:per_page})

      # raise StandardError, "no data:\nMake sure that GITHUB_TOKEN is set properly." unless
      #   page1&.present? &&
      #   page2&.present? &&
      #   page3&.present? &&
      #   page4&.present? &&
      #   page5&.present?

      max_count = 999

      if page10.data.repository.discussions.total_count > max_count
        puts "The Flux Discussions have grown again! Add another page\n"
          + "to the horrible code that implements 'paging' for next week,\n"
          + "and bump the max_count variable up by another #{per_page}."
      end

      raise StandardError, "no data:\nMake sure that GITHUB_TOKEN is set properly." unless
        page1&.present? &&
        page2&.present? &&
        page3&.present? &&
        page4&.present? &&
        page5&.present? &&
        page6&.present? &&
        page7&.present? &&
        page8&.present? &&
        page9&.present? &&
        page10&.present?

        page1.data.repository.discussions.nodes \
        + page2.data.repository.discussions.nodes \
        + page3.data.repository.discussions.nodes \
        + page4.data.repository.discussions.nodes \
        + page5.data.repository.discussions.nodes \
        + page6.data.repository.discussions.nodes \
        + page7.data.repository.discussions.nodes \
        + page8.data.repository.discussions.nodes \
        + page9.data.repository.discussions.nodes \
        + page10.data.repository.discussions.nodes

    rescue NoMethodError, StandardError
      raise StandardError, "no data:\nMake sure that GITHUB_TOKEN is set properly."
    end

    def header
      "Repository,Type,#,User,Title,State,Created,Updated,Merged,URL\n"
    end

    def discussions
      @nodes ||= data_pages_in_nodes

      @nodes.map { |node|
        Discussion.new(node)
      }

      self
    end

    def to_csv
      discussions
      header +
      @nodes.map {|d|
        Discussion.new(d).to_csv
      }.join
    end

    HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
        def headers(context)
          # Authorize GraphQL API with a GITHUB_TOKEN
          { "Authorization": "bearer #{ENV["GITHUB_TOKEN"]}" }
        end
      end
    Schema = GraphQL::Client.load_schema("./lib/graphql/github/schema.json")
    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
    QueryString = <<-'GRAPHQL'
query($after: String, $perPage: Int) {
  repository(owner: "fluxcd", name: "flux2") {
    discussions(first: $perPage after: $after,
      orderBy: {field: UPDATED_AT, direction: DESC}) {
      # type: DiscussionConnection
      totalCount # Int!

      pageInfo {
        # type: PageInfo (from the public schema)
        startCursor
        endCursor
        hasNextPage
        hasPreviousPage
      }

      edges {
        # type: DiscussionEdge
        cursor
        node {
          # type: Discussion
          id
        }
      }

      nodes {
        # type: Discussion
        id
        url
        publishedAt
        updatedAt
        answerChosenAt
        title
        author {
          login
        }

        comments(last: 1)
      }
    }
  }
}
      GRAPHQL
    AllDiscussions = Client.parse(QueryString)

  private

    # def all_discussions(query, parameters:)
    #   all_discussions = Client.query(query, variables: parameters)
    #   raise StandardError, "query failed:\n#{errors(all_discussions)}" unless ok?(all_discussions)
    #   all_discussions
    # end

    # def errors(resp)
    #   resp&.errors&.all&.details&.[](:data)
    # end
    # def ok?(resp)
    #   resp&.data&.repository.present?
    # end

  end

  class Discussion
    def initialize(node)
      @node = node
    end

    def inspect
      to_csv
    end

    def to_csv
      [repository, type, num, user, title, state, created, updated, "N/A", url].to_csv
    end

    def repository
      "fluxcd/flux2"
    end

    def type
      "Discussion"
    end

    def num
      url.gsub("https://github.com/fluxcd/flux2/discussions/", "")
    end

    def user
      node.author&.login || ''
    end

    def title
      node.title
    end

    def state
      answeredAt = node.answer_chosen_at
      if answeredAt.nil?
        "open"
      else
        "answered"
      end
    end

    def created
      DateTime.parse(node.published_at).strftime("%m/%d/%y %H:%M:%S")
    end

    def updated
      d = DateTime.parse(node.updated_at) # || node.published_at)
      if d.present?
        d.strftime("%m/%d/%y %H:%M:%S")
      else
        ''
      end
    rescue TypeError
      ''
    end

    def url
      node.url
    end

    private

    def node
      @node
    end
  end
end
