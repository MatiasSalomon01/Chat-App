using ChatAppBackend.Hubs;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.SignalR;
using System.Xml.Linq;

namespace ChatAppBackend.Controllers;

[Route("api/[controller]")]
[ApiController]
public class MessageController : ControllerBase
{
    private readonly IHubContext<ChatHub> _hub;

    public MessageController(IHubContext<ChatHub> hub)
    {
        _hub = hub;
    }

    [HttpPost]
    public async Task<IActionResult> SendMessage(string name, string message)
    {
        await  _hub.Clients.All.SendAsync("ReceiveMessage", new { User = name, Message = message });
        return Ok();
    }
}
