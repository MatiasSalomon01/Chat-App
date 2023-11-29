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

    public async Task<List<UsersMessages>> GetUserMessages(int fromUserId, int toUserId)
    {
        return await _context.UsersMessages
            .Include(x => x.Message)
            .Where(x => x.FromUserId == fromUserId && x.ToUserId == toUserId)
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
}
