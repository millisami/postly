Ember.Application.initializer
  name: "session"

  initialize: (container, application) ->
    App.Session = Ember.Object.extend
      init: ->
        @_super()
        @set 'userId', localStorage.user_id
        @set 'authToken', localStorage.remember_token
        @set 'currentUser', JSON.parse localStorage.current_user if localStorage.current_user

        Ember.$.ajaxPrefilter (options, originalOptions, jqXHR) =>
          jqXHR.setRequestHeader "Authorization", "AUTH-TOKEN " + @get('authToken') if @get('signedIn')

      authTokenChanged: ( ->
        localStorage.remember_token = @get('authToken')
      ).observes('authToken')

      userIdChanged: ( ->
        localStorage.user_id = @get('userId')
      ).observes('userId')

      currentUserChanged: ( ->
        localStorage.current_user = JSON.stringify @get('currentUser')
      ).observes('currentUser')

      signedIn: ( ->
        !Ember.isEmpty @get('authToken')
      ).property('authToken')

      destroy: ->
        @setProperties('authToken': '', 'userId': '', 'userContext': '', 'currentUser': '')
        log.info 'Session destroyed'

    container.register 'session:current', App.Session, singleton: true
    container.typeInjection 'controller', 'session', 'session:current'
    container.typeInjection 'route', 'session', 'session:current'
    container.typeInjection 'view', 'session', 'session:current'
