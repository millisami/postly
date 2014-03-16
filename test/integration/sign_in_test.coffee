module 'Sigin In', ->
  setup: ->
    App.reset()

  teardown: ->
    $.mockjaxClear()

test 'Invalid Sign In', ->
  $.mockjax
    url: "/auth"
    type: 'post'
    status: 200
    dataType: "json"
    responseText:
      user: { id: '1', auth_token: 'the-auth-token' }

  visit('/')
  click("a:contains('Sign In')")
  # ok find('h2:contains("Sign In")').length
  fillIn('input[name="email"]', 'test@example.com')
  fillIn('input[name="password"]', 'sekret')
  click("button:contains('Sign In')")
  andThen ->
    ok find("Sign Out").length, 'expected Sign Out link'
