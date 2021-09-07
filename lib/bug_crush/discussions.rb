# typed: strict
require 'forwardable'
require "graphql/client"
require "graphql/client/http"

module BugCrush
  class Discussions
    extend Forwardable
    def_delegators :@properties, :[], :[]=

    def initialize()
      @properties = {
      }
    end

    def data
      @data ||= all_discussions.data
      raise StandardError, "no data:\nMake sure that GITHUB_TOKEN is set properly." unless @data.present?
      @data
    end

    def discussions
      nodes = data.repository.discussions.nodes

      nodes.map { |node|
        Discussion.new(node)
      }
    end

    HTTP = GraphQL::Client::HTTP.new("https://api.github.com/graphql") do
        def headers(context)
          # Authorize GraphQL API with a GITHUB_TOKEN
          { "Authorization": "bearer #{ENV["GITHUB_TOKEN"]}" }
        end
      end
    Schema = GraphQL::Client.load_schema("./lib/graphql/github/schema.json")
    Client = GraphQL::Client.new(schema: Schema, execute: HTTP)
    AllDiscussions = 
      Client.parse <<-'GRAPHQL'
query {
  repository(owner: "fluxcd", name: "flux2") {
    discussions(first: 100) {
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
        lastEditedAt
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

  private

    def all_discussions
      @all_discussions ||= Client.query(AllDiscussions)
      raise StandardError, "query failed:\n#{all_discussions_errors}" unless all_discussions_ok?
      @all_discussions
    end

    def all_discussions_errors
      @all_discussions&.errors&.all&.details&.[](:data)
    end
    def all_discussions_ok?
      @all_discussions&.data&.repository.present?
    end

  end

  class Discussion
    def initialize(node)
      @node = node
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
      node.author.login
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
      node.published_at
    end

    def updated
      node.last_edited_at
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
