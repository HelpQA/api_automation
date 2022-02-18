Feature: Take Challenge Pretest

Background:
* def authTokenRequest = read('../../service-controllers/requestPayload/loginRequest_payload.json')
* def pageloadRequest = read('../../service-controllers/requestPayload/challenge-questions/loadPage.json')
* def startLessonRequest = read('../../service-controllers/requestPayload/challenge-questions/startLesson.json')
* def loadQuestionRequest = read('../../service-controllers/requestPayload/challenge-questions/loadQuestion.json')
* def incorrectAnswerRequest = read('../../service-controllers/requestPayload/challenge-questions/incorrectAnswer.json')
* def correctAnswerRequest = read('../../service-controllers/requestPayload/challenge-questions/correctAnswer.json')
* def loadQuestionWithAnsRequest = read('../../service-controllers/requestPayload/challenge-questions/loadQuestionWithAns.json')
* def scoreLessonRequest = read('../../service-controllers/requestPayload/challenge-questions/scoreLesson.json')
* def endLessonRequest = read('../../service-controllers/requestPayload/challenge-questions/endLesson.json')

@getPendingHomework
    Scenario: Get Homework By Subject
        Given url getPendingHomeworkURLTest
        And header Authorization = authenticateToken
        When method get
        Then status 200
        And def pendingHomeworkResponse = response


@getChallengeWithLessonName
    Scenario: Get Challenge details with Challenge Name
        Given url getLessonDetailsURL
        And header Authorization = authenticateToken
        When method get
        Then status 200
        And def getLessonDetailsResponse = response

@getChallengeWithLessonNameForUser
    Scenario: Get Challenge details with user logged In  
        Given url getChallengeWithUser
        And header Authorization = authenticateToken
        When method get
        Then status 200
        And def getChallengewithUserResponse = response

@QuestionPageLoad
    Scenario: Load page which have questions
        Given url getreportURL
        And header Authorization = authenticateToken
        And request pageloadRequest
        * print pageloadRequest
        When method post
        Then status 200
        And def pageloadResponse = response

@QuestionStartLesson
    Scenario: Start Lesson which user has selected
        Given url getreportURL
        And header Authorization = authenticateToken
        And request startLessonRequest
        * print startLessonRequest
        When method post
        Then status 200
        And def startLessonResponse = response

@LoadQuestionPretest
        Scenario: Load question
        Given url getreportURL
        And header Authorization = authenticateToken
        And request loadQuestionRequest
        * print loadQuestionRequest
        When method post
        Then status 200
        And def loadQuestionResponse = response

@corectAnswer
        Scenario: Correct Answer
        Given url getreportURL
        And header Authorization = authenticateToken
        And request correctAnswerRequest
        * print correctAnswerRequest
        When method post
        Then status 200
        And def correctAnswerResponse = response

@IncorectAnswer
        Scenario: InCorrect Answer
        Given url getreportURL
        And header Authorization = authenticateToken
        And request incorrectAnswerRequest
        * print incorrectAnswerRequest
        When method post
        Then status 200
        And def inCorrectAnswerResponse = response
    
@loadQuestionWithAnswer
 Scenario: Load Question after answering previous question
        Given url getreportURL
        And header Authorization = authenticateToken
        And request loadQuestionWithAnsRequest
        * print loadQuestionWithAnsRequest
        When method post
        Then status 200
        And def loadQuestionWithAnsResponse = response

@userScore
 Scenario: Load Question after answering previous question
        Given url getreportURL
        And header Authorization = authenticateToken
        And request scoreLessonRequest
        * print scoreLessonRequest
        When method post
        Then status 200
        And def scoreLessonResponse = response

@endLessonAfterCompletion
 Scenario: Load Question after answering previous question
        Given url getreportURL
        And header Authorization = authenticateToken
        And request endLessonRequest
        * print endLessonRequest
        When method post
        Then status 200
        And def endLessonResponse = response

