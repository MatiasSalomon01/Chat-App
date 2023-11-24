using Microsoft.AspNetCore.SignalR;

namespace ChatAppBackend.Hubs;

public class ChatHub : Hub
{
    public override async Task OnConnectedAsync()
    {
        Console.WriteLine("User connected!");
        await base.OnConnectedAsync();
    }

    public async Task SendAll(string name, string message)
    {
        await Clients.All.SendAsync("ReceiveMessage", new { User = name, Message = message });
    }

    public async Task SendIsTyping(bool isTyping)
    {
        await Clients.Others.SendAsync("ReceiveIsTyping", isTyping);
    }
}
