local plugin = PLUGIN
local ix = ix or {}
ix.ATM = ix.ATM or {}

function ix.ATM:GetMoney(pl)
    return pl:GetCharacter():GetData("bATM_Money") or 0
end

function ix.ATM:DepositMoney(pl, amount)
    if !isnumber(amount) then return end
    if IsValid(pl) then
        local char = pl:GetCharacter()
        char:SetMoney(char:GetMoney() - amount)
        char:SetData("bATM_Money", math.abs( char:GetData("bATM_Money", 0) + amount ) )
    end
end

function ix.ATM:WithdrawMoney(pl, amount)
    if !isnumber(amount) then return end
    if IsValid(pl) then
        local char = pl:GetCharacter()
        char:SetMoney(char:GetMoney() + amount)
        char:SetData("bATM_Money", math.abs( char:GetData("bATM_Money", 0) - amount ) )
    end
end

function ix.ATM:AbortMoney(pl)
    if IsValid(pl) then
        local char = pl:GetCharacter()
        if not char then return end
        char:SetData("bATM_Money", 0)
    end
end