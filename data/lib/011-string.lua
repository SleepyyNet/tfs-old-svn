string.split = function (str)
	local t = {}
	return not str:gsub("%w+", function(s) table.insert(t, s) return "" end):find("%S") and t or {}
end

string.trim = function (str)
	return str:gsub("^%s*(.-)%s*$", "%1")
end

string.explode = function (str, sep, limit)
	if(type(sep) ~= 'string' or isInArray({tostring(str):len(), sep:len()}, 0)) then
		return {}
	end

	local pos, tmp, t = 1, "", {}
	for s, e in function() return string.find(str, sep, pos) end do
		tmp = str:sub(pos, s - 1):trim()
		table.insert(t, tmp)

		pos = e + 1
		if(limit ~= nil and i == limit) then
			break
		end
	end

	tmp = str:sub(pos):trim()
	table.insert(t, tmp)
	return t
end

string.expand = function (str)
	return string.gsub(str, "$(%w+)", function(n) return _G[n] end)
end

string.timediff = function (diff)
	local format = {
		{"week", diff / 60 / 60 / 24 / 7},
		{"day", diff / 60 / 60 / 24 % 7},
		{"hour", diff / 60 / 60 % 24},
		{"minute", diff / 60 % 60},
		{"second", diff % 60}
	}

	local t = {}
	for k, v in ipairs(format) do
		local d, tmp = math.floor(v[2]), ""
		if(d > 0) then
			tmp = (k < table.maxn(format) and (table.maxn(t) > 0 and ", " or "") or " and ") .. d .. " " .. v[1] .. (d ~= 1 and "s" or "")
			table.insert(t, tmp)
		end
	end

	return t
end
