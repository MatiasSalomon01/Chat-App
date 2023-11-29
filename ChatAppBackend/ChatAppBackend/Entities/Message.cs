namespace ChatAppBackend.Entities;

public class Message
{
    public int Id { get; set; }
    public string Text { get; set; }
    public DateTime SentAt { get; set; }
    public DateTime UpdatedAt { get; set; }
    public DateTime DeletedAt { get; set; }
}
