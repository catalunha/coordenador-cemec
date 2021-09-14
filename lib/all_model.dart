class UserModel {
  static final String collection = 'users';
  late final String? displayName;
  late final String email;
  late final String? phoneNumber;
  late final String? photoURL;
  late final bool isActive;
  late final List<String> appList; //teacher,coordinator,administrator,student
}

class CourseModel {
  static final String collection = 'courses';

  late final String coordinatorUserId; // coordinator User.id
  late final String title;
  late final String description;
  late final String syllabus;
  late final bool isArchivedByAdm; //for adm use
  late final bool isArchivedByCoord; //for coord use
  late final bool isDeleted; //for coord use
  late final bool isActive; //for adm use

  late final String? iconUrl;
  late final List<String>? moduleOrder;
  late final List<String>? collegiate; // lista de UserId
}

class ModuleModel {
  static final String collection = 'modules';

  late final String courseId;
  late final String title;
  late final String description;
  late final String syllabus;
  late final bool isArchivedByProf; //for prof use
  late final bool isDeleted; //for prof use
  late final String? teacherUserId; // User.id
  late final List<String>? resourceOrder;
  late final List<String>? situationOrder;
}

class ResourceModel {
  static final String collection = 'resources';
  late final String moduleId;
  late final String title;
  late final String description;
  late final String? url;
}

class Situation {
  static final String collection = 'situations';
  late final String moduleId;
  late final String title;
  late final String description;
  late final String proposalUrl;
  late final String solutionUrl;
  late final String type; //choice,report
  late final List<String>? options; // [Sim,Não] or [A,B,C,D,E]
  late final String? choice; // [Sim] or [A]
  late final bool isDeleted;
}

class Student {
  static final String collection = 'students';

  late final String userId;
  late final String courseId;
  late final bool isArchived; //for student use
  // late final int porcentage; // como ?
  late final Map<String, ResourceIdList>?
      resourceMap; //{moduleId:resourceLisId}
  late final Map<String, SituationIdList>?
      situationMap; //{moduleId:situationIdList}

}

class ResourceIdList {
  late List<String> resourceId;
}

class SituationIdList {
  late List<String> situationId;
}
