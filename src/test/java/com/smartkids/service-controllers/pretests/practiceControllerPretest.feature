Feature: Student Controller Pretest

Background:
@getPracticequestionSubjectWise
Scenario: Get Homework By Subject
    Given url getHomeworkBySubjectUrlTest
    And header Authorization = authenticateToken
    When method get 
    Then status 200
    And def getPracticeSubjectWiseResponse = response