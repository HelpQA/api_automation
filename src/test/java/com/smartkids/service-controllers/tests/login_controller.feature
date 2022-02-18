Feature: Login Feature File


Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def authConstants = read('../../service-controllers/constants/authentication_constants.yaml')
    * def username = authConstants.creds.username
    * def password = authConstants.creds.password

@getLogin @LoginController @positive @regression 
Scenario: Validate Login Controller - Login to Application
    * call read('../../service-controllers/pretests/loginControllerPretest.feature@getLogin')
    * match response.adultProfile.username == '#(authUsername)'

@getLogin @LoginController @positive @regression 
Scenario: Validate Login Controller - Login to Application
    * def username = randomString(10)
    * def password = randomString(10)
    * call read('../../service-controllers/pretests/loginControllerPretest.feature@getLogin')
    * match getLoginResponse == ''
    * match getLoginResponse.username == '#null'


 

