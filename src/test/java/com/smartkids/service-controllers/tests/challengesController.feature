Feature: Login application and take Challenges

Background:
    * def jsUtils = read('classpath:jsUtils.js')
    * def authConstants = read('../../service-controllers/constants/authentication_constants.yaml')
    * def username = authConstants.creds.username
    * def password = authConstants.creds.password
    * def subjectListExtracted = read('../../service-controllers/requestPayload/request_payload_folder_placeholder/subjectList.json')
    * def questionAnswerExtracted = read('../../service-controllers/requestPayload/request_payload_folder_placeholder/questionAnswer.json')
    * def createBPARequest = read('../../service-controllers/requestPayload/challenge-questions/loadPage.json')
    * def challengeConstants = read('../../service-controllers/constants/challengeService.yaml')

    # Load Page Request
    * def pageName = challengeConstants.paramaters.pageName
    * def subject = challengeConstants.paramaters.subject
    * def actionPageLoad = challengeConstants.paramaters.actions.loadPage
    * def sessionId = uuidv4();
    * def eventId = uuidv4();
    * def timestamp = Date.now()
    * def version = challengeConstants.paramaters.version

    # Start Lesson Request
    * def startLessonProgress = challengeConstants.paramaters.startLessonProgress
    * def startLessonQuestion = challengeConstants.paramaters.startLessonQuestion
    #* def lessonKey = challengeConstants.paramaters.lessonKey
    * def attemptId = uuidv4();
    * def isReviewFalse = challengeConstants.paramaters.isReviewFalse
    * def actionStartLesson = challengeConstants.paramaters.actions.startLession
    * def eventId = uuidv4();

    # Load Question 
    * def questionStartTime = Date.now()
    * def loadquestionProgress = challengeConstants.paramaters.loadquestionProgress
    * def loadquestionNumber = challengeConstants.paramaters.loadquestionNumber

    #Score and End Lesson
    * def scorequestionProgress = challengeConstants.paramaters.scorequestionProgress
    * def scorequestionNumber = challengeConstants.paramaters.scorequestionNumber
    * def endlessonquestionProgress = challengeConstants.paramaters.endlessonquestionProgress
    * def endlessonquestionNumber = challengeConstants.paramaters.endlessonquestionNumber

    #action values
    * def actionCorrectAnswer = challengeConstants.paramaters.actions.correctAnswer
    * def actionIncorrectAnswer = challengeConstants.paramaters.actions.incorrectAnswer
    * def actionScoreLesson = challengeConstants.paramaters.actions.scoreLesson
    * def actionEndLesson = challengeConstants.paramaters.actions.endLesson
    * def actionLoadQuestion = challengeConstants.paramaters.actions.loadQuestion

    * def answer = ranString(10)
    * def score = ranInteger(1)

@getChallengesList @takeChallenges @positive @regression 
Scenario: Validate list of all challenges
    #* def getPendingHomeworkURLTest = replaceString(getPendingHomeworkURL,"<<username>>",authUsername)
    * def getPendingHomeworkURLTest = replaceString(getPendingHomeworkURL,"<<username>>",authUserId)
    * print "==========================>>>>>>>>>>" + getPendingHomeworkURLTest
    * call read('../../service-controllers/pretests/challengesPretest.feature@getPendingHomework')
    * match pendingHomeworkResponse.object.profile.adultProfile.subjects == "#present"
    * match pendingHomeworkResponse.object.profile.adultProfile.username == authUsername
    * match pendingHomeworkResponse.object.profile.adultProfile.userid == authUserId

@getSubjectsList @takeChallenges @positive @regression 
Scenario: Write all subjects which are available to json file  
    * call read('../../service-controllers/tests/student_controller.feature@getDueHomeworkList')
    * print getHomeworkBySubjectResponse.object.profile.adultProfile.subjects[0]
    * def subjectList = getHomeworkBySubjectResponse.object.profile.adultProfile.subjects
    * print subjectList
    * def subjectListResponse = getHomeworkBySubjectResponse
    * def subjectList1 = convertJsonArray(subjectList)
    * def DemoClass = Java.type('com.smartkids.base.SmartKidsTest')
    * def x = DemoClass.writeToFile("/src/test/java/com/smartkids/service-controllers/requestPayload/request_payload_folder_placeholder/subjectList.json",subjectList1);
    

