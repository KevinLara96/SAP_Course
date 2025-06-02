# Settinh API endpoints and credentials 
export CLIENT_ID='sb-51a90fbf-8ab2-42df-a0cb-145db26920ed!b66632|it-rt-f1b2a69ftrial!b196'
export CLIENT_SECRET='1135084f-d416-474e-9588-52fd73cbfe13$FuWDYZT_DwElPv6P_xiXB7sOWMbyDBrBQwpIrjRz_Nc='
export TOKEN_ENDPOINT='https://f1b2a69ftrial.authentication.ap21.hana.ondemand.com/oauth/token'
export API_ENDPOINT='https://f1b2a69ftrial.it-cpitrial03-rt.cfapps.ap21.hana.ondemand.com/http/products/details'

# Get Bearer token
response=$(curl -X POST "$TOKEN_ENDPOINT" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "client_id=$CLIENT_ID&client_secret=$CLIENT_SECRET&grant_type=client_credentials")

access_token=$(echo "$response" | grep -oE '"access_token":"[^"]+"' | sed -E 's/"access_token":"([^"]+)"/\1/')

# Consume API proxy 
product_resp=$(curl -X POST -w "\n%{http_code}" "$API_ENDPOINT" \
  -H "Authorization: Bearer $access_token" \
  -H "Content-Type: application/json" \
  -d '{ "productIdentifier":"HT-9999" }')

http_status=$(echo "$product_resp" | tail -n1)

# Print result
echo "HTTP Status: $http_status"
echo "$product_resp" | head -n 5
