#include <sourcemod>
#include <csgo_colors>

public void OnPluginStart()
{
	HookEvent("player_disconnect", EventDisc, EventHookMode_Pre);
	
	LoadTranslations("trans.phrases");
}

public void OnClientPostAdminCheck(int client)
{
	if(CheckAdminFlag(client)) CGOPrintToChatAll("%t","AdminConnect", client);
	else CGOPrintToChatAll("%t","ClientConnect", client);
}

public Action EventDisc(Event hEvent, char[] event, bool bdb)
{
	int id = GetClientOfUserId(hEvent.GetInt("userid"));
	if(event[7]=='d')
	{
		if(CheckAdminFlag(id)) CGOPrintToChatAll("%t","AdminDisconnect", id)
		else CGOPrintToChatAll("%t","ClientDisconnect", id);
	}
}

stock bool CheckAdminFlag(int client) {
    AdminId admin = GetUserAdmin(client);
    AdminFlag flag;
    char vadminsflag[] = "b";

    return admin == INVALID_ADMIN_ID ? false : vadminsflag[0] && FindFlagByChar(vadminsflag[0], flag) && GetAdminFlag(admin, flag) ? true : false;
}