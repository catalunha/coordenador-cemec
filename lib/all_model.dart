class UserModel {
  static final String collection = 'users';
  late final String displayName;
  late final String phoneNumber;
  late final String photoURL;
  late final String email;
  late final bool isActive;
  late final List<String>? appList; //teacher,coordinator,administrator,student
}

class CourseModel {
  static final String collection = 'courses';

  late final String coordinatorUserId; // User.id
  late final String title;
  late final String description;
  late final String syllabus;
  late final String? iconUrl;
  late final bool isActive; //for adm use
  late final bool isArchivedByAdm; //for adm use
  late final bool isArchivedByCoord; //for coord use
  late final bool isDeleted; //for coord use
  late final List<String>? teacherList;
  late final List<String>? moduleOrder;
}

class ModuleModel {
  static final String collection = 'modules';

  late final String courseId;
  late final String title;
  late final String description;
  late final String syllabus;
  late final bool isArchivedByProf; //for prof use
  late final bool isDeleted; //for coord use
  late final String? teacherUserId; // User.id
  late final List<String>? resourceOrder;
}

class ResourceModel {
  static final String collection = 'resources';
  late final String moduleId;
  late final String title;
  late final String description;
  late final String url;
  late final bool isDeleted; //for prof use
}

class Student {
  static final String collection = 'students';

  late final String userId;
  late final String courseId;
  late final bool isArchived; //for student use
  // late final int porcentage; // como ?
  late final Map<String, ResourceIdList>? moduleMap; //{moduleId:resourceLisId}

}

class ResourceIdList {
  late List<String> resourceId;
}

class MensagemModel {
  late final String coordinatorUserId;
  late final String title;
  late final String description;
  late final DateTime created;
  late final DateTime read;
  late final bool isRead;
}
