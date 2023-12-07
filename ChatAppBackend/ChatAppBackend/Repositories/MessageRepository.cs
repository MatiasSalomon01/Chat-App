using ChatAppBackend.Data;
using ChatAppBackend.Entities;
using ChatAppBackend.Interfaces;
using Microsoft.EntityFrameworkCore;

namespace ChatAppBackend.Repositories;

public class MessageRepository : IMessageRepository
{
    private readonly ApplicationDbContext _context;

    public MessageRepository(ApplicationDbContext context)
    {
        _context = context;
    }

    public async Task<List<UsersMessages>> GetUserMessages(int chatId)
    {
        return await _context.UsersMessages
            .Include(x => x.Message)
            .Where(x => x.ChatId == chatId)
            .OrderBy(x => x.Message.SentAt)
            .ToListAsync();
    }

    public async Task Create(UsersMessages content)
    {
        await _context.UsersMessages.AddAsync(content);
        await _context.SaveChangesAsync();
    }

    public async Task Delete(UsersMessages content)
    {
        throw new NotImplementedException();
    }

    public async Task Update(UsersMessages content)
    {
        throw new NotImplementedException();
    }

    public async Task<int> CreateUser(User user)
    {
        await _context.Users.AddAsync(user);
        await _context.SaveChangesAsync();
        return user.Id;
    }

    public async Task SendMessageTo(int toUserId, string text, int fromUserId)
    {
        var usersMessage = new UsersMessages();
        usersMessage.FromUserId = fromUserId;
        usersMessage.ToUserId = toUserId;
        usersMessage.ChatId = toUserId+fromUserId;
        usersMessage.Message = new Message { Text = text, SentAt = DateTime.Now };

        await _context.UsersMessages.AddAsync(usersMessage);
        await _context.SaveChangesAsync();
    }

    public async Task<object> GetAllChats(int fromUserId)
    {
        return await _context.UserChats.Where(x => x.UserId == fromUserId).Select(x => new { x.UserContactId, x.UserContact.Name }).ToListAsync();    
    }

    public async Task AddChatToUser(int fromUserId, int toUserId)
    {
        var userChat = new UserChat { UserId = fromUserId, UserContactId = toUserId };

        await _context.UserChats.AddAsync(userChat);
        await _context.SaveChangesAsync();
    }
}
