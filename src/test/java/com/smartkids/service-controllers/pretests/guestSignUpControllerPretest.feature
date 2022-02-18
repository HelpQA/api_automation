Feature: Guest User

Background:

    * def filePath = '../../service-controllers/requestPayload/fileUpload/france.jpg'
    
@postGuestUserSignUp
    Scenario: Sign Up Guest USer
        Given url postGuestSignUpURL
        And header Authorization = appToken
        And request { "installationId": '#(installationId)' , "name": '#(guestUserName)' }
        When method post
        Then status 200
        And def guestUserCreateResponse = response
        * print "User Created with UserId->" + guestUserCreateResponse.object.adultProfile.userid

@postUploadImage
    Scenario: upload image to guest user 
        Given url postUploadProfilePicURL
        And header Authorization = guestToken
        And multipart file file = {read : '#(filePath)' , filename: 'MyFile' , contentType: 'multipart/form-data'}
        When method post
        Then status 200
        And def guestUploadImage = response

    @postUpdateGrades
    Scenario: upload image to guest user 
        Given url postUpdateGradeURLTest
        And header Authorization = guestToken
        And request { "userid": '#(guestUserId)' , "grade": 5 }
        When method post
        Then status 200
        And def guestUserGradeUpdate = response
        #* print guestUserGradeUpdate

      