
PLUGIN.name = "Message Flash"
PLUGIN.description = "Flashes the client's Garry's Mod application when a message is posted in the chat."
PLUGIN.author = "Aspect™"

ix.lang.AddTable("russian", {
	optFlashWindow = "Мигалка для экрана",
	optdFlashWindow = "Должен ли твой значок ГМода в трее мигать, когда загрузка закончится/произойдёт какое-либо событие?"
})

ix.option.Add("flashWindow", ix.type.bool, true, {
	category = "chat"
})

if (CLIENT) then
	function PLUGIN:MessageReceived(client, info)
		if (ix.option.Get("flashWindow", true) and system.IsWindows() and !system.HasFocus()) then
			system.FlashWindow()
		end
	end
end
