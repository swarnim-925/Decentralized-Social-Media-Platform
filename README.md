# Decentralized Social Media Platform

## Project Description

The Decentralized Social Media Platform is a blockchain-based social networking smart contract built on Ethereum. This project enables users to create profiles, post content, interact with others through likes and comments, follow users, and tip creators with cryptocurrency. Unlike traditional social media platforms, this decentralized version ensures data ownership, censorship resistance, and transparent content moderation through blockchain technology.

The platform eliminates the need for centralized authorities by storing all user data, posts, and interactions directly on the blockchain, giving users complete control over their content and social connections.

## Project Vision

Our vision is to create a truly decentralized social media ecosystem where:

- **Users own their data**: All content and profile information is stored on the blockchain, ensuring users maintain complete ownership
- **Censorship resistance**: No single entity can remove or restrict content, promoting free speech and expression
- **Creator monetization**: Direct peer-to-peer tipping system allows creators to earn from their content without intermediaries
- **Transparency**: All interactions, likes, and follows are publicly verifiable on the blockchain
- **Community governance**: Future implementations will include decentralized governance for platform decisions
- **Privacy by design**: Users control their personal information and can interact pseudonymously

## Key Features

### Core Functionality
- **User Registration & Profiles**: Users can create accounts with custom usernames and bios
- **Content Creation**: Post text content with optional IPFS image attachments (up to 280 characters)
- **Social Interactions**: Like posts, follow users, and add comments to engage with content
- **Reputation System**: Users earn reputation points through likes and tips received
- **Direct Tipping**: Send cryptocurrency tips directly to content creators
- **Follow System**: Build social networks by following and being followed by other users

### Advanced Features
- **Content Validation**: Built-in content length limits and validation
- **Anti-spam Protection**: Prevents users from liking their own posts or following themselves
- **Profile Management**: Users can update their profiles and view comprehensive statistics
- **Comment System**: Threaded comments on posts for better engagement
- **Activity Tracking**: Complete history of user posts, likes, and social connections
- **Contract Statistics**: Real-time platform analytics including user count and total posts

### Technical Features
- **Gas Optimization**: Efficient data structures and function implementations
- **Security**: Comprehensive access control and input validation
- **Event Logging**: All major actions emit events for easy frontend integration
- **Modular Design**: Clean separation of concerns with reusable modifiers
- **View Functions**: Extensive read-only functions for data retrieval

## Future Scope

### Short-term Enhancements (Next 6 months)
- **Content Moderation**: Community-driven content flagging and reporting system
- **Rich Media Support**: Enhanced support for videos, audio, and rich text formatting
- **Search Functionality**: Advanced search and filtering options for posts and users
- **Notification System**: Real-time notifications for likes, comments, and follows
- **Mobile Integration**: React Native or Flutter mobile app development

### Medium-term Roadmap (6-12 months)
- **Governance Token**: Platform governance token for decentralized decision making
- **NFT Integration**: Mint posts as NFTs and create collectible content
- **Multi-chain Support**: Deploy on multiple blockchains for broader accessibility
- **Content Monetization**: Subscription-based content and premium features
- **Analytics Dashboard**: Comprehensive analytics for users and content creators

### Long-term Vision (1-2 years)
- **Decentralized Storage**: Full integration with IPFS and Arweave for content storage
- **Layer 2 Solutions**: Implementation on Polygon, Arbitrum, or other L2 networks
- **Cross-platform Interoperability**: Integration with other Web3 social platforms
- **AI Content Moderation**: Smart contract-based AI moderation systems
- **Decentralized Identity**: Integration with decentralized identity protocols
- **Marketplace Integration**: Built-in marketplace for digital goods and services

### Advanced Features
- **Live Streaming**: Decentralized live streaming capabilities
- **Group Chats**: Encrypted group messaging and community features
- **Content Curation**: Algorithm-free, user-controlled content curation
- **Decentralized Advertising**: Privacy-preserving, user-controlled advertising system
- **Social Recovery**: Decentralized account recovery mechanisms

## Getting Started

### Prerequisites
- Node.js and npm installed
- Hardhat development environment
- MetaMask or compatible Web3 wallet
- Basic understanding of Solidity and blockchain concepts

### Installation
1. Clone the repository
2. Install dependencies: `npm install`
3. Compile contracts: `npx hardhat compile`
4. Deploy to testnet: `npx hardhat run scripts/deploy.js --network testnet`
5. Interact with the contract using frontend or Hardhat console

### Usage
1. Register as a user with `registerUser(username, bio)`
2. Create posts using `createPost(content, imageHash)`
3. Interact with others through `likePost()` and `followUser()`
4. Tip creators using `tipPost()` with ETH
5. Add comments with `addComment(postId, content)`

## Contributing

We welcome contributions from the community! Please check our contributing guidelines and submit pull requests for any improvements or new features.

## License

This project is licensed under the MIT License - see the LICENSE file for details.

Contract Address: 0xDE724aC85ab6eb3e3F3adFe7be77C4154068837c

![image](https://github.com/user-attachments/assets/23654bef-9bbd-40ec-b775-cabc3f828874)

Updated

