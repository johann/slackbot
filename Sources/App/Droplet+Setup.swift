@_exported import Vapor
//import WebSockets
import HTTP



extension Droplet {
    public func setup() throws {
        try setupRoutes()
        // Do any additional droplet setup
        
        if let token = config["slack","slack-token"]?.string {
            print(token)
            let query: [String: NodeRepresentable] = [
                "token": token,
                "simple_latest": true,
                "no_unreads": true
            ]
            let response = try client.get("https://slack.com/api/rtm.start", query: query, ["Accept": "application/json;charset=utf-8"], nil, through: [])
            if let webSocketURL = response.data["url"]?.string {
                
                try client.socket.connect(to: webSocketURL) { ws in
                    ws.onText = { ws, text in
                        
                        print(text)
                    }
                }
                
                
                
                
            } else {
                print("url")
            }
        } else {
            print("couldn't find")
        }
        
        
    
        

    }
}

/*

class ResponseHandler {
    
    var droplet : Droplet!
    init(droplet: Droplet){
        self.droplet = droplet
    }
    
    func handle(event: JSON, inWebSocket webSocket: WebSocket) throws{
        guard
            let channel = event["channel"]?.string,
            let text = event["text"]?.string
            else {
                return
        }
        
        let channelResponse = try droplet.client.get("https://slack.com/api/channels.info", query: ["token":Slack.Config.BotToken,"channel":channel], ["token":Slack.Config.BotToken], nil, through: [])
  
        
        guard let bytes = channelResponse.body.bytes, let channelInfo = Vapor.JSON.parse(bytes)["channel"].object else{
            try send(message: response(toMessage: text), toChannelWithId: channel, inWebSocket: webSocket)
            return
        }
        
        
        try send(message: response(toMessage: text, inChannel: channelInfo),
                 toChannelWithId: channel ,
                 inWebSocket: webSocket)
    }
    
    private func send(message: String?, toChannelWithId channelId: String, inWebSocket webSocket: WebSocket) throws{
        if message != nil{
            var response: JSON = [:]
            response["type"] = JSON("message")
            response["channel"] = JSON(channelId)
            response["text"] = JSON(message!)
            try webSocket.send(JSON.serialize(response).string())
        }
    }
    
    
    // MARK: - Method to override
    
    func response(toMessage text: String) -> String?{
        return "Hey! This is bot."
    }
    
    
    func response(toMessage text: String, inChannel channel: [String: Polymorphic]) -> String?{
        return response(toMessage: text)
    }
    
}
 */