@getHomeworkListBySubject @takeChallenges @positive @regression 
Scenario Outline: Get Challenge by Subject: <name>
    * def jsUtils = read('classpath:jsUtils.js')
    * call read('../../service-controllers/tests/challengesController.feature@getSubjectsList')
    * def getChallengeBySubjectTest = replaceString(replaceString(getChallengeWithSubjectURL,"<<username>>",authUserId),"<<subject>>",name)
    * print 'Challenge With SUbject URL ->' + getChallengeBySubjectTest
    * match response.object.data[*].userid contains authUserId
    * match response.object.profile.adultProfile.subjects == "#present" 
    * match response.object.data == "#present"

    Examples:
    | subjectListExtracted |


@getChallengeWithChallengeName @takeChallenges @positive @regression 
Scenario: Get Challenge Details of Specific Challenge by Challenge Name
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonName = response.object.data[1].lessonId
    * def getLessonDetailsURL =  replaceString(getChallengWithChallengeNameURL,"<<challengename>>",lessonName)
    * call read('../../service-controllers/pretests/challengesPretest.feature@getChallengeWithLessonName')
    * match getLessonDetailsResponse.object.id == lessonName
    * match getLessonDetailsResponse.object.name == "#present"  
    * match getLessonDetailsResponse.object.questions == "#present" 


@getChallengeWithChallengeNameForUser @takeChallenges @positive @regression1 
Scenario: Get Challenge Details of User logged in by Challenge Name
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonName = response.object.data[1].lessonId
    * print "lessonName ==> " + lessonName
    * def getChallengeWithUser =  replaceString(replaceString(getChallengWithChallengeNameForUserURL,"<<challengename>>",lessonName),"<<username>>",authUserId) 
    * print "getChallengeWithUser =>" + getChallengeWithUser
    * call read('../../service-controllers/pretests/challengesPretest.feature@getChallengeWithLessonNameForUser')
    * match getChallengewithUserResponse.object.lessonId == lessonName
    * match getChallengewithUserResponse.object.maxScore == "#present"  
    * match getChallengewithUserResponse.object.attemptedQuestions == "#present" 
    * match getChallengewithUserResponse.object.correctAnswers == "#present" 

@getHomeWorkBySubjectName @takeChallenges @positive @regression 
Scenario: Get Homework by Subject Name for User Logged
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * match getHomeworkBySubjectResponse.object.data[0].id == "#present"
    * match getHomeworkBySubjectResponse.object.data[0].userid == authUserId

@pageLoad @takeChallenges @positive @regression1 
Scenario: Validate page is loaded successfully when user select challenge
    * call read('../../service-controllers/pretests/challengesPretest.feature@QuestionPageLoad')
    * match pageloadResponse.statusCode.code == 200
    * match pageloadResponse.statusCode.message == "OK"

@StartLesson @takeChallenges @positive @regression1
Scenario: Validate lesson started which user has selected
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonKey = response.object.data[1].lessonKey
    * call read('../../service-controllers/pretests/challengesPretest.feature@QuestionStartLesson')
    * match startLessonResponse.statusCode.code == 200
    * match startLessonResponse.statusCode.message == "OK"

@LoadQuestion @takeChallenges @positive @regression1 
Scenario: Validate question load properly of challenge which user is taking
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonKey = response.object.data[1].lessonKey
    * call read('../../service-controllers/pretests/challengesPretest.feature@LoadQuestionPretest')
    * match loadQuestionResponse.statusCode.code == 200
    * match loadQuestionResponse.statusCode.message == "OK"

@correctAnswer @takeChallenges @positive @regression1 
Scenario: Validate user answer correct answer for question
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonKey = response.object.data[1].lessonKey
    * call read('../../service-controllers/pretests/challengesPretest.feature@corectAnswer')
    * match correctAnswerResponse.statusCode.code == 200
    * match correctAnswerResponse.statusCode.message == "OK"

@loadQuestionWithAns @takeChallenges @positive @regression1 
Scenario: Validate question load properly after answering previous question
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonKey = response.object.data[1].lessonKey
    * call read('../../service-controllers/pretests/challengesPretest.feature@loadQuestionWithAnswer')
    * match loadQuestionWithAnsResponse.statusCode.code == 200
    * match loadQuestionWithAnsResponse.statusCode.message == "OK"

