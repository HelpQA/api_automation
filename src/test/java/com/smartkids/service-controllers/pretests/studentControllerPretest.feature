Feature: Student Controller Pretest

Background:
@getHomeworkBySubjectSuccess
Scenario: Get Homework By Subject
    Given url getHomeworkBySubjectUrlTest
    And header Authorization = authenticateToken
    When method get 
    Then status 200
    And def getHomeworkBySubjectResponse = response

@getHomeworkHistorySuccess
Scenario: Get Homework History
    Given url getHomeworkHistoryUrlTest
    And header Authorization = authenticateToken
    When method get 
    Then status 200
    And def getHomeworkBySubjectResponse = response



@getHomeworkHistoryByStudentNameAndSubjectSuccess
Scenario: Get Homework History By Student And Subject
    Given url getHomeworkHistoryByStudentNameAndUrlTest
    And header Authorization = authenticateToken
    When method get 
    Then status 200
    And def getHomeworkBySubjectResponse = response


@getDueHomeworkSuccess
Scenario: Get Due Homework
    Given url getDueHomeworkUrlTest
    And header Authorization = authenticateToken
    When method get 
    Then status 200
    And def getHomeworkBySubjectResponse = response

@getDueHomeworkListSuccess
Scenario: Get Due Homework List
    Given url getDueHomeworkListUrlTest
    And header Authorization = authenticateToken
    When method get 
    Then status 200
    And def getHomeworkBySubjectResponse = response

@getTopicsByGradeAndSubjectSuccess
Scenario: Get Topics By Grade And Subject
    Given url getTopicsByGradeAndSubjectUrlTest
    * print getTopicsByGradeAndSubjectUrlTest
    And header Authorization = authenticateToken
    When method get 
    Then status 200
    And def getHomeworkBySubjectResponse = response
    And def topicKey = getHomeworkBySubjectResponse.object.data.topic.topics[0].key
    And def topicID = getHomeworkBySubjectResponse.object.data.topic.topics[0].id

@getTopicByKeySuccess
Scenario: Get Topic by key
    Given url getTopicByKeyUrlTest
    And header Authorization = authenticateToken
    When method get 
    Then status 200
    And def getHomeworkBySubjectResponse = response

