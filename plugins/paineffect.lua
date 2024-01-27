PLUGIN.name = "Pain Effect"
PLUGIN.description = "Adds a stronger pain effect on player hurt."

-- Звук при получении урона
local painSound = "ambient/levels/labs/electric_explosion1.wav"

-- Длительность блюра в секундах
local blurDuration = 3

-- Кулдаун для воспроизведения звука в секундах
local soundCooldown = 5
local lastSoundTime = 0

-- Хук для воспроизведения звука и добавления эффекта блюра при получении урона
function PLUGIN:PlayerHurt(client, attacker, health, damage)
    -- Проверяем кулдаун для воспроизведения звука
    if CurTime() - lastSoundTime > soundCooldown then
        -- Воспроизводим звук при получении урона
        client:EmitSound(painSound)

        -- Обновляем время последнего воспроизведения звука
        lastSoundTime = CurTime()
    end

    -- Добавляем временный эффект блюра с дрожанием
    if CLIENT then
        local startTime = CurTime()

        hook.Add("RenderScreenspaceEffects", "PainPluginBlur", function()
            local elapsed = CurTime() - startTime

            if elapsed < blurDuration then
                local fraction = elapsed / blurDuration

                -- Увеличиваем силу размытия и добавляем дрожание экрана
                local blurAmount = fraction * 0.2
                DrawMotionBlur(0.05, blurAmount, 0.01)

                -- Интерполируем цветовые настройки для создания эффекта красного оттенка
                local colorFraction = fraction * 0.5
                DrawColorModify({
                    ["$pp_colour_brightness"] = colorFraction * 0.2,
                    ["$pp_colour_contrast"] = 1 - colorFraction * 0.2,
                    ["$pp_colour_colour"] = 1 - colorFraction * 0.2,
                })

                -- Добавляем дрожание экрана
                local shakeAmount = math.sin(CurTime() * 20) * 0.02 * fraction
                local view = {}
                view.origin = EyePos()
                view.angles = EyeAngles() + Angle(shakeAmount, shakeAmount, 0)
                view.fov = GetConVar("fov_desired"):GetFloat()
                render.RenderView(view)
            else
                -- Как только прошло blurDuration секунд, удаляем хук
                hook.Remove("RenderScreenspaceEffects", "PainPluginBlur")
            end
        end)
    end
end
