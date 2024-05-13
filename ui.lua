local os = os

local player = game.Players.LocalPlayer
local playerIdsToIgnore = {"", ""} -- IDs das contas para não serem notificadas e evitar flood no webhook

local shouldSend = true

for _, playerIdToIgnore in ipairs(playerIdsToIgnore) do
    if tostring(player.UserId) == playerIdToIgnore then
        shouldSend = false
        break
    end
end

if shouldSend then

    local GetName = game:GetService("MarketplaceService"):GetProductInfo(game.PlaceId)
    local Webhook_URL = "https://webhook.lewisakura.moe/api/webhooks/1239387299503018129/Ygzjacj5yMaLMz5NQY_1qUOKXl7Sni1BjzgOMmLbj5BB-Rbb6GyzZuTZa3nvl6v4KD-w" -- Coloque o link do webhook aqui
    local ImageUrl = "https://imgs.search.brave.com/tYpJk2PJpO90CGvHQGNEEz7NawKBhSMrwbGfcYy2crc/rs:fit:500:0:0/g:ce/aHR0cHM6Ly9paDAu/cmVkYnViYmxlLm5l/dC9pbWFnZS4xNjcy/NjkyNzU5LjU3MDYv/cmFmLDM2MHgzNjAs/MDc1LHQsZmFmYWZh/OmNhNDQzZjQ3ODYu/anBn" -- URL da imagem

    local Headers = {
        ['Content-Type'] = 'application/json',
    }

    local currentTime = os.time()

    currentTime = currentTime + (1 * 3600) -- Adicionando 1 hora em segundos

    currentTime = os.date("%Y-%m-%d %H:%M:%S", currentTime)

    local userToMention = "" -- ID do Discord para mencionar

    local data = {
        ["embeds"] = {{
            ["title"] = "Script Executado em ".. GetName.Name,
            ["description"] = "Nome de Exibição: ".. "(".. player.DisplayName..")".. " Nome: "..  "(" ..player.Name.. ")",
            ["type"] = "rich",
            ["color"] = tonumber(0xDC00FF),
            ["fields"] = {
                {
                    ["name"] = "HWID:",
                    ["value"] = game:GetService("RbxAnalyticsService"):GetClientId(),
                    ["inline"] = true,
                },
                {
                    ["name"] = "Idade da Conta:",
                    ["value"] = player.AccountAge,
                    ["inline"] = false,
                },
                {
                    ["name"] = "ID do Usuário:",
                    ["value"] = player.UserId,
                    ["inline"] = false,
                },
                {
                    ["name"] = "Hora da Execução:",
                    ["value"] = currentTime,
                    ["inline"] = false,
                },
                {
                    ["name"] = "JobId:",
                    ["value"] = game.JobId,
                    ["inline"] = false,
                },
                {
                    ["name"] = "", -- Deixe vazio se não quiser adicionar um nome ao campo
                    ["value"] = "<@!" .. userToMention .. ">", -- Menciona um usuário do Discord
                    ["inline"] = false,
                },
            },
            ["image"] = {
                ["url"] = ImageUrl
            }
        }}
    }

    local PlayerData = game:GetService('HttpService'):JSONEncode(data)

    local Request = http_request or request or HttpPost or syn.request
    Request({Url = Webhook_URL, Body = PlayerData, Method = "POST", Headers = Headers})
end
