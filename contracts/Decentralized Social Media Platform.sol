// SPDX-License-Identifier:MIT
pragma solidity ^0.8.19;

contract Project {
    // State variables
    address public owner;
    uint256 public postCount;
    uint256 public userCount;
    
    struct User {
        address userAddress;
        string username;
        string bio;
        uint256 postCount;
        uint256 reputation;
        bool isActive;
        uint256 joinDate;
    }
    
    struct Post {
        uint256 id;
        address author;
        string content;
        string imageHash; // IPFS hash for images
        uint256 timestamp;
        uint256 likes;
        uint256 tips;
        bool isActive;
    }
    
    struct Comment {
        uint256 id;
        uint256 postId;
        address author;
        string content;
        uint256 timestamp;
    }
    
    // Mappings
    mapping(address => User) public users;
    mapping(uint256 => Post) public posts;
    mapping(uint256 => Comment[]) public postComments;
    mapping(address => uint256[]) public userPosts;
    mapping(uint256 => mapping(address => bool)) public hasLiked;
    mapping(address => mapping(address => bool)) public isFollowing;
    mapping(address => address[]) public followers;
    mapping(address => address[]) public following;
    
    // Events
    event UserRegistered(address indexed user, string username);
    event PostCreated(uint256 indexed postId, address indexed author, string content);
    event PostLiked(uint256 indexed postId, address indexed liker);
    event PostTipped(uint256 indexed postId, address indexed tipper, uint256 amount);
    event UserFollowed(address indexed follower, address indexed followed);
    event CommentAdded(uint256 indexed postId, address indexed commenter, string content);
    
    // Modifiers
    modifier onlyRegistered() {
        require(users[msg.sender].isActive, "User not registered");
        _;
    }
    
    modifier postExists(uint256 _postId) {
        require(_postId <= postCount && _postId > 0, "Post does not exist");
        require(posts[_postId].isActive, "Post is not active");
        _;
    }
    
    modifier notSelf(address _user) {
        require(_user != msg.sender, "Cannot perform action on yourself");
        _;
    }
    
    // Constructor
    constructor() {
        owner = msg.sender;
        postCount = 0;
        userCount = 0;
    }
    
    // Core Function 1: Register User
    function registerUser(string memory _username, string memory _bio) external {
        require(!users[msg.sender].isActive, "User already registered");
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(bytes(_username).length <= 50, "Username too long");
        require(bytes(_bio).length <= 200, "Bio too long");
        
        users[msg.sender] = User({
            userAddress: msg.sender,
            username: _username,
            bio: _bio,
            postCount: 0,
            reputation: 0,
            isActive: true,
            joinDate: block.timestamp
        });
        
        userCount++;
        emit UserRegistered(msg.sender, _username);
    }
    
    // Core Function 2: Create Post
    function createPost(string memory _content, string memory _imageHash) external onlyRegistered {
        require(bytes(_content).length > 0, "Content cannot be empty");
        require(bytes(_content).length <= 280, "Content too long");
        
        postCount++;
        
        posts[postCount] = Post({
            id: postCount,
            author: msg.sender,
            content: _content,
            imageHash: _imageHash,
            timestamp: block.timestamp,
            likes: 0,
            tips: 0,
            isActive: true
        });
        
        userPosts[msg.sender].push(postCount);
        users[msg.sender].postCount++;
        
        emit PostCreated(postCount, msg.sender, _content);
    }
    
    // Core Function 3: Like Post
    function likePost(uint256 _postId) external onlyRegistered postExists(_postId) {
        require(!hasLiked[_postId][msg.sender], "Already liked this post");
        require(posts[_postId].author != msg.sender, "Cannot like your own post");
        
        posts[_postId].likes++;
        hasLiked[_postId][msg.sender] = true;
        
        // Increase author's reputation
        users[posts[_postId].author].reputation++;
        
        emit PostLiked(_postId, msg.sender);
    }
    
    // Additional Core Function: Follow User
    function followUser(address _user) external onlyRegistered notSelf(_user) {
        require(users[_user].isActive, "User does not exist");
        require(!isFollowing[msg.sender][_user], "Already following this user");
        
        isFollowing[msg.sender][_user] = true;
        followers[_user].push(msg.sender);
        following[msg.sender].push(_user);
        
        emit UserFollowed(msg.sender, _user);
    }
    
    // Tip function - users can tip posts with ETH
    function tipPost(uint256 _postId) external payable onlyRegistered postExists(_postId) {
        require(msg.value > 0, "Tip amount must be greater than 0");
        require(posts[_postId].author != msg.sender, "Cannot tip your own post");
        
        address payable author = payable(posts[_postId].author);
        (bool success, ) = author.call{value: msg.value}("");
        require(success, "Transfer failed");
        
        posts[_postId].tips += msg.value;
        users[posts[_postId].author].reputation += 5; // Bonus reputation for tips
        
        emit PostTipped(_postId, msg.sender, msg.value);
    }
    
    // Add comment to post
    function addComment(uint256 _postId, string memory _content) external onlyRegistered postExists(_postId) {
        require(bytes(_content).length > 0, "Comment cannot be empty");
        require(bytes(_content).length <= 150, "Comment too long");
        
        Comment memory newComment = Comment({
            id: postComments[_postId].length + 1,
            postId: _postId,
            author: msg.sender,
            content: _content,
            timestamp: block.timestamp
        });
        
        postComments[_postId].push(newComment);
        
        emit CommentAdded(_postId, msg.sender, _content);
    }
    
    // View Functions
    function getPost(uint256 _postId) external view postExists(_postId) returns (
        uint256 id,
        address author,
        string memory content,
        string memory imageHash,
        uint256 timestamp
    ) {
        Post memory post = posts[_postId];
        return (
            post.id,
            post.author,
            post.content,
            post.imageHash,
            post.timestamp
        );
    }
    
    function getPostStats(uint256 _postId) external view postExists(_postId) returns (
        uint256 likes,
        uint256 tips,
        string memory authorUsername
    ) {
        Post memory post = posts[_postId];
        return (
            post.likes,
            post.tips,
            users[post.author].username
        );
    }
    
    function getUser(address _user) external view returns (
        address userAddress,
        string memory username,
        string memory bio,
        uint256 userPostCount,
        uint256 reputation,
        uint256 joinDate
    ) {
        require(users[_user].isActive, "User does not exist");
        User memory user = users[_user];
        return (
            user.userAddress,
            user.username,
            user.bio,
            user.postCount,
            user.reputation,
            user.joinDate
        );
    }
    
    function getUserStats(address _user) external view returns (
        uint256 followersCount,
        uint256 followingCount
    ) {
        require(users[_user].isActive, "User does not exist");
        return (
            followers[_user].length,
            following[_user].length
        );
    }
    
    function getUserPosts(address _user) external view returns (uint256[] memory) {
        require(users[_user].isActive, "User does not exist");
        return userPosts[_user];
    }
    
    function getPostComments(uint256 _postId) external view postExists(_postId) returns (Comment[] memory) {
        return postComments[_postId];
    }
    
    function getFollowers(address _user) external view returns (address[] memory) {
        require(users[_user].isActive, "User does not exist");
        return followers[_user];
    }
    
    function getFollowing(address _user) external view returns (address[] memory) {
        require(users[_user].isActive, "User does not exist");
        return following[_user];
    }
    
    function isUserFollowing(address _follower, address _followed) external view returns (bool) {
        return isFollowing[_follower][_followed];
    }
    
    function hasUserLikedPost(address _user, uint256 _postId) external view returns (bool) {
        return hasLiked[_postId][_user];
    }
    
    // Update user profile
    function updateProfile(string memory _username, string memory _bio) external onlyRegistered {
        require(bytes(_username).length > 0, "Username cannot be empty");
        require(bytes(_username).length <= 50, "Username too long");
        require(bytes(_bio).length <= 200, "Bio too long");
        
        users[msg.sender].username = _username;
        users[msg.sender].bio = _bio;
    }
    
    // Unfollow user function (optimized)
    function unfollowUser(address _user) external onlyRegistered notSelf(_user) {
        require(users[_user].isActive, "User does not exist");
        require(isFollowing[msg.sender][_user], "Not following this user");
        
        isFollowing[msg.sender][_user] = false;
        
        // Remove from followers array
        _removeFromArray(followers[_user], msg.sender);
        
        // Remove from following array
        _removeFromArray(following[msg.sender], _user);
    }
    
    // Internal helper function to remove address from array
    function _removeFromArray(address[] storage array, address element) internal {
        for (uint256 i = 0; i < array.length; i++) {
            if (array[i] == element) {
                array[i] = array[array.length - 1];
                array.pop();
                break;
            }
        }
    }
    
    // Unlike post function
    function unlikePost(uint256 _postId) external onlyRegistered postExists(_postId) {
        require(hasLiked[_postId][msg.sender], "Haven't liked this post");
        require(posts[_postId].author != msg.sender, "Cannot unlike your own post");
        
        posts[_postId].likes--;
        hasLiked[_postId][msg.sender] = false;
        
        // Decrease author's reputation
        if (users[posts[_postId].author].reputation > 0) {
            users[posts[_postId].author].reputation--;
        }
    }
    
    // Get latest posts (optimized)
    function getLatestPosts(uint256 _count) external view returns (uint256[] memory) {
        require(_count > 0, "Count must be greater than 0");
        
        uint256 actualCount = _count > postCount ? postCount : _count;
        uint256[] memory latestPosts = new uint256[](actualCount);
        
        uint256 index = 0;
        uint256 currentId = postCount;
        
        while (currentId > 0 && index < actualCount) {
            if (posts[currentId].isActive) {
                latestPosts[index] = currentId;
                index++;
            }
            currentId--;
        }
        
        return latestPosts;
    }
}
