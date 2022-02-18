Feature: Login application with Guest User and update parameters

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def authConstants = read('../../service-controllers/constants/authentication_constants.yaml')
    * def username = authConstants.creds.username
    * def password = authConstants.creds.password
    * def constantInProject = read('../../service-controllers/constants/constants_placeholder.yaml')
    * def installationId = uuidv4();
    #* def guestUserName = ranString(10);
    * def appToken = constantInProject.constType.APP_TOKEN


@postGuestSignUp @guestUser @positive @regression 
Scenario: Guest User Sign Up
    * def guestUserName = ranString(10);
    * call read('../../service-controllers/pretests/guestSignUpControllerPretest.feature@postGuestUserSignUp')
    * match guestUserCreateResponse.statusCode.code == 200
    * match guestUserCreateResponse.statusCode.message == "OK"
    * match guestUserCreateResponse.object.adultProfile.guest == true
    * match guestUserCreateResponse.object.adultProfile.name == guestUserName
    * match guestUserCreateResponse.object.adultProfile.userid == "#present"
    * match guestUserCreateResponse.object.adultProfile.firstName == "#present"

@uploadImageToGuestProfile @guestUser @positive @regression 
Scenario: Upload Image to guest user profile
    * def guestUserName = ranString(10);
    * call read('../../service-controllers/pretests/guestSignUpControllerPretest.feature@postGuestUserSignUp')
    * def guestToken = guestUserCreateResponse.object.adultProfile.token
    * call read('../../service-controllers/pretests/guestSignUpControllerPretest.feature@postUploadImage')
    * match guestUserCreateResponse.statusCode.code == 200
    * match guestUserCreateResponse.statusCode.message == "OK"
    * match guestUserCreateResponse.object.adultProfile.guest == true
    * match guestUserCreateResponse.object.adultProfile.name == guestUserName
    * match guestUserCreateResponse.object.adultProfile.userid == "#present"
    * match guestUserCreateResponse.object.adultProfile.firstName == "#present"

@updateGrades @guestUser @positive @regression 
Scenario: update grades of guest student
    * def guestUserName = ranString(10);
    * call read('../../service-controllers/pretests/guestSignUpControllerPretest.feature@postGuestUserSignUp')
    * def guestUserId = guestUserCreateResponse.object.adultProfile.userid
    * def guestToken = guestUserCreateResponse.object.adultProfile.token
    * def postUpdateGradeURLTest = replaceString(postUpdateGradeURL,"<<guestUserid>>",guestUserId)    
    * call read('../../service-controllers/pretests/guestSignUpControllerPretest.feature@postUpdateGrades')
    * match guestUserCreateResponse.statusCode.code == 200
    * match guestUserCreateResponse.statusCode.message == "OK"
    * match guestUserCreateResponse.object.adultProfile.guest == true
    * match guestUserCreateResponse.object.adultProfile.name == guestUserName
    * match guestUserCreateResponse.object.adultProfile.userid == "#present"
    * match guestUserCreateResponse.object.adultProfile.firstName == "#present"