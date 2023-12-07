using ChatAppBackend.Entities;
using ChatAppBackend.Hubs;
using ChatAppBackend.Interfaces;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using System.Xml.Linq;

namespace ChatAppBackend.Controllers;

[Route("api/[controller]")]
[ApiController]
public class MessageController : ControllerBase
{
    private readonly IHubContext<ChatHub> _hub;
    private readonly IMessageRepository _repository;

    public MessageController(IHubContext<ChatHub> hub, IMessageRepository repository)
    {
        _hub = hub;
        _repository = repository;
    }

    [HttpPost("send-message")]
    public async Task<IActionResult> SendMessage(string name, string message)
    {
        await  _hub.Clients.All.SendAsync("ReceiveMessage", new { User = name, Message = message });
        return Ok();
    }
    
    [HttpPost("send-message-to")]
    public async Task<IActionResult> SendMessageTo(int toUserId, string text, int fromUserId)
    {
        await _repository.SendMessageTo(toUserId, text, fromUserId);
        return Ok("Enviado correctamente");
    }

    [HttpPost("create-user")]
    public async Task<IActionResult> CreateUser(string name, string profilePicture)
    {
        var user = new User { Name = name, ProfilePicture = profilePicture };
        var userId = await _repository.CreateUser(user);
        return Ok(userId);
    }

    [HttpGet("get-user-messages")]
    public async Task<IActionResult> GetUserMessages(int chatId)
    {
        var usersMessages = await _repository.GetUserMessages(chatId);

        var messages = usersMessages.Select(x => new {x.FromUserId, x.ToUserId, x.Message.Text }).ToList();
        return Ok(messages);
    }
    
    [HttpGet("get-all-chats")]
    public async Task<IActionResult> GetAllChats(int fromUserId)
    {
        var chats = await _repository.GetAllChats(fromUserId);
        return Ok(chats);
    }

    [HttpPost("add-chat-to-user")]
    public async Task<IActionResult> AddChatToUser(int fromUserId, int toUserId)
    {
        await _repository.AddChatToUser(fromUserId, toUserId);
        return Ok();
    }
}
