using ChatAppBackend.Entities;

namespace ChatAppBackend.Interfaces;

public interface IMessageRepository
{
    Task<List<UsersMessages>> GetUserMessages(int fromUserId, int toUserId);
    Task Create(UsersMessages content);
    Task Update(UsersMessages content);
    Task Delete(UsersMessages content);
}
