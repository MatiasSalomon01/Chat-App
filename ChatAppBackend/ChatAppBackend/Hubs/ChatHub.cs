using Microsoft.AspNetCore.SignalR;

namespace ChatAppBackend.Hubs;

public class ChatHub : Hub
{
    public override async Task OnConnectedAsync()
    {
        //await SendMessage("", "User connected!");
        Console.WriteLine("User connected!");
        await base.OnConnectedAsync();
    }

    public async Task SendMessage(string name, string message)
    {
        await Clients.All.SendAsync("ReceiveMessage", name, message);
    }
}
