namespace ChatAppBackend.Entities
{
    public class UsersMessages
    {
        public int Id { get; set; }
        public int FromUserId { get; set; }
        public User FromUser{ get; set; }
        public int MessageId { get; set; }
        public Message Message { get; set; }
        public int ToUserId { get; set; }
        public User ToUser { get; set; }
    }
}
