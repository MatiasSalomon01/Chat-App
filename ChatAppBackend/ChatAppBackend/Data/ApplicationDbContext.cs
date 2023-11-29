using ChatAppBackend.Entities;
using Microsoft.EntityFrameworkCore;

namespace ChatAppBackend.Data;

public class ApplicationDbContext : DbContext
{
	public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options)
	{
	}

	public DbSet<User> Users { get; set; }
	public DbSet<Message> Messages { get; set; }
	public DbSet<UsersMessages> UsersMessages { get; set; }
}
