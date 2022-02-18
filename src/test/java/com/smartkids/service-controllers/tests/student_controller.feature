Feature: Student Controller

Background:
    * def jsUtils = read('classpath:jsUtils.js')
@getHomeworkBySubject @studentController @positive @regression 
Scenario: Validate Student Controller - Get Homework By Subject
    * def getHomeworkBySubjectUrlTest = replaceString(replaceString(getHomeworkBySubjectUrl,"<<username>>",authUserId),"<<subject>>",subjectsFromLogin[0])
    * call read('../../service-controllers/pretests/studentControllerPretest.feature@getHomeworkBySubjectSuccess')
    * match getHomeworkBySubjectResponse.object.data[0].id == "#present"
    * match getHomeworkBySubjectResponse.object.data[0].userid == authUserId

@getHomeworkHistory @studentController @positive @regression 
Scenario: Validate Student Controller - Get Homework History
    * def getHomeworkHistoryUrlTest = replaceString(getHomeworkHistoryUrl,"<<username>>",authUserId)
    * print getHomeworkHistoryUrlTest
    * call read('../../service-controllers/pretests/studentControllerPretest.feature@getHomeworkHistorySuccess')
    * match getHomeworkBySubjectResponse.object.data[0].id == "#present"
    * match getHomeworkBySubjectResponse.object.data[0].userid == authUserId

@getHomeworkHistoryByStudentNameAndSubject @studentController @positive @regression 
Scenario: Validate Student Controller - Get Homework History By Student Name and Subject
    * def getHomeworkHistoryByStudentNameAndUrlTest = replaceString(replaceString(getHomeworkHistoryByStudentNameAndSubjectUrl,"<<username>>",authUserId),"<<subject>>",subjectsFromLogin[0])
    * call read('../../service-controllers/pretests/studentControllerPretest.feature@getHomeworkHistoryByStudentNameAndSubjectSuccess')
    * match getHomeworkBySubjectResponse.object.data[0].id == "#present"
    * match getHomeworkBySubjectResponse.object.data[0].userid == authUserId


@getDueHomework @studentController @positive @regression 
Scenario: Validate Student Controller - Get Homework History By Student Name and Subject
    * def getDueHomeworkUrlTest = replaceString(getDueHomeworkSuccessUrl,"<<username>>",authUserId)
    * call read('../../service-controllers/pretests/studentControllerPretest.feature@getDueHomeworkSuccess')
    * match getHomeworkBySubjectResponse.object.data[0].id == "#present"
    * match getHomeworkBySubjectResponse.object.data[0].userid == authUserId

@getDueHomeworkList @studentController @positive @regression 
Scenario: Validate Student Controller - Get Homework History By Student Name and Subject
    * def getDueHomeworkListUrlTest = replaceString(getDueHomeworkListUrl,"<<username>>",authUserId)
    * call read('../../service-controllers/pretests/studentControllerPretest.feature@getDueHomeworkListSuccess')
    * match getHomeworkBySubjectResponse.object.data[0].id == "#present"
    * match getHomeworkBySubjectResponse.object.data[0].userid == authUserId

@getTopicsByGradeAndSubject @studentController @positive @regression 
Scenario: Validate Student Controller - Get topics by grade and subject
    * def getTopicsByGradeAndSubjectUrlTest = replaceString(replaceString(getTopicsByGradeAndSubjectUrl,"<<grade>>","3"),"<<subject>>",subjectsFromLogin[1])
    * call read('../../service-controllers/pretests/studentControllerPretest.feature@getTopicsByGradeAndSubjectSuccess')
    * match getHomeworkBySubjectResponse.object.profile.adultProfile.username == authUsername

@getTopicByKey @studentController @positive @regression 
Scenario: Validate Student Controller - Get topics by key
    * def getTopicsByGradeAndSubjectUrlTest = replaceString(replaceString(getTopicsByGradeAndSubjectUrl,"<<grade>>","3"),"<<subject>>","SOL_"+subjectsFromLogin[0])
    * print "getTopicsByGradeAndSubjectUrlTest ===>" + getTopicsByGradeAndSubjectUrlTest
    * call read('../../service-controllers/pretests/studentControllerPretest.feature@getTopicsByGradeAndSubjectSuccess')
    * def getTopicByKeyUrlTest = replaceString(getTopicByKeyUrl,"<<topic_key>>",topicID)
    * print "getTopicByKeyUrlTest ===> " +  getTopicByKeyUrlTest
    * call read('../../service-controllers/pretests/studentControllerPretest.feature@getTopicByKeySuccess')
    * match getHomeworkBySubjectResponse.object.topic.id == topicID
