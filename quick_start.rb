require 'googleauth'
require 'googleauth/stores/file_token_store'
    
OOB_URI = 'urn:ietf:wg:oauth:2.0:oob'
user_id = ''
    
client_id = Google::Auth::ClientId.from_file('./client_secret.json')
token_store = Google::Auth::Stores::FileTokenStore.new(file: 'google_api.yml')
scope = 'https://www.googleapis.com/auth/calendar'
authorizer = Google::Auth::UserAuthorizer.new(client_id, scope, token_store)
    
credentials = authorizer.get_credentials(user_id)
    
if credentials.nil?
   url = authorizer.get_authorization_url(base_url: OOB_URI)
   puts "ブラウザで次のURLを開き、APIを許可してください"
   puts url
   puts '応答ページに表示されるコードを入力してください'
   print 'code:' 
   code = gets
   credentials = authorizer.get_and_store_credentials_from_code(
       user_id: user_id,
       code: code,
       base_url: OOB_URI
   )
end