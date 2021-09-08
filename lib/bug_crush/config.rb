# typed: strict
require 'forwardable'
require 'csv'

module BugCrush
  class Config
    extend Forwardable
    def_delegators :@properties, :[], :[]=

    def initialize(config_json: "config.json", input_file:, discussion_input_file:)
      @properties = {
        config_json: config_json,
        input_file: input_file,
        discussion_input_file: discussion_input_file,
      }
    end

    def input_file
      self[:input_file]
    end

    def config_json
      self[:config_json]
    end

    def discussion_input_file
      self[:discussion_input_file]
    end
  end
end
