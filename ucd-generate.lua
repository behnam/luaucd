#!/usr/bin/env texlua

kpse.set_program_name("luatex")

require("lualibs")

local function notempty(str,number)
    local value = str ~= "" and str or nil
    if number and value then
        value = tonumber(value:gsub(" ", ""), 16)
    end
    return value
end

local ucd  = { }

local file = io.open("UnicodeData.txt", "r")
for line in file:lines() do
    if not line:find("^#") and not line:is_empty() then
        line = line:split("#")[1]
        local data = line:split(";")
        local code = tonumber(data[1], 16)
        ucd[code]  = {
            name            = notempty(data[2]),
            category        = notempty(data[3]),
            bidiclass       = notempty(data[5]),
            uppercase       = notempty(data[13], true),
            lowrcase        = notempty(data[14], true),
            titlecase       = notempty(data[15], true),
        }
    end
end

file = io.open("BidiMirroring.txt", "r")
for line in file:lines() do
    if not line:find("^#") and not line:is_empty() then
        line = line:split("#")[1]
        local data = line:split(";")
        local code = tonumber(data[1], 16)
        ucd[code].mirror = notempty(data[2], true)
    end
end

file = io.open("ArabicShaping.txt", "r")
for line in file:lines() do
    if not line:find("^#") and not line:is_empty() then
        line = line:split("#")[1]
        local data = line:split(";")
        local code = tonumber(data[1], 16)
        ucd[code].joining = data[3]:gsub(" ", "")
    end
end

file = io.open("LineBreak.txt", "r")
for line in file:lines() do
    if not line:find("^#") and not line:is_empty() then
        line = line:split("#")[1]
        local data = line:split(";")
        if data[1]:find("%.%.") then
        else
            local code = tonumber(data[1], 16)
            ucd[code] = ucd[code] or { }
            ucd[code].linebreak = data[2]:gsub(" ", "")
        end
    end
end

table.tofile("ucd-database.lua", ucd, true)
