#!/usr/bin/env texlua

kpse.set_program_name("luatex")

require("lualibs")

local function notempty(str,number)
    local value = str ~= "" and str or nil
    if number and value then
        value = tonumber("0x"..value:gsub(" ", ""))
    end
    return value
end

local ucd  = { }

local file = io.open("UnicodeData.txt", "r")
for line in file:lines() do
    if not line:find("^#") and not line:is_empty() then
        line = line:split("#")[1]
        local data = line:split(";")
        local code = tonumber("0x"..data[1])
        ucd[code]  = {
            name            = notempty(data[2]),
            category        = notempty(data[3]),
            bidi            = notempty(data[5]),
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
        local code = notempty(data[1], true)
        ucd[code].mirror = notempty(data[2], true)
    end
end

file = io.open("ArabicShaping.txt", "r")
for line in file:lines() do
    if not line:find("^#") and not line:is_empty() then
        line = line:split("#")[1]
        local data = line:split(";")
        local code = notempty(data[1], true)
        ucd[code].joining = data[3]:gsub(" ", "")
    end
end

table.tofile("ucd-database.lua", ucd, true)