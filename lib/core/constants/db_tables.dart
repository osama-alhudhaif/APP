// بيانات الجداول في قاعدة البيانات

// الاتصال بقاعدة البيانات
// قاعدة البيانات المستخدمة هي MySQL
class DB_CONNECTION {
  static const String host = 'localhost';
  static const String port = 'port';
  static const String database = 'database';
  static const String username = 'username';
  static const String password = 'password';
}

// حسابات المستخدم
class USER_ACCOUNTS {
  static const String author = "author";
  // ignore: constant_identifier_names
  static const String admin_author = "admin_author";
  // ignore: constant_identifier_names
  static const String super_admin_author = "super_admin_author";
  static const String reader = "reader";
  // ignore: constant_identifier_names
  static const String admin_reader = "admin_reader";
  // ignore: constant_identifier_names
  static const String super_admin_reader = "super_admin_reader";
  // ignore: constant_identifier_names
  static const String educational_center = "educational_center";
  // ignore: constant_identifier_names
  static const String educational_center_teacher = "educational_center_teacher";
  // ignore: constant_identifier_names
  static const String educational_center_student = "educational_center_student";
  static const String owner = "owner";
}

// البيانات المطلوبة في الحسابات
// القاريء
class READER {
  static const String id = 'id';
  static const String username = 'username';
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String address = 'address';
  static const String dateOfBirth = 'date_of_birth';
  static const String gender = 'gender';
  static const String level = 'level';
  static const String country = 'country';
  static const String status = 'status';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
}

// الكاتب
class WRITER {
  static const String tableName = 'WRITER';
  static const String id = 'id';
  static const String username = 'username';
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String address = 'address';
  static const String dateOfBirth = 'date_of_birth';
  static const String gender = 'gender';
  static const String level = 'level';
  static const String country = 'country';
  static const String status = 'status';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String storyList = 'story_list';
  static const String rejectedStory = 'rejected_story';
  static const String approvedStory = 'approved_story';
  static const String suspendedStory = 'suspended_story';
}

// الأدمن القاريء
class ADMIN_READER {
  static const String tableName = 'admin_READER';
  static const String id = 'id';
  static const String username = 'username';
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String address = 'address';
  static const String dateOfBirth = 'date_of_birth';
  static const String gender = 'gender';
  static const String level = 'level';
  static const String country = 'country';
  static const String status = 'status';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String appointedBySuperAdminId = 'appointed_by_super_admin_id';
}

// الأدمن الكاتب
class ADMIN_WRITER {
  static const String tableName = 'admin_WRITER';
  static const String id = 'id';
  static const String username = 'username';
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String address = 'address';
  static const String dateOfBirth = 'date_of_birth';
  static const String gender = 'gender';
  static const String level = 'level';
  static const String country = 'country';
  static const String status = 'status';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String storyList = 'story_list';
  static const String rejectedStory = 'rejected_story';
  static const String approvedStory = 'approved_story';
  static const String suspendedStory = 'suspended_story';
  static const String appointedBySuperAdminId = 'appointed_by_super_admin_id';
}

// المشرف الأعلى القاريء
class SUPER_ADMIN_READER {
  static const String tableName = 'super_admin_READER';
  static const String id = 'id';
  static const String username = 'username';
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String address = 'address';
  static const String dateOfBirth = 'date_of_birth';
  static const String gender = 'gender';
  static const String level = 'level';
  static const String country = 'country';
  static const String status = 'status';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String adminFollowing = 'admin_following';
}

// المشرف الأعلى الكاتب
class SUPER_ADMIN_WRITER {
  static const String tableName = 'super_admin_WRITER';
  static const String id = 'id';
  static const String username = 'username';
  static const String name = 'name';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String address = 'address';
  static const String dateOfBirth = 'date_of_birth';
  static const String gender = 'gender';
  static const String level = 'level';
  static const String country = 'country';
  static const String status = 'status';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String storyList = 'story_list';
  static const String rejectedStory = 'rejected_story';
  static const String approvedStory = 'approved_story';
  static const String suspendedStory = 'suspended_story';
  static const String adminFollowing = 'admin_following';
}

// مركز تعليمي
class EDUCATIONAL_CENTER {
  static const String tableName = 'educational_center';
  static const String id = 'id';
  static const String name = 'name';
  static const String username = 'username';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String address = 'address';
  static const String code = 'code';
  static const String licenseNumber = 'license_number';
  static const String status = 'status';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  static const String approvedByAdminId = 'approved_by_admin_id';
}

// المعلم في المركز التعليمي
class EDUCATIONAL_CENTER_TEACHER {
  static const String tableName = 'educational_center_teacher';
  static const String id = 'id';
  static const String educationalCenterId = 'educational_center_id';
  static const String name = 'name';
  static const String username = 'username';
  static const String email = 'email';
  static const String isSpecial = 'is_special';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String status = 'status';
  static const String dateOfBirth = 'date_of_birth';
  static const String gender = 'gender';
  static const String ip = 'ip';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
}

// الطالب في المركز التعليمي
class EDUCATIONAL_CENTER_STUDENT {
  static const String tableName = 'educational_center_student';
  static const String id = 'id';
  static const String name = 'name';
  static const String username = 'username';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String status = 'status';
  static const String educationalCenterId = 'educational_center_id';
  static const String teacherId = 'teacher_id';
  static const String dateOfBirth = 'date_of_birth';
  static const String gender = 'gender';
  static const String ip = 'ip';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
}

// المالك
class OWNER {
  static const String tableName = 'owner';
  static const String id = 'id';
  static const String name = 'name';
  static const String username = 'username';
  static const String email = 'email';
  static const String password = 'password';
  static const String phone = 'phone';
  static const String status = 'status';
  static const String dateOfBirth = 'date_of_birth';
  static const String gender = 'gender';
  static const String ip = 'ip';
  static const String ips = 'ips';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
}

// القصص
class STORY {
  static const String tableName = 'STORY';
  static const String id = 'id';
  static const String title = 'title';
  static const String filePath = 'file_path';
  static const String authorId = 'author_id';
  static const String creationDate = 'creation_date';
  static const String lastUpdated = 'last_updated';
  static const String status = 'status';
  static const String approvedByAdminId = 'approved_by_admin_id';
  static const String genre = 'genre';
  static const String viewsCount = 'views_count';
  static const String likesCount = 'likes_count';
  static const String language = 'language';
  static const String comedy = 'comedy';
}

// التعليقات
class COMMENTS {
  static const String tableName = 'COMMENTS';
  static const String id = 'id';
  static const String storyId = 'story_id';
  static const String userId = 'user_id';
  static const String content = 'content';
  static const String createdAt = 'created_at';
  static const String status = 'status';
}

// الإعجابات
class LIKES {
  static const String tableName = 'LIKES';
  static const String id = 'id';
  static const String storyId = 'story_id';
  static const String userId = 'user_id';
  static const String createdAt = 'created_at';
}

// المتابعة
class FOLLOWS {
  static const String tableName = 'FOLLOWS';
  static const String id = 'id';
  static const String followerId = 'follower_id';
  static const String followingId = 'following_id';
  static const String createdAt = 'created_at';
}

// الإشعارات
class NOTIFICATIONS {
  static const String tableName = 'NOTIFICATIONS';
  static const String id = 'id';
  static const String userId = 'user_id';
  static const String type = 'type';
  static const String message = 'message';
  static const String relatedId = 'related_id';
  static const String isRead = 'is_read';
  static const String createdAt = 'created_at';
}