@inCorrectAnswer @takeChallenges @positive @regression1 
Scenario: Validate user answer incorrect answer for question
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonKey = response.object.data[1].lessonKey
    * call read('../../service-controllers/pretests/challengesPretest.feature@IncorectAnswer')
    * match inCorrectAnswerResponse.statusCode.code == 200
    * match inCorrectAnswerResponse.statusCode.message == "OK"

@scoreLesson @takeChallenges @positive @regression1 
Scenario: Validate score of lesson which user complete
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonKey = response.object.data[1].lessonMetadata.lessonKey
    * print "lessonKey========>>>>>>" + lessonKey
    * call read('../../service-controllers/pretests/challengesPretest.feature@userScore')
    * match scoreLessonResponse.statusCode.code == 200
    * match scoreLessonResponse.statusCode.message == "OK"

@endLesson @takeChallenges @positive @regression1 
Scenario: Validate user is able to complete lesson
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonKey = response.object.data[1].lessonKey
    * call read('../../service-controllers/pretests/challengesPretest.feature@endLessonAfterCompletion')
    * match endLessonResponse.statusCode.code == 200
    * match endLessonResponse.statusCode.message == "OK"

@integration @takeChallenges1 @positive @regression1
Scenario: Integration testing
    * def attemptId = uuidv4();
    * def sessionId = uuidv4();

    #Load Page
    * call read('../../service-controllers/pretests/challengesPretest.feature@QuestionPageLoad')

    #'start lesson'
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonKey = response.object.data[1].lessonKey
    * def noOfQuestions = response.object.data[1].totalQuestions

    * call read('../../service-controllers/tests/challengesController.feature@getChallengeWithChallengeName')
    * def correctAnswer = get getLessonDetailsResponse.object.questions[*].options[0]
    * def correctAnswer1 = convertJsonArrayOfChallengeAns(correctAnswer)
    * def DemoClass = Java.type('com.smartkids.base.SmartKidsTest')
    * def x = DemoClass.writeToFile("/src/test/java/com/smartkids/service-controllers/requestPayload/request_payload_folder_placeholder/questionAnswer.json",correctAnswer1);
    * call read('../../service-controllers/pretests/challengesPretest.feature@QuestionStartLesson')

    # Load Questions and Answers questions (incorrect and correct answers)
    * call read('../../service-controllers/tests/challengesController.feature@loadQuestionsAndAnswer')

    # 'score lesson'
    * def scorequestionNumber = noOfQuestions
    * def scorequestionProgress = noOfQuestions
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonKey = response.object.data[1].lessonKey
    * call read('../../service-controllers/pretests/challengesPretest.feature@userScore')

    # 'end lesson'
    * def endlessonquestionProgress = noOfQuestions
    * def endlessonquestionNumber = noOfQuestions
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject')
    * def lessonKey = response.object.data[1].lessonKey
    * call read('../../service-controllers/pretests/challengesPretest.feature@endLessonAfterCompletion')


@loadQuestionsAndAnswer
Scenario Outline: Get Challenge by Subject: <questionNumber> , <answer>
    * def jsUtils = read('classpath:jsUtils.js')

    # 'load question';
    * def eventId = uuidv4();
    * def loadquestionNumber = questionNumber
    * def loadquestionProgress = questionNumber 
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject');
    * def lessonKey = response.object.data[1].lessonKey;
    * call read('../../service-controllers/pretests/challengesPretest.feature@LoadQuestionPretest');

    # 'correct/Incorrect answer based on condition below'
    * def eventId = uuidv4();    
    * def answer = answer
    * def startLessonProgress = questionNumber
    * def startLessonQuestion = questionNumber
    * call read('../../service-controllers/tests/student_controller.feature@getHomeworkBySubject');
    * def lessonKey = response.object.data[1].lessonKey;
    #* call read('../../service-controllers/pretests/challengesPretest.feature@corectAnswer');

    * def res = questionNumber == 0 ? karate.call('../../service-controllers/pretests/challengesPretest.feature@IncorectAnswer') : karate.call('../../service-controllers/pretests/challengesPretest.feature@corectAnswer')

    Examples:
    | questionAnswerExtracted |
