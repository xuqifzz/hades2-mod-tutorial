function ValueBetweenIncl(value, a, b)
	return value >= a and value <= b
end

function GetLocalizedValue(default, tbl)
	if tbl == nil then
		return default
	end
	local lang = GetLanguage({})

	for i, item in pairs(tbl) do
		DebugAssert({ Condition = item.Value ~= nil, Owner = "Dexter", Text = "Language-specific property would set value to nil. Data should look like { Code = \"x\", Value = \"yy\" }" })
		if item.Code == lang then
			if item.Condition ~= nil and item.Condition == false then
			else
				return item.Value
			end
		elseif default == nil and item.Code == "en" then
			default = item.Value
		end
	end

	return default
end

function ApplyLocalizedProperties( tbl )
	for k, v in pairs( tbl ) do
		if tbl["Lang"..k] ~= nil then
			local val = GetLocalizedValue( v, tbl["Lang"..k] )
			tbl[k] = val
		end
	end
	return tbl
end

function GetPluralizedForm( text, value )
	local lang = GetLanguage({})

	DebugAssert({ Condition = type(value) == "number", Text = "Parameter 'value' passed to GetPluralizedForm was not a number"})

	-- Unicode pluralization table: 
	-- http://www.unicode.org/cldr/cldr-aux/charts/22/supplemental/language_plural_rules.html
	if lang == "pl" then

		if value == 1 then
			return text
		elseif ValueBetweenIncl( value % 10, 2, 4 ) and not ValueBetweenIncl( value % 100, 12, 14 ) then
			return text.."_Few"
		elseif (value ~= 1 and ValueBetweenIncl( value % 10, 0, 1 )) 
			or ValueBetweenIncl( value % 10, 5, 9 )
			or ValueBetweenIncl( value % 100, 12, 14 ) then
			return text.."_Many"
		else
			return text.."_Other"
		end

	elseif lang == "ru" or lang == "uk" then

		if value % 10 == 1 and value % 100 ~= 11 then
			return text
		elseif ValueBetweenIncl( value % 10, 2, 4 ) and not ValueBetweenIncl( value % 100, 12, 14 ) then
			return text.."_Few"
		elseif value % 10 == 0
			or ValueBetweenIncl( value % 10, 5, 9 )
			or ValueBetweenIncl( value % 100, 11, 14 ) then
			return text.."_Many"
		else
			return text.."_Other"
		end

	else
		if value == 1 then
			return text
		else
			return text.."_Other"
		end
	end
	return text
end