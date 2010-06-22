require("lualibs")

unicodedata = { }

local ucd
local byte = unicode.utf8.byte
local len  = unicode.utf8.len

if not ucd then
    if file.isreadable("ucd-dat.luc") then
        ucd = dofile("ucd-dat.luc")
    else
        utils.lua.compile("ucd-dat.lua", "ucd-dat.luc")
        ucd = dofile("ucd-dat.luc")
    end
end

local function get_data(char)
    local code

    if type(char) == "string" and len(char) == 1 then
        code = byte(char)
    elseif type(char) == "number" then
        code = char
    else
        return nil, "expected signle character or code point, got '"..type(char).."' instead."
    end
    
    if ucd[code] then
        return ucd[code]
    else
        return nil, "unknown character"
    end
end

function unicodedata.name(char)
    local data, err = get_data(char)
    if data then
        if data.name then
            return data.name
        else
            return nil, "no name"
        end
    else
        return nil, err
    end
end

function unicodedata.bidiclass(char)
    local data, err = get_data(char)
    if data then
        if data.bidiclass then
            return data.bidiclass
        else
            return nil, "no bidi class"
        end
    else
        return nil, err
    end
end

function unicodedata.mirror(char)
    local data, err = get_data(char)
    if data then
        if data.mirror then
            return data.mirror
        else
            return nil, "no bidi mirror"
        end
    else
        return nil, err
    end
end

function unicodedata.script(char)
    local data, err = get_data(char)
    if data then
        if data.script then
            return data.script
        else
            return nil, "no script"
        end
    else
        return nil, err
    end
end

function unicodedata.category(char)
    local data, err = get_data(char)
    if data then
        if data.category then
            return data.category
        else
            return nil, "no category"
        end
    else
        return nil, err
    end
end

function unicodedata.linebreak(char)
    local data, err = get_data(char)
    if data then
        if data.linebreak then
            return data.linebreak
        else
            return nil, "no line break"
        end
    else
        return nil, err
    end
end

function unicodedata.uppercase(char)
    local data, err = get_data(char)
    if data then
        if data.uppercase then
            return data.uppercase
        else
            return nil, "no uppercase"
        end
    else
        return nil, err
    end
end

function unicodedata.lowercase(char)
    local data, err = get_data(char)
    if data then
        if data.lowercase then
            return data.lowercase
        else
            return nil, "no lowercase"
        end
    else
        return nil, err
    end
end

function unicodedata.titlecase(char)
    local data, err = get_data(char)
    if data then
        if data.titlecase then
            return data.titlecase
        else
            return nil, "no titlecase"
        end
    else
        return nil, err
    end
end
