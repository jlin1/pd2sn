require 'rubygems'
require 'sinatra'
require 'net/https'
require 'uri'

post '/shunt' do
uri = URI.parse(params[:uri])
http = Net::HTTP.new(uri.host, uri.port)
http.read_timeout = 3
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_NONE
outgoing = Net::HTTP::Post.new(uri.request_uri)
outgoing.body = request.body.read
outgoing.content_type = request.media_type

# Enhance the webhook here.
# For example, to add basic auth:
outgoing.basic_auth("026159822", "pass01")

response = http.request(outgoing)
[response.code, response.body]
end