curl https://api.todoist.com/sync/v9/sync `
-H "Authorization: Bearer $env:TODOIST_API_KEY" `
-d sync_token=* `
-d resource_types='["projects"]'
