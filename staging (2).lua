-- Замените URL ниже на прямую ссылку к вашему файлу staging.lua
local SCRIPT_URL = "https://raw.githubusercontent.com/ваш_аккаунт/ваш_репозиторий/main/staging.lua"

-- Лоадер с использованием request (метод GET) и loadstring
local success, err = pcall(function()
    local response = request({
        Url = SCRIPT_URL,
        Method = "GET"
    })
    
    if response.StatusCode ~= 200 then
        error("Не удалось загрузить скрипт. Код ответа: " .. tostring(response.StatusCode))
    end
    
    local scriptCode = response.Body
    local func, loadErr = loadstring(scriptCode)
    
    if not func then
        error("Ошибка компиляции скрипта: " .. tostring(loadErr))
    end
    
    func() -- Выполняем загруженный скрипт
end)

if not success then
    warn("[Loader] Ошибка: " .. tostring(err))
end