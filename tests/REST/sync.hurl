GET https://api.todoist.com/rest/v2/projects 
Authorization: Bearer e0007362ae4002e7ce38bc9cf5f17b71f3fc6750

HTTP 200

[Asserts]
jsonpath "$" count == 2
