function fn() {
    var env = karate.env; // get system property 'karate.env'
    karate.log('Karate.env system property was:',env)
    if(!env){
        env = 'dev';
    }
 
    if(!karate.properties['configPath']){
        karate.log(java.lang.String.format("Terminating execution due to %s config file path",
        karate.properties['configPath']))
        java.lang.System.exit(0);
    }

    var envProps = karate.read('file:' + karate.properties['configPath']);

    var path = karate.read('file:envYaml/common/common.yaml');
  try{

   var config = {
         username : env,
   };
        
        config.envHost = envProps.host
        //username & password for authtoken
         // username & password for global super user
         config.authUsername = envProps.user.userName;
         config.authPassword = envProps.user.password;
         config.authTokenUrl = envProps.host + path.endPoints.authenticationToken.authToken;
         // username & password for Citizen user
        var authTokenResponse = karate.callSingle('../../common-services/pretests/authenticationToken.feature', config);
        config.getHomeworkBySubjectUrl = envProps.host + path.endPoints.student_controller.getHomeworkBySubject;
        config.authenticateToken = authTokenResponse.authToken;
        config.subjectsFromLogin = authTokenResponse.subjectsFromLogin
        config.authUserId = authTokenResponse.authUserId
        config.getHomeworkHistoryUrl = envProps.host + path.endPoints.student_controller.getHomeworkHistory;
        config.getHomeworkHistoryByStudentNameAndSubjectUrl = envProps.host + path.endPoints.student_controller.getHomeworkHistoryByStudentNameAndSubject;
        config.getDueHomeworkSuccessUrl = envProps.host + path.endPoints.student_controller.getDueHomeworkUrl;
        config.getDueHomeworkListUrl = envProps.host + path.endPoints.student_controller.getDueHomeworkListUrl;
        config.getTopicsByGradeAndSubjectUrl = envProps.host + path.endPoints.student_controller.getTopicsByGradeAndSubject;
        config.getTopicByKeyUrl = envProps.host + path.endPoints.student_controller.getTopicByKeyUrl;
        config.getChallengeWithSubjectURL = envProps.host + path.endPoints.challenge_controller.getChallengeWithSubject;
        config.getPendingHomeworkURL = envProps.host + path.endPoints.challenge_controller.getPendingHomework;
        config.getChallengWithChallengeNameURL  = envProps.host + path.endPoints.challenge_controller.getChallengWithChallengeName;
        config.getChallengWithChallengeNameForUserURL  = envProps.host + path.endPoints.challenge_controller.getChallengeWithChallengeNameForUser;
        config.getPracticeSujectWiseURL  = envProps.host + path.endPoints.practice_controller.getPracticeSubjectWise;
        config.getreportURL = envProps.host + path.endPoints.challenge_controller.getReport;
        config.postGuestSignUpURL = envProps.host + path.endPoints.GuestUserSignUp_Controller.postGuestSignup;
        config.postUploadProfilePicURL = envProps.host + path.endPoints.GuestUserSignUp_Controller.postUploadProfilePic;
        config.postUpdateGradeURL = envProps.host + path.endPoints.GuestUserSignUp_Controller.postUpdateGrade
    return config;
    }catch(e){
        karate.log(java.lang.String.format("Terminating execution due to %s in configuration", e))
        java.lang.System.exit(0);
    }
}