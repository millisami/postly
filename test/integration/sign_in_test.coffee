module 'Sigin In', ->
  setup: ->
    fakehr.start()

  teardown: ->
    fakehr.reset()
    App.reset()

test 'Invalid Sign In', ->
  visit '/'
  .click("a:contains('Sign In')")
  # .ok find('h2:contains("Sign In")').length
  .fillIn('input[name="email"]', 'test@example.com')
  .fillIn('input[name="password"]', 'sekret')
  .click("button:contains('Sign In')")
  .then (->
    ok find("Sign Out").length, 'expected Sign Out link'
  )
  .httpRespond("post", "/auth", user_id: 1)
  # andThen ->
  #   ok find('.login_status:contains("Sign Out")').length, 'expected Sign Out link'




