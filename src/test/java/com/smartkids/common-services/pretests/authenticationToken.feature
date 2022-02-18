Feature: Auth token Creation for User

Background:
  * def jsUtils = read('classpath:jsUtils.js')
  * print authTokenUrl
  * print tenantId
  
  Scenario: Auth token Creation scenario
    Given url authTokenUrl
    And request { "username": '#(authUsername)' , "password": '#(authPassword)' }
    When method post
    Then status 200
    * print response
    And def authResponseBody = response
    And def authResponseHeader = responseHeaders
    And def authTokenResponse = authResponseBody
    And def authToken = authResponseBody.adultProfile.token
    And def subjectsFromLogin = authResponseBody.adultProfile.subjects

