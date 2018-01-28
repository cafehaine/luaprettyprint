local lpp = {}

local colors = {
	"\27[0;91m",
	"\27[0;93m",
	"\27[0;92m",
	"\27[0;96m",
	"\27[0;94m",
	"\27[0;95m"
}

local colorReset = "\27[0m"

local function lineColor(line)
	line = math.ceil((line + 1) / 10)
	while line > #colors do
		line = line - #colors
	end
	return colors[line]
end

local function lineNumber(line,color)
	if color then
		return lineColor(line) .. line .. colorReset .. '\t'
	end
	return line .. '\t'
end

local function levelColor(level)
	while level > #colors do
		level = level - #colors
	end
	return colors[level]
end

local toEscape = "[\a\b\f\n\r\t\v\\\"\'%[%]]"

local escapeDic = {
	["\a"] = "\\a",
	["\b"] = "\\b",
	["\f"] = "\\f",
	["\n"] = "\\n",
	["\r"] = "\\r",
	["\t"] = "\\t",
	["\v"] = "\\v",
	["\\"] = "\\\\",
	["\""] = "\\\"",
	["\'"] = "\\'",
	["["] = "\\[",
	["]"] = "\\]"
}

local function format(obj)
	local t = type(obj)
	if t == "string" then
		return '"'..obj:gsub(toEscape, function(a)return escapeDic[a]end)..'"'
	elseif t == "function" then
		return "function"
	elseif t == "userdata" then
		return "userdata ["..tostring(obj).."]"
	elseif t == "number" then
		return tostring(obj)
	else
		return "!! unhandled type !!" .. tostring(obj)
	end
end

local function pprint(before, level, color, table, tableRefs, line)
	for k,v in pairs(table) do
		line = line + 1
		local last = next(table, k) == nil
		local prefix = lineNumber(line,color) .. before
		if color then
			prefix = prefix .. levelColor(level) .. (last and "╰ " or "├ ") .. colorReset
		else
			prefix = prefix .. (last and "╰ " or "├ ")
		end
		if type(v) == "table" then
			if tableRefs[v] == nil then
				print(prefix .. format(k) .. "\t= table")
				tableRefs[v] = line
				if color then
					local subPrefix = before .. levelColor(level) .. (last and "    " or "│   ") .. colorReset

					line = pprint(subPrefix, level + 1, color, v, tableRefs, line)
				else
					line = pprint(before .. (last and "    " or "│   "), level + 1, color, v, tableRefs, line)
				end
			else
				if color then
					print(prefix .. format(k) .. "\t= table at line " .. lineColor(tableRefs[v]) .. tableRefs[v] .. colorReset)
				else
					print(prefix .. format(k) .. "\t= table at line " .. tableRefs[v])
				end
			end
		else
			print(prefix .. format(k) .. "\t= " .. format(v))
		end
		if last then
			line = line + 1
			print(lineNumber(line,color).. before)
		end
	end
	return line
end

function lpp.print(table,color)
	if color then
		print(colors[1].."0\t"..colorReset..tostring(table))
	else
		print("0\t"..tostring(table))
	end
	pprint("",1,color,table,{[table]=0},0)
end

return lpp
