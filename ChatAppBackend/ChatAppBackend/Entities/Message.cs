using Microsoft.EntityFrameworkCore.Metadata.Internal;
using System.ComponentModel.DataAnnotations.Schema;

namespace ChatAppBackend.Entities;

public class Message
{
    public int Id { get; set; }
    public string Text { get; set; }
    [Column(TypeName = "timestamp")]
    public DateTime? SentAt { get; set; }
    [Column(TypeName = "timestamp")]
    public DateTime? UpdatedAt { get; set; }
    [Column(TypeName = "timestamp")]
    public DateTime? DeletedAt { get; set; }
}
