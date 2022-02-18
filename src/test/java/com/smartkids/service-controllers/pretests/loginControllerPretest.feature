Feature: Login Controller Pretest

Background:
* def authTokenRequest = read('../../service-controllers/requestPayload/loginRequest_payload.json')

@getLogin
Scenario: Login Application
    Given url authTokenUrl
    And request authTokenRequest
    When method post
    Then status 200
    And def getLoginResponse = response
