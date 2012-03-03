# coding: utf-8

require "fluent/plugin/in_twitter_search/version"

module Fluent
  class TwitterSearchInput < Fluent::Input
    Fluent::Plugin.register_input('twitter_search', self)

    config_param :user, :string
    config_param :password, :string
    config_param :word, :string
    config_param :debug_mode :bool

    App = "twitter"

    def d(msg)
      Fluent::Engine.emit("#{App}.debug", Fluent::Engine.now, msg) if @debug_mode
    end

    def start
      require 'net/https'
      require 'uri'
      require 'json'
      target = URI.parse("https://stream.twitter.com/1/statuses/filter.json")	
      https = Net::HTTP.new(target.host, target.port)
      d('state' => 'HTTP object created')
      https.use_ssl = true
      https.start do |https|
      d('state' => 'HTTP connnect')
        req = Net::HTTP::Post.new(target.request_uri)
        req.basic_auth(@user, @password)
        req.set_form_data('track' => @word)
        d('state' => 'HTTP parameter set')
        https.request(req) do |res|
          d('state' => 'HTTP request')
          d('response code' => res.code.to_i)
          break unless res.code.to_i == 200
          raise 'Response is not chuncked' unless res.chunked?
          res.read_body do |chunk|
            result = JSON.parse(chunk) rescue next
            next unless result['text']
            next if result['user']['lang'] != "ja"
            Fluent::Engine.emit("#{App}.statuses", Fluent::Engine.now, result)
          end
        end
      end
    end
  end
end
