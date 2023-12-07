using ChatAppBackend.Entities;

namespace ChatAppBackend.Interfaces;

public interface IMessageRepository
{
    Task<List<UsersMessages>> GetUserMessages(int chatId);
    Task Create(UsersMessages content);
    Task Update(UsersMessages content);
    Task Delete(UsersMessages content);
    Task<int> CreateUser(User user);
    Task SendMessageTo(int toUserId, string text, int fromUserId);
    Task<object> GetAllChats(int chatId);
    Task AddChatToUser(int fromUserId, int toUserId);
}
