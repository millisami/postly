module.exports = App.SignInController = Ember.ObjectController.extend

  email: null
  password: null

  actions:
    sign_in: ->
      data =
        user: @getProperties('email', 'password')

      request = Ember.$.ajax
        url: '/auth'
        type: 'post'
        data: JSON.stringify(data)
        dataType: 'json'
        headers:
          Accept: 'application/json'

      request.success (data, textStatus, jqXHR) =>
        Ember.run =>
          log.info 'Successfully Signed In'

          @get('session').
            setProperties('userId': data.user_id)
            # setProperties('authToken': data.auth_token, 'userId': data.user_id)

          @store.find('user', data.user_id).then (user) =>
            @set('session.currentUser', user)
            @transitionToRoute 'index'

      request.fail (jqXHR, textStatus, errorThrown) ->
        Ember.run ->
          log.info "Invalid Credentials: #{errorThrown}"

