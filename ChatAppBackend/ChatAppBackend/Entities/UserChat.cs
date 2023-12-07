namespace ChatAppBackend.Entities;

public class UserChat
{
    public int Id { get; set; }
    public int UserId { get; set; }
    public User User { get; set; }
    public int UserContactId { get; set; }
    public User UserContact { get; set; }
}
