class ApiEndPoints{
  static const signUp="Registration/signup";
  static const signIn="Registration/signin";
  static const initialprofile="Profile/createProfile";
  static const uploadImages = "FileUpload/upload-multiple";
  static const createPost = "Post/CreatePost";
  static const fetchPost="Post/FetchAllPosts";
  static const toggleLike="Like/toggle";
  static const createComment = 'comments';
  static const getMyProfile   = 'Profile/me'; 
  static const getAllUsers="FriendRequest/discover";
  static const friendRequestToMe="FriendRequest/pending";
  static String acceptFriendRequest(String requestId) => "FriendRequest/accept/$requestId";
  static String rejectFriendRequest(String requestId) => "FriendRequest/reject/$requestId";
  static const sendRequests="FriendRequest/send_friendRequest";
  static String getPostComments(String postId) => 'posts/$postId/comments';
}
