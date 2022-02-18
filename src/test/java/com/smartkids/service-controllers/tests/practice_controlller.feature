Feature: Student Controller

Background:
    * def jsUtils = read('classpath:jsUtils.js')

@getPracticeSubjectWise @practiceController @positive @regression 
Scenario: Validate Practice Controller : Get All practice papers by login
    * def getHomeworkBySubjectUrlTest = replaceString(getPracticeSujectWiseURL,"<<subject>>",subjectsFromLogin[1])
    * print 'getHomeworkBySubjectUrlTest ===> ' + getHomeworkBySubjectUrlTest
    * call read('../../service-controllers/pretests/practiceControllerPretest.feature@getPracticequestionSubjectWise')
    * match getPracticeSubjectWiseResponse.object.data.scores == "#present"
    * match getPracticeSubjectWiseResponse.object.data.topic == "#present"
    * match getPracticeSubjectWiseResponse.object.profile.adultProfile.username == authUsername
